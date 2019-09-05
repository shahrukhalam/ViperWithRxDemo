@testable import Contacts

extension Contact {

    static func testData(
        id: Int = 1,
        firstName: String = "Shahrukh",
        lastName: String = "Alam",
        email: String? = nil,
        phoneNumber: String? = nil,
        profilePictureEndPoint: String? = nil,
        favourite: Bool = false,
        url: String = "https://gojek-contacts-app.herokuapp.com/contacts/1.json") -> Contact {
        return Contact(id: id,
                       firstName: firstName,
                       lastName: lastName,
                       email: email,
                       phoneNumber: phoneNumber,
                       profilePictureEndPoint: profilePictureEndPoint,
                       favourite: favourite,
                       url: url)
    }

}
