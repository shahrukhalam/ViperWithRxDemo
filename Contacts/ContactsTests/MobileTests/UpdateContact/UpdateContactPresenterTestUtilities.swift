import RxSwift
import RxTest
@testable import Contacts

class MockUseCase: UpdateContactUseCase {
    
    private let scheduler: TestScheduler
    let contentStateObservable: TestableObservable<ContactContentState>
    
    init(scheduler: TestScheduler) {
        self.scheduler = scheduler
        
        let viewState = ContactViewState.testData()
        self.contentStateObservable = scheduler.createColdObservable(
            [ next(100, .initial(viewState)),
              next(150, .loading(viewState)),
              next(200, .idle(viewState)),
              next(250, .error(viewState, DummyError())),
              completed(300) ])
    }
    
    func dataContentStateObservable() -> Observable<ContactContentState> {
        return contentStateObservable.asObservable()
    }
    func update(for id: String, with params: JSON) { }
    func updateTextField(for keyType: DetailTextFieldType, with text: String) { }
    func update(with params: JSON) { }
    func validate() -> TextFieldMessageType { return .valid }
    var viewState: ContactViewState?
    
}

class MockNavigator: UpdateContactViewNavigator {
    
    var toGoBackCalled = false
    var toUIImagePickerCalled = false
    var toErrorMessageCalled = false
    var toSuccessMessageCalled = false
    
    func toGoBack() {
        toGoBackCalled = true
    }
    
    func toUIImagePicker() {
        toUIImagePickerCalled = true
    }
    
    func toErrorMessage(withTitle: String?, withMessage: String?, okButton: String?) {
        toErrorMessageCalled = true
    }
    
    func toSuccessMessage(withTitle: String?, withMessage: String?, okButton: String?) {
        toSuccessMessageCalled = true
    }
    
}

class MockDisplayer: UpdateContactDisplayer {
    
    var lastUpdatedTime: Int = 0
    var lastViewState: ContactViewState?
    var setLoadingCalled = false
    var hideLoadingCalled = false
    var listener: UpdateContactActionListener?
    
    private let scheduler: TestScheduler
    
    init(scheduler: TestScheduler) {
        self.scheduler = scheduler
    }
    
    func update(with viewState: ContactViewState) {
        lastUpdatedTime = scheduler.clock
        lastViewState = viewState
    }
    
    func update(with image: UIImage) { }
    
    func setLoading() {
        setLoadingCalled = true
    }
    
    func hideLoading() {
        hideLoadingCalled = true
    }
    
    func attachListener(listener: UpdateContactActionListener) {
        self.listener = listener
    }
    
    func detachListener() { }
    
}
