import XCTest
import RxSwift
import RxTest
@testable import Contacts

struct DummyError: Error {}
typealias Event = RxSwift.Event

final class StubUpdateContactDataSource: UpdateContactDataSource {
    
    let scheduler: TestScheduler
    var events: [Recorded<Event<Contact>>] = []

    init(scheduler: TestScheduler) {
        self.scheduler = scheduler
    }

    func contact(for id: String, with params: JSON) -> Observable<Contact> {
        return makeObservable()
    }
    
    func addContact(with params: JSON) -> Observable<Contact> {
        return makeObservable()
    }

    private func makeObservable() -> Observable<Contact> {
        return scheduler
            .createColdObservable(events)
            .asObservable()
    }

}

enum ContactContentStateTypeOnly {
    case initial
    case loading
    case idle
    case error
}

func toTypeOnly(state: ContactContentState) -> ContactContentStateTypeOnly {
    switch state {
    case .initial: return .initial
    case .loading: return .loading
    case .idle: return .idle
    case .error: return .error
    }
}
