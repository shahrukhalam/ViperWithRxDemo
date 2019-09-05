import XCTest
@testable import Contacts

class ContactViewStateTests: XCTestCase {
    
    func testThatContactViewStateHasCorrectContactWhenNil() {
        let viewState = ContactViewState.testData(contact: nil)
        XCTAssertNil(viewState.contact)
    }
    
    func testThatContactViewStateHasCorrectContact() {
        let contact = Contact.testData()
        let viewState = ContactViewState.testData(contact: contact)
        XCTAssertEqual(viewState.contact, contact)
    }
    
    func testThatContactViewStateHasCorrectIsEnabled() {
        let viewState = ContactViewState.testData(isEnabled: false)
        XCTAssertFalse(viewState.isEnabled)
    }
    
    func testThatContactViewStateHasCorrectFirstName() {
        let contact = Contact.testData(firstName: "firstName")
        let viewState = ContactViewState.testData(contact: contact)
        XCTAssertEqual(viewState.firstName, "firstName")
    }
    
    func testThatContactViewStateHasCorrectEmailWhenNil() {
        let contact = Contact.testData(email: nil)
        let viewState = ContactViewState.testData(contact: contact)
        XCTAssertNil(viewState.email)
    }
    
    func testThatContactViewStateHasCorrectEmail() {
        let contact = Contact.testData(email: "email")
        let viewState = ContactViewState.testData(contact: contact)
        XCTAssertEqual(viewState.email, "email")
    }
    
    func testThatContactViewStateHasCorrectNameAttributedStringWhenNil() {
        let viewState = ContactViewState.testData(contact: nil)
        XCTAssertNil(viewState.nameAttributedString())
    }
    
    func testThatContactViewStateHasCorrectNameAttributedString() {
        let contact = Contact.testData(firstName: "firstName", lastName: "lastName")
        let viewState = ContactViewState.testData(contact: contact)
        XCTAssertEqual(viewState.nameAttributedString()?.string, "firstName lastName")
    }
    
    func testThatContactViewStateHasCorrectEmailViewState() {
        let contact = Contact.testData(email: "email")
        let viewState = ContactViewState.testData(contact: contact)
        
        let expectedViewState = DetailTextFieldViewState.testData(type: .email, text: "email")
        XCTAssertEqual(viewState.emailViewState, expectedViewState)
    }
    
    func testThatContactViewStateHasCorrectEmailViewStateWhenEmailTextIsNil() {
        let contact = Contact.testData(email: nil)
        let viewState = ContactViewState.testData(contact: contact)
        
        let expectedViewState = DetailTextFieldViewState.testData(type: .email, text: nil)
        XCTAssertEqual(viewState.emailViewState, expectedViewState)
    }
    
    func testThatContactViewStateHasCorrectEmailViewStateWhenContactIsNil() {
        let viewState = ContactViewState.testData(contact: nil)
        
        let expectedViewState = DetailTextFieldViewState.testData(type: .email, text: nil)
        XCTAssertEqual(viewState.emailViewState, expectedViewState)
    }
    
}
