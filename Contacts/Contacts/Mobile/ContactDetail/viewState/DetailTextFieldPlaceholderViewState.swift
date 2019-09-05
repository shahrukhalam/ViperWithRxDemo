struct DetailTextFieldPlaceholderViewState: Equatable {
    let placeholder: String
    let description: String
}

extension DetailTextFieldPlaceholderViewState {
    
    init(type: DetailTextFieldType) {
        switch type {
        case .firstName:
            self = DetailTextFieldPlaceholderViewState.firstName
        case .lastName:
            self = DetailTextFieldPlaceholderViewState.lastName
        case .email:
            self = DetailTextFieldPlaceholderViewState.email
        case .phoneNumber:
            self = DetailTextFieldPlaceholderViewState.phoneNumber
        }
    }
    
    static let phoneNumber = DetailTextFieldPlaceholderViewState(
        placeholder: "Enter Valid Phone Number",
        description: "Phone")
    static let email = DetailTextFieldPlaceholderViewState(
        placeholder: "Enter Valid Email ID",
        description: "Email")
    static let firstName = DetailTextFieldPlaceholderViewState(
        placeholder: "First Name (Min 2 char)",
        description: "First Name")
    static let lastName = DetailTextFieldPlaceholderViewState(
        placeholder: "Last Name (Min 2 char)",
        description: "Last Name")
}

enum DetailTextFieldType: String {
    case firstName = "first_name"
    case lastName = "last_name"
    case phoneNumber = "phone_number"
    case email = "email"
}
