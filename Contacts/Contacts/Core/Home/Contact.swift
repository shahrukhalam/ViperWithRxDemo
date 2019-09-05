import Foundation

public struct Contact: Equatable {
    public let id: Int
    public let firstName: String
    public let lastName: String
    public let email: String?
    public let phoneNumber: String?
    public let profilePictureEndPoint: String?
    public let favourite: Bool
    public let url: String?
}

extension Contact: JSONInitializable {
    public init(json: JSON) throws {
        let parser = JSONParser(type: Contact.self, json: json)
        self.id = try parser.required("id")
        self.firstName = try parser.required("first_name")
        self.lastName = try parser.required("last_name")
        self.email = parser.optional("email")
        self.phoneNumber = parser.optional("phone_number")
        self.profilePictureEndPoint = parser.optional("profile_pic")
        self.favourite = try parser.required("favorite")
        self.url = parser.optional("url")
    }
}
