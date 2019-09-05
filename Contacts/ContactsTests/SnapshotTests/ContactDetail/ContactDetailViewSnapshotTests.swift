import FBSnapshotTestCase
@testable import Contacts

class ContactDetailViewSnapshotTests: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    func testThatContactDetailViewWithNoEmailAndNotFavouriteIsCreatedCorrectly() {
        verifyView(with: nil, isFavourite: false)
    }
    
    func testThatContactDetailViewWithEmailAndFavouriteIsCreatedCorrectly() {
        verifyView(with: "email", isFavourite: true)
    }
    
}

extension ContactDetailViewSnapshotTests {
    
    func verifyView(with email: String?, isFavourite: Bool) {
        let view = ContactDetailView()
        view.addWidthConstraint(constant: 375)
        view.addHeightConstraint(constant: 667)
        
        let contact = Contact.testData(email: email, favourite: isFavourite)
        let viewState = ContactViewState.testData(contact: contact, isEnabled: false)
        view.update(with: viewState)
        
        FBSnapshotVerifyView(view)
    }
    
}
