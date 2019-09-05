import XCTest
import RxSwift
import RxTest
@testable import Contacts

final class UpdateContactPresenterTests: XCTestCase {
    
    var scheduler: TestScheduler!
    var displayer: MockDisplayer!
    var presenter: UpdateContactPresenter!
    var useCase: MockUseCase!
    var navigator: MockNavigator!
    
    override func setUp() {
        super.setUp()
        
        scheduler = TestScheduler(initialClock: 0)
        useCase = MockUseCase(scheduler: scheduler)
        displayer = MockDisplayer(scheduler: scheduler)
        navigator = MockNavigator()
        
        presenter = UpdateContactPresenter(navigator: navigator,
                                           displayer: displayer,
                                           useCase: useCase,
                                           type: .edit,
                                           observeScheduler: scheduler)
    }
    
    func testItSubscribesAndUnsubscribesToContentState() {
        scheduler.advanceTo(5)
        presenter.startPresenting()
        scheduler.advanceTo(100)
        presenter.stopPresenting()
        
        let subscription = useCase.contentStateObservable.subscriptions[0]
        
        XCTAssertEqual(subscription.subscribe, 5)
        XCTAssertEqual(subscription.unsubscribe, 100)
    }
    
    func testThatItProvidesAViewStateInitially() {
        presenter.startPresenting()
        scheduler.advanceTo(160)
        
        XCTAssertNotNil(displayer.lastViewState)
        XCTAssertEqual(displayer.lastUpdatedTime, 101)
    }
    
    func testThatItUpdatesViewOnLoading() {
        presenter.startPresenting()
        scheduler.advanceTo(160)
        XCTAssertTrue(displayer.setLoadingCalled)
    }
    
    func testThatItUpdatesViewOnIdle() {
        presenter.startPresenting()
        scheduler.advanceTo(210)
        XCTAssertEqual(displayer.lastUpdatedTime, 201)
    }
    
    func testThatItShowsSuccessAlertOnIdle() {
        presenter.startPresenting()
        scheduler.advanceTo(210)
        XCTAssertTrue(navigator.toSuccessMessageCalled)
    }
    
    func testThatItUpdatesViewOnError() {
        presenter.startPresenting()
        scheduler.advanceTo(260)
        XCTAssertTrue(displayer.hideLoadingCalled)
    }
    
    func testThatItShowsFailureAlertOnError() {
        presenter.startPresenting()
        scheduler.advanceTo(260)
        XCTAssertTrue(navigator.toErrorMessageCalled)
    }
    
    func testThatPresenterNavigatesToUIImagePickerCorrectly() {
        presenter.startPresenting()
        displayer.listener?.toUIImagePickerAction?()
        XCTAssertTrue(navigator.toUIImagePickerCalled)
    }
    
    func testThatPresenterNavigatesBackCorrectly() {
        presenter.goBack()
        XCTAssertTrue(navigator.toGoBackCalled)
    }

}
