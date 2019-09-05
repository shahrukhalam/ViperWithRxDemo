import Foundation
@testable import Contacts

enum JSONLoaderError: Error {
    case loadJSONFileError(message: String, file: StaticString, line: UInt)
    case parseJSONError(message: String)
}

public class JSONLoader {

    public init() {}

    private func loadFile(name: String,
                          ofType type: String,
                          file: StaticString = #file,
                          line: UInt = #line) throws -> Data {
        let bundle = Bundle(for: Swift.type(of: self))

        guard let path = bundle.path(forResource: name, ofType: type),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                let message: String
                if let bundleIdentifier = bundle.bundleIdentifier {
                    message = "Couldn't load file named \(name).\(type) in bundle \(bundleIdentifier)"
                } else {
                    message = "Couldn't load file named \(name).\(type)"
                }

                throw JSONLoaderError.loadJSONFileError(message: message, file: file, line: line)
        }
        return data
    }

    public func loadJSON(name: String, file: StaticString = #file, line: UInt = #line) throws -> JSON {
        let data = try loadFile(name: name, ofType: "json", file: file, line: line)
        guard let json = (try JSONSerialization.jsonObject(with: data, options: [])) as? JSON
            else {
            throw JSONLoaderError.parseJSONError(message: "Couldn't parse JSON file named \(name).json")
        }
        return json
    }
    
    public func loadJSONArray(name: String, file: StaticString = #file, line: UInt = #line) throws -> JSONArray {
        let data = try loadFile(name: name, ofType: "json", file: file, line: line)
        guard let jsonArray = (try JSONSerialization.jsonObject(with: data, options: [])) as? JSONArray else {
            throw JSONLoaderError.parseJSONError(message: "Couldn't parse JSON file named \(name).json")
        }
        
        return jsonArray
    }

}
