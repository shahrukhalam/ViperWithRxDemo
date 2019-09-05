import Foundation

public typealias JSON = [String: Any]
public typealias JSONArray = [Any]

public protocol JSONInitializable {
    init(json: JSON) throws
}

public protocol JSONArrayInitializable {
    init(jsonArray: JSONArray) throws
}

protocol JSONRawValue {}
extension String: JSONRawValue {}
extension Int: JSONRawValue {}
extension Float: JSONRawValue {}
extension Double: JSONRawValue {}
extension Bool: JSONRawValue {}

struct JSONParser<T> {
    
    private let type: T.Type
    private let json: JSON

    init(type: T.Type, json: JSON) {
        self.json = json
        self.type = type
    }

    func required<Value>(_ key: String) throws -> Value where Value: JSONRawValue {
        guard let typedValue = json[key] as? Value else {
            throw JSONParsingError(modelName: String(describing: type), keyName: key)
        }

        return typedValue
    }

    func optional<Value>(_ key: String) -> Value? where Value: JSONRawValue {
        return json[key] as? Value
    }

}

struct JSONArrayParser<T> {
    
    private let type: T.Type
    private let jsonArray: JSONArray
    
    init(type: T.Type, jsonArray: JSONArray) {
        self.jsonArray = jsonArray
        self.type = type
    }
    
    func filtered<Object>() throws -> [Object] where Object: JSONInitializable {
        guard let jsonArray = jsonArray as? [JSON] else {
            throw JSONParsingError(modelName: String(describing: type),
                                   keyName: String(describing: Object.self))
        }
        
        return jsonArray.compactMap { try? Object(json: $0) }
    }
    
}
