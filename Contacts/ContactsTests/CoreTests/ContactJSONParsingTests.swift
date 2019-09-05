import XCTest
@testable import Contacts

class ContactJSONParsingTests: XCTestCase {
    
    private let contact = Contact.testDataFromJSON()
    private let contactWithOptionals = Contact.testDatawithOptionalsFromJSON()
    
    func testIfIDisParsedCorrectly() {
        XCTAssertEqual(contact.id, 2202)
    }

    func testIfFirstNameisParsedCorrectly() {
        XCTAssertEqual(contact.firstName, "Alam")
    }

    func testIfLastNameisParsedCorrectly() {
        XCTAssertEqual(contact.lastName, "Shahrukh")
    }

    func testIfEmailisParsedCorrectly() {
        XCTAssertEqual(contact.email, "alam.shahrukh786@gmail.com")
    }

    func testIfPhoneNumberisParsedCorrectly() {
        XCTAssertEqual(contact.phoneNumber, "7349127046")
    }

    func testIfProfilePicURLisParsedCorrectly() {
        XCTAssertEqual(contact.profilePictureEndPoint, "/images/missing.png")
    }

    func testIfFavouriteisParsedCorrectly() {
        XCTAssertFalse(contact.favourite)
    }

    func testIfContactURLisParsedCorrectly() {
        let expectedURL = "http://gojek-contacts-app.herokuapp.com/contacts/2202.json"
        XCTAssertEqual(contact.url, expectedURL)
    }
    
    func testIfEmailisParsedCorrectlyWhenNil() {
        XCTAssertNil(contactWithOptionals.email)
    }
    
    func testIfPhoneNumberisParsedCorrectlyWhenNil() {
        XCTAssertNil(contactWithOptionals.phoneNumber)
    }
    
    func testIfProfilePicURLisParsedCorrectlyWhenNil() {
        XCTAssertNil(contactWithOptionals.profilePictureEndPoint)
    }
    
    func testIfContactURLisParsedCorrectlyWhenNil() {
        XCTAssertNil(contactWithOptionals.url)
    }
    
}
