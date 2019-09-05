import Foundation
import RxSwift

protocol ContactDetailUseCase {
    func dataStateObservable() -> Observable<ContactViewState?>
    func update(for id: String, with isFavourite: Bool)
    func refresh(for id: String)
    var viewState: ContactViewState { get }
}

final class GoContactDetailUseCase: ContactDetailUseCase {
    
    private let dataSource: ContactDetailDataSource
    fileprivate let dataState = Variable<ContactViewState?>(nil)
    
    var viewState: ContactViewState
    
    fileprivate var disposeBag = DisposeBag()
    fileprivate let scheduler: SchedulerType
    
    init(dataSource: ContactDetailDataSource,
         viewState: ContactViewState,
         observeScheduler: SchedulerType = SerialDispatchQueueScheduler(qos: .background)) {
        self.dataSource = dataSource
        self.viewState = viewState
        self.scheduler = observeScheduler
    }
    
    func dataStateObservable() -> Observable<ContactViewState?> {
        return dataState
            .asObservable()
            .distinctUntilChanged()
            .share()
            .startWith(viewState)
    }
    
    func update(for id: String, with isFavourite: Bool) {
        dataSource
            .contact(for: id, with: isFavourite)
            .catchError(returnExistingViewState)
            .map(viewStateFactory)
            .bind(to: dataState)
            .disposed(by: disposeBag)
    }
    
    func refresh(for id: String) {
        dataSource
            .contact(for: id)
            .catchError(returnExistingViewState)
            .map(viewStateFactory)
            .bind(to: dataState)
            .disposed(by: disposeBag)
    }
    
    func returnExistingViewState(error: Error) -> Observable<Contact> {
        guard let contact = viewState.contact else { return Observable.empty() }
        return Observable.just(contact)
    }
    
    func viewStateFactory(contact: Contact) -> ContactViewState {
        let updatedViewState = ContactViewState(contact: contact, isEnabled: false)
        viewState = updatedViewState
        return updatedViewState
    }
    
}
