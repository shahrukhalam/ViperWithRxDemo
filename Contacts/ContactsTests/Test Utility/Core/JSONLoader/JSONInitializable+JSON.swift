@testable import Contacts

extension JSONInitializable {
    
    static func loadFromJSON(named filename: String) -> Self {
        do {
            let json = JSONLoader().loadJSONOrFail(name: filename)
            return try Self(json: json)
        } catch let error {
            preconditionFailure("\(error)")
        }
    }

}

extension JSONArrayInitializable {
    
    static func loadFromJSON(named filename: String) -> Self {
        do {
            let jsonArray = JSONLoader().loadJSONArrayOrFail(name: filename)
            return try Self(jsonArray: jsonArray)
        } catch let error {
            preconditionFailure("\(error)")
        }
    }
    
}
