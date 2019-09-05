import Foundation

public struct Contacts {
    public let users: [Contact]
}

extension Contacts: JSONArrayInitializable {
    public init(jsonArray: JSONArray) throws {
        let parser = JSONArrayParser(type: Contacts.self, jsonArray: jsonArray)
        self.users = try parser.filtered()
    }
}
