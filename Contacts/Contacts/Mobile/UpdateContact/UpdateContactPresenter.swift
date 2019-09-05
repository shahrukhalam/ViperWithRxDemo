import Foundation
import RxSwift

protocol UpdateContactViewNavigator {
    func toGoBack()
    func toUIImagePicker()
    func toErrorMessage(withTitle: String?, withMessage: String?, okButton: String?)
    func toSuccessMessage(withTitle: String?, withMessage: String?, okButton: String?)
}

protocol UpdateContactDisplayer {
    func setLoading()
    func hideLoading()
    func update(with viewState: ContactViewState)
    func update(with image: UIImage)
    func attachListener(listener: UpdateContactActionListener)
    func detachListener()
}

struct UpdateContactActionListener {
    let toUIImagePickerAction: (() -> Void)?
    let updateTextFieldAction: ((DetailTextFieldType?, String?) -> Void)?
}

class UpdateContactPresenter {
    private let navigator: UpdateContactViewNavigator
    private let displayer: UpdateContactDisplayer
    private let useCase: UpdateContactUseCase
    private let type: UpdateContactType
    private let observeScheduler: SchedulerType
    private var disposeBag = DisposeBag()
    
    private var params = JSON()
    
    init(navigator: UpdateContactViewNavigator,
         displayer: UpdateContactDisplayer,
         useCase: UpdateContactUseCase,
         type: UpdateContactType,
         observeScheduler: SchedulerType = MainScheduler.instance) {
        self.navigator = navigator
        self.displayer = displayer
        self.useCase = useCase
        self.type = type
        self.observeScheduler = observeScheduler
    }
    
    func startPresenting() {
        subscribeToContentState()
        attachListeners()
    }
    
    func stopPresenting() {
        displayer.detachListener()
        disposeBag = DisposeBag()
    }
    
    private func subscribeToContentState() {
        useCase
            .dataContentStateObservable()
            .observeOn(observeScheduler)
            .debug()
            .subscribe(
                onNext: { [weak self] contentState in
                    self?.update(with: contentState)
            })
            .disposed(by: disposeBag)
    }
    
    func update(with contentState: ContactContentState) {
        switch contentState {
        case .initial(let viewState):
            displayer.update(with: viewState)
        case .idle(let viewState):
            displayer.update(with: viewState)
            navigator.toSuccessMessage(withTitle: "Success",
                                       withMessage: "Contact is updated Successfully",
                                       okButton: "Okay")
        case .loading:
            displayer.setLoading()
        case .error:
            displayer.hideLoading()
            navigator.toErrorMessage(withTitle: "Failure",
                                     withMessage: "Unable to update the contact currently",
                                     okButton: "Cancel")
        }
    }
    
    private func attachListeners() {
        displayer.attachListener(listener: newListener())
    }
    
    private func newListener() -> UpdateContactActionListener {
        return UpdateContactActionListener(
            toUIImagePickerAction: navigateToUIImagePickerAction,
            updateTextFieldAction: updateTextFieldAction
        )
    }
    
    func goBack() {
        navigator.toGoBack()
    }
    
    func update(with image: UIImage) {
        displayer.update(with: image)
    }
    
    func save() {
        guard params.count > 0 else {
            navigator.toGoBack()
            return
        }
        
        let validator = useCase.validate()
        switch validator {
        case .valid:
            switch type {
            case .add: addContact()
            case .edit: updateContact()
            }
        case .invalid(let type):
            navigator.toErrorMessage(withTitle: "Invalid",
                                     withMessage: "Please enter correct \(type.rawValue)",
                                     okButton: "Cancel")
        }
    }
    
    private func updateContact() {
        guard let id = useCase.viewState?.contact?.id else {
            navigator.toGoBack()
            return
        }
        
        useCase.update(for: "\(id)", with: params)
    }
    
    private func addContact() {
        useCase.update(with: params)
    }
    
    private func navigateToUIImagePickerAction() {
        navigator.toUIImagePicker()
    }
    
    private func updateTextFieldAction(for keyType: DetailTextFieldType?, with text: String?) {
        guard let keyType = keyType, let text = text else { return }
        
        useCase.updateTextField(for: keyType, with: text)
        params[keyType.rawValue] = text
    }
    
}
