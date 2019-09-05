import Foundation

enum GoContactsAPI: APIRequest {
    case home
    case contact(id: String)
    case contactDetail(id: String, isFavourite: Bool)
    case editContact(id: String, params: JSON)
    case addContact(params: JSON)

    var path: String {
        switch self {
        case .home, .addContact:
            return "/contacts.json"
        case .contact(let id), .contactDetail(let id, _):
            return "/contacts/\(id).json"
        case .editContact(let id, _):
            return "/contacts/\(id).json"
        }
    }
    
    var method: Method {
        switch self {
        case .home, .contact:
            return .GET
        case .contactDetail:
            return .PUT
        case .editContact:
            return .PUT
        case .addContact:
            return .POST
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .home, .contact:
            return nil
        case .contactDetail(_, let isFavourite):
            return ["favorite": isFavourite]
        case .editContact(_, let params):
            return params
        case .addContact(let params):
            return params
        }
    }
    
}
