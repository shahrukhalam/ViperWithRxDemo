import Foundation
import RxSwift

protocol HomeUseCase {
    func dataState() -> Observable<ContactViewStates?>
    func load()
}

final class GoHomeUseCase: HomeUseCase {

    private let homeDataSource: HomeDataSource
    fileprivate let homeDataState = Variable<ContactViewStates?>(nil)

    fileprivate var disposeBag = DisposeBag()
    fileprivate let scheduler: SchedulerType

    init(homeDataSource: HomeDataSource,
         observeScheduler: SchedulerType = SerialDispatchQueueScheduler(qos: .background)) {

        self.homeDataSource = homeDataSource
        self.scheduler = observeScheduler
    }

    func dataState() -> Observable<ContactViewStates?> {
        return homeDataState
            .asObservable()
            .share()
    }
    
    func load() {
        homeDataSource
            .home()
            .catchErrorJustReturn(try! Contacts(jsonArray: []))
            .map(viewStateFactory)
            .bind(to: homeDataState)
            .disposed(by: disposeBag)
    }
    
    func viewStateFactory(contacts: Contacts) -> ContactViewStates {
        let contacts = contacts.users.map { ContactViewState(contact: $0, isEnabled: false) }
        return ContactViewStates(contacts: contacts)
    }

}
