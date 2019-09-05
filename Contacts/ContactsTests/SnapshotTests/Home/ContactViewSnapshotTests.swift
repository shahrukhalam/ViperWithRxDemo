import FBSnapshotTestCase
@testable import Contacts

class ContactViewSnapshotTests: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    func testThatContactViewIsCreatedCorrectly() {
        verifyView(with: false)
    }
    
    func testThatContactViewWithFavouriteIsCreatedCorrectly() {
        verifyView(with: true)
    }
    
    func testThatContactViewIsCreatedCorrectlyForLongName() {
        verifyView(firstName:"My name is too long to say", with: true)
    }

}

extension ContactViewSnapshotTests {
    
    func verifyView(firstName: String = "Shahrukh", with isFavourite: Bool) {
        let view = ContactView()
        view.addWidthConstraint(constant: 375)
        let contact = Contact.testData(firstName: firstName,
                                       favourite: isFavourite)
        let viewState = ContactViewState.testData(contact: contact)
        view.update(with: viewState)
        FBSnapshotVerifyView(view)
    }
    
}
