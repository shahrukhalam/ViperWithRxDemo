import FBSnapshotTestCase
@testable import Contacts

class HomeViewSnapshotTests: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    func testThatHomeViewWithNoContactsIsCreatedCorrectly() {
        verifyView(with: [])
    }
    
    func testThatHomeViewIsCreatedCorrectly() {
        let firstContact = Contact.testData(firstName: "firstName1",
                                            lastName: "lastName1",
                                            favourite: false)
        let secondContact = Contact.testData(firstName: "firstName2",
                                            lastName: "lastName2",
                                            favourite: true)
        let contacts =
            [ContactViewState.testData(contact: firstContact),
             ContactViewState.testData(contact: secondContact)]
        
        verifyView(with: contacts)
    }
    
}

extension HomeViewSnapshotTests {
    
    func verifyView(with contacts: [ContactViewState]) {
        let view = HomeView()
        view.addWidthConstraint(constant: 375)
        view.addHeightConstraint(constant: 667)
        
        let viewState = ContactViewStates.testData(contacts: contacts)
        view.update(with: viewState)
        
        FBSnapshotVerifyView(view)
    }
    
}
