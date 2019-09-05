@testable import Contacts

extension DetailTextFieldViewState {
    
    static func testData(type: DetailTextFieldType = .firstName,
                         text: String? = nil,
                         isEnabled: Bool = true)
        -> DetailTextFieldViewState {
            return DetailTextFieldViewState(type: type,
                                            text: text,
                                            isEnabled: isEnabled)
    }
    
}
