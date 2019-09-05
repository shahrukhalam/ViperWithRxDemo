import Foundation
import RxSwift

protocol ContactDetailViewNavigator {
    func toEditContactDetail(viewState: ContactViewState)
    func messageAction(for number: String)
    func callAction(for number: String)
    func emailAction(for email: String)
}

protocol ContactDetailDisplayer {
    func setLoading()
    func hideLoading()
    func update(with viewState: ContactViewState)
    func attachListener(listener: ContactDetailActionListener)
    func detachListener()
}

struct ContactDetailActionListener {
    let messageAction: (() -> Void)?
    let callAction: (() -> Void)?
    let emailAction: (() -> Void)?
    let favouriteAction: (() -> Void)?
}

class ContactDetailPresenter {
    private let navigator: ContactDetailViewNavigator
    private let displayer: ContactDetailDisplayer
    private let useCase: ContactDetailUseCase
    private let observeScheduler: SchedulerType
    private var disposeBag = DisposeBag()
    
    init(navigator: ContactDetailViewNavigator,
         displayer: ContactDetailDisplayer,
         useCase: ContactDetailUseCase,
         observeScheduler: SchedulerType = MainScheduler.instance) {
        self.navigator = navigator
        self.displayer = displayer
        self.useCase = useCase
        self.observeScheduler = observeScheduler
    }
    
    func startPresenting() {
        subscribeToContentState()
        attachListeners()
    }
    
    func refreshIfNeeded() {
        guard let id = useCase.viewState.contact?.id else { return }
        useCase.refresh(for: "\(id)")
    }
    
    func stopPresenting() {
        displayer.detachListener()
        disposeBag = DisposeBag()
    }
    
    private func subscribeToContentState() {
        useCase
            .dataStateObservable()
            .observeOn(observeScheduler)
            .subscribe(
                onNext: { [weak self] viewState in
                    if let viewState = viewState {
                        self?.update(with: viewState)
                    }
            }).disposed(by: disposeBag)
    }
    
    func update(with viewState: ContactViewState) {
        displayer.update(with: viewState)
    }
    
    private func attachListeners() {
        displayer.attachListener(listener: newListener())
    }
    
    private func newListener() -> ContactDetailActionListener {
        return ContactDetailActionListener(
            messageAction: messageAction,
            callAction: callAction,
            emailAction: emailAction,
            favouriteAction: favouriteAction
        )
    }
    
    func navigateToEditContactDetail() {
        let editableViewState = ContactViewState(contact: useCase.viewState.contact, isEnabled: true)
        navigator.toEditContactDetail(viewState: editableViewState)
    }
    
    private func messageAction() {
        guard let number = useCase.viewState.contact?.phoneNumber else { return }
        navigator.messageAction(for: number)
    }
    
    private func callAction() {
        guard let number = useCase.viewState.contact?.phoneNumber else { return }
        navigator.callAction(for: number)
    }
    
    private func emailAction() {
        guard let email = useCase.viewState.contact?.email else { return }
        navigator.emailAction(for: email)
    }
    
    private func favouriteAction() {
        guard let id = useCase.viewState.contact?.id,
            let isFavourite = useCase.viewState.contact?.favourite else { return }
        displayer.setLoading()
        useCase.update(for: "\(id)", with: !isFavourite)
    }
    
}
