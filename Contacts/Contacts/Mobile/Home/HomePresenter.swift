import Foundation
import RxSwift

protocol HomeViewNavigator {
    func toContactDetail(viewState: ContactViewState)
    func toAddContact(viewState: ContactViewState)
}

protocol HomeDisplayer {
    func setLoading()
    func endRefreshing()
    func update(with viewState: ContactViewStates)
    func attachListener(listener: HomeActionListener)
    func detachListener()
}

struct HomeActionListener {
    let toContactDetailAction: ((ContactViewState) -> Void)?
    let toAddContactAction: (() -> Void)?
    let refreshAction: () -> Void
}

class HomePresenter {
    private let navigator: HomeViewNavigator
    private let displayer: HomeDisplayer
    private let useCase: HomeUseCase
    private let observeScheduler: SchedulerType
    private var disposeBag = DisposeBag()

    init(navigator: HomeViewNavigator,
         displayer: HomeDisplayer,
         useCase: HomeUseCase,
         observeScheduler: SchedulerType = MainScheduler.instance) {
        self.navigator = navigator
        self.displayer = displayer
        self.useCase = useCase
        self.observeScheduler = observeScheduler
    }

    func startPresenting() {
        subscribeToContentState()
        attachListeners()
        
        displayer.setLoading()
        useCase.load()
    }

    func stopPresenting() {
        displayer.detachListener()
        disposeBag = DisposeBag()
    }

    private func subscribeToContentState() {
        useCase
            .dataState()
            .observeOn(observeScheduler)
            .subscribe(
                onNext: { [weak self] viewState in
                    if let viewState = viewState {
                        self?.update(with: viewState)
                    }
            }).disposed(by: disposeBag)
    }
    
    func update(with viewState: ContactViewStates) {
        displayer.update(with: viewState)
    }
    
    private func attachListeners() {
        displayer.attachListener(listener: newListener())
    }

    private func newListener() -> HomeActionListener {
        return HomeActionListener(
            toContactDetailAction: navigateToContactDetail,
            toAddContactAction: navigateToAddContact,
            refreshAction: useCase.load
        )
    }
    
    private func navigateToContactDetail(viewState: ContactViewState) {
        navigator.toContactDetail(viewState: viewState)
    }
    
    func navigateToAddContact() {
        let viewState = ContactViewState.empty()
        navigator.toAddContact(viewState: viewState)
    }

}
