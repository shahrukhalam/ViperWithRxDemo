@testable import Contacts

extension ContactViewStates {
    
    static func testData(contacts: [ContactViewState] = [])
        -> ContactViewStates {
        return ContactViewStates(contacts: contacts)
    }
    
}
