import Foundation
@testable import Contacts

private enum ContactJSON: String {
    case standard = "contact"
    case withOptionals = "contact-with-optionals"
}

extension Contact {
    
    static func testDataFromJSON() -> Contact {
        return Contact.load(json: .standard)
    }
    
    static func testDatawithOptionalsFromJSON() -> Contact {
        return Contact.load(json: .withOptionals)
    }
    
    private static func load(json: ContactJSON) -> Contact {
        return Contact.loadFromJSON(named: json.rawValue)
    }

}
