@testable import Contacts

extension Contacts {
    
    static func testData(users: [Contact] = [Contact.testData()]) -> Contacts {
        return Contacts(users: users)
    }
    
}
