import FBSnapshotTestCase
@testable import Contacts

class UpdateContactViewSnapshotTests: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    func testThatUpdateContactViewWithNoEmailIsCreatedCorrectly() {
        verifyView(with: nil)
    }
    
    func testThatUpdateContactViewWithEmailIsCreatedCorrectly() {
        verifyView(with: "email")
    }
    
}

extension UpdateContactViewSnapshotTests {
    
    func verifyView(with email: String?) {
        let view = UpdateContactView()
        view.addWidthConstraint(constant: 375)
        view.addHeightConstraint(constant: 667)
        
        let contact = Contact.testData(email: email)
        let viewState = ContactViewState.testData(contact: contact, isEnabled: true)
        view.update(with: viewState)
        
        FBSnapshotVerifyView(view)
    }
    
}
