struct DetailTextFieldViewState: Equatable {
    let type: DetailTextFieldType
    let placeholderViewState: DetailTextFieldPlaceholderViewState
    let text: String?
    let isEnabled: Bool
}

extension DetailTextFieldViewState {
    
    init(type: DetailTextFieldType, text: String?, isEnabled: Bool) {
        self.type = type
        self.placeholderViewState = DetailTextFieldPlaceholderViewState(type: type)
        self.text = text
        self.isEnabled = isEnabled
    }

}
