import Foundation
import RxSwift

enum TextFieldMessageType {
    case invalid(DetailTextFieldType)
    case valid
}

protocol UpdateContactUseCase {
    func dataContentStateObservable() -> Observable<ContactContentState>
    
    func update(for id: String, with params: JSON)
    func updateTextField(for keyType: DetailTextFieldType, with text: String)
    
    func update(with params: JSON)
    
    func validate() -> TextFieldMessageType
    
    var viewState: ContactViewState? { get }
}

final class GoUpdateContactUseCase: UpdateContactUseCase {
    
    private let dataSource: UpdateContactDataSource
    private let contentState: Variable<ContactContentState>
    
    private let utility = Utilities.shared
    var updatedViewState: ContactViewState
    
    var viewState: ContactViewState? {
        return contentState.value.viewState
    }
    
    fileprivate var disposeBag = DisposeBag()
    fileprivate let scheduler: SchedulerType
    
    init(dataSource: UpdateContactDataSource,
         viewState: ContactViewState,
         observeScheduler: SchedulerType = SerialDispatchQueueScheduler(qos: .background)) {
        self.dataSource = dataSource
        self.contentState = Variable(.initial(viewState))
        self.updatedViewState = viewState
        self.scheduler = observeScheduler
    }
    
    func dataContentStateObservable() -> Observable<ContactContentState> {
        return contentState
            .asObservable()
            .distinctUntilChanged()
            .share()
    }
    
    func update(for id: String, with params: JSON) {
        dataSource
            .contact(for: id, with: params)
            .map(viewStateFactory)
            .toContentState(existingData: contentState.value.viewState)
            .bind(to: contentState)
            .disposed(by: disposeBag)
    }
    
    func update(with params: JSON) {
        dataSource
            .addContact(with: params)
            .map(viewStateFactory)
            .toContentState(existingData: contentState.value.viewState)
            .bind(to: contentState)
            .disposed(by: disposeBag)
    }
    
    func updateTextField(for keyType: DetailTextFieldType, with text: String) {
        switch keyType {
        case .firstName:
            updatedViewState.firstName = text
        case .lastName:
            updatedViewState.lastName = text
        case .email:
            updatedViewState.email = text
        case .phoneNumber:
            updatedViewState.phoneNumber = text
        }
    }
    
    func validate() -> TextFieldMessageType {
        guard let firstName = updatedViewState.firstName, firstName.count > 2
            else { return .invalid(.firstName) }
        
        guard let lastName = updatedViewState.lastName, lastName.count > 2
            else { return .invalid(.lastName) }
        
        guard utility.validate(phoneNumber: updatedViewState.phoneNumber)
            else { return .invalid(.phoneNumber) }

        guard utility.validate(email: updatedViewState.email)
            else { return .invalid(.email) }
        
        return .valid
    }
    
    func viewStateFactory(contact: Contact) -> ContactViewState {
        let updatedViewState = ContactViewState(contact: contact, isEnabled: true)
        return updatedViewState
    }
    
}
