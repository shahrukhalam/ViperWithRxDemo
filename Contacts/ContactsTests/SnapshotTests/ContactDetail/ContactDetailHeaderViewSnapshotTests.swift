import FBSnapshotTestCase
@testable import Contacts

class ContactDetailHeaderViewSnapshotTests: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    func testThatContactDetailHeaderViewWithNoEmailAndNotFavouriteIsCreatedCorrectly() {
        verifyView(with: nil, isFavourite: false)
    }
    
    func testThatContactDetailHeaderViewWithEmailAndFavouriteIsCreatedCorrectly() {
        verifyView(with: "email", isFavourite: true)
    }
    
    func testThatContactDetailHeaderViewWithEmailAndFavouriteIsCreatedCorrectlyForLongName() {
        verifyView(with: "email",
                   firstName:"My name is too long to say, but you can call me:",
                   isFavourite: true)
    }
    
}

extension ContactDetailHeaderViewSnapshotTests {
    
    func verifyView(with email: String?,
                    firstName: String = "Shahrukh",
                    isFavourite: Bool) {
        let view = ContactDetailHeaderView()
        view.addWidthConstraint(constant: 375)
        view.addHeightConstraint(constant: 375)
        
        let contact = Contact.testData(firstName: firstName,
                                       email: email,
                                       favourite: isFavourite)
        let viewState = ContactViewState.testData(contact: contact, isEnabled: false)
        view.update(with: viewState)
        
        FBSnapshotVerifyView(view)
    }
    
}
