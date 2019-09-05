import Foundation

struct JSONParsingError: Error {
    let modelName: String
    let keyName: String
}

extension JSONParsingError: CustomStringConvertible {
    var description: String {
        return "Couldn't parse '\(keyName)' key for type '\(modelName)'"
    }
}

extension JSONParsingError: Equatable {
    static func == (lhs: JSONParsingError, rhs: JSONParsingError) -> Bool {
        return lhs.modelName == rhs.modelName &&
        lhs.keyName == rhs.keyName
    }
}
