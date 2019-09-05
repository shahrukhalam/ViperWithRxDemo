@testable import Contacts

extension DetailTextFieldPlaceholderViewState {
    
    static func testData(placeholder: String = "placeholder",
                         description: String = "description")
        -> DetailTextFieldPlaceholderViewState {
            return DetailTextFieldPlaceholderViewState(placeholder: placeholder,
                                                       description: description)
    }
    
}
