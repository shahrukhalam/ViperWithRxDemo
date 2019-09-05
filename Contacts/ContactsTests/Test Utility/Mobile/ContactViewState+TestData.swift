@testable import Contacts

extension ContactViewState {
    
    static func testData(contact: Contact? = nil,
                         isEnabled: Bool = true) -> ContactViewState {
        return ContactViewState(contact: contact, isEnabled: isEnabled)
    }
    
}
