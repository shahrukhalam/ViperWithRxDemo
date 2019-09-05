import XCTest
@testable import Contacts

class DetailTextFieldViewStateTests: XCTestCase {
    
    func testThatDetailTextFieldHasCorrectPlaceholderViewState() {
        let viewState = DetailTextFieldViewState.testData(type: .phoneNumber)
        let expectedViewState = DetailTextFieldPlaceholderViewState(type: .phoneNumber)
        XCTAssertEqual(viewState.placeholderViewState, expectedViewState)
    }
    
    func testThatDetailTextFieldHasCorrectTextWhenNil() {
        let viewState = DetailTextFieldViewState.testData(text: nil)
        XCTAssertNil(viewState.text)
    }
    
    func testThatDetailTextFieldHasCorrectText() {
        let viewState = DetailTextFieldViewState.testData(text: "text")
        XCTAssertEqual(viewState.text, "text")
    }
    
    func testThatDetailTextFieldHasCorrectisEnabled() {
        let viewState = DetailTextFieldViewState.testData(isEnabled: false)
        XCTAssertFalse(viewState.isEnabled)
    }
    
}
