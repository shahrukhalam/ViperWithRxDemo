import XCTest
@testable import Contacts

class DetailTextFieldPlaceholderViewStateTests: XCTestCase {
    
    private let expectedViewState = DetailTextFieldPlaceholderViewState(type: .phoneNumber)

    func testThatDetailTextFieldHasCorrectPlaceholder() {
        let viewState = DetailTextFieldPlaceholderViewState.testData(
            placeholder: "Enter Valid Phone Number")
        let expectedPlaceholder = expectedViewState.placeholder
        XCTAssertEqual(viewState.placeholder, expectedPlaceholder)
    }
    
    func testThatDetailTextFieldHasCorrectDescription() {
        let viewState = DetailTextFieldPlaceholderViewState.testData(
            description: "Phone")
        let expectedDescription = expectedViewState.description
        XCTAssertEqual(viewState.description, expectedDescription)
    }
    
}
