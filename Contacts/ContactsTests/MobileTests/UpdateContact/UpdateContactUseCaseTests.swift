import XCTest
import RxSwift
import RxTest
@testable import Contacts

final class UpdateContactUseCaseTests: XCTestCase {
    fileprivate var scheduler: TestScheduler!
    fileprivate var disposeBag: DisposeBag!
    fileprivate var observer: TestableObserver<ContactContentStateTypeOnly>!
    fileprivate var dataSource: StubUpdateContactDataSource!
    fileprivate var useCase: GoUpdateContactUseCase!

    override func setUp() {
        super.setUp()

        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
        observer = scheduler.createObserver(ContactContentStateTypeOnly.self)
        dataSource = StubUpdateContactDataSource(scheduler: scheduler)

        useCase = GoUpdateContactUseCase(dataSource: dataSource,
                                         viewState: ContactViewState.testData(),
                                         observeScheduler: scheduler)

        useCase.dataContentStateObservable()
            .map(toTypeOnly)
            .subscribe(observer)
            .disposed(by: disposeBag)
    }
    
    func testContentStateWhenInitialResponse() {
        scheduler.start()
        
        let expectedEvents: [Recorded<Event<ContactContentStateTypeOnly>>] = [ next(0, .initial) ]
        
        XCTAssertEqual(observer.events, expectedEvents)
    }
    
    func testContentStateWhenIdleResponse() {
        dataSource.events = [ next(1, Contact.testData()) ]
        
        useCase.update(for: "", with: [:])
        scheduler.start()
        
        let expectedEvents: [Recorded<Event<ContactContentStateTypeOnly>>] =
            [ next(0, .initial),
              next(0, .loading),
              next(1, .idle) ]
        
        XCTAssertEqual(observer.events, expectedEvents)
    }
    
    func testContentStateWhenLoadingAndError() {
        dataSource.events = [ error(10, DummyError()) ]
        
        useCase.update(for: "", with: [:])
        scheduler.advanceTo(20)
        
        let expectedEvents: [Recorded<Event<ContactContentStateTypeOnly>>] =
            [ next(0, .initial),
              next(0, .loading),
              next(10, .error) ]
        
        XCTAssertEqual(observer.events, expectedEvents)
    }

}
