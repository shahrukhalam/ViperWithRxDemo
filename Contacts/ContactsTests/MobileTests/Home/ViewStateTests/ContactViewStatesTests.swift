import XCTest
@testable import Contacts

class ContactViewStatesTests: XCTestCase {
    
    func testItHasCorrectContactViewStates() {
        let expectedViewStates =
            [ContactViewState.testData(contact: nil, isEnabled: true),
             ContactViewState.testData(contact: Contact.testData(), isEnabled: false)]
        
        let viewState = ContactViewStates.testData(contacts: expectedViewStates)
        XCTAssertEqual(viewState.contacts, expectedViewStates)
    }
    
    func testItHasCorrectContactViewStatesInitailly() {
        let emptyContactViewStates: [ContactViewState] = []
        let expectedViewState = ContactViewStates.testData(contacts: emptyContactViewStates)
        XCTAssertEqual(ContactViewStates.initialState(), expectedViewState)
    }

}
