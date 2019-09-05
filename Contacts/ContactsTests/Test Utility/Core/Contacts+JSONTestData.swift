import Foundation
@testable import Contacts

private enum ContactsJSON: String {
    case standard = "contacts"
}

extension Contacts {
    
    static func testDataFromJSON() -> Contacts {
        return Contacts.load(json: .standard)
    }
    
    private static func load(json: ContactsJSON) -> Contacts {
        return Contacts.loadFromJSON(named: json.rawValue)
    }
    
}
