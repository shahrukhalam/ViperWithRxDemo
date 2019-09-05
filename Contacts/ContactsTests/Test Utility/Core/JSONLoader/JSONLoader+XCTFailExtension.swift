import XCTest
@testable import Contacts

extension JSONLoader {
    func loadJSONOrFail(name: String) -> JSON {
        do {
            return try loadJSON(name: name)
        } catch let error {
            XCTFail("\(error)")
            return [:]
        }
    }
    
    func loadJSONArrayOrFail(name: String) -> JSONArray {
        do {
            return try loadJSONArray(name: name)
        } catch let error {
            XCTFail("\(error)")
            return []
        }
    }

}
