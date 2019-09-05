import Foundation
import UIKit

struct ContactViewState: Equatable {
    
    public let contact: Contact?
    
    public var firstName: String?
    public var lastName: String?
    public var email: String?
    public var phoneNumber: String?
    
    public let isEnabled: Bool
    
    init(contact: Contact?, isEnabled: Bool) {
        self.contact = contact
        
        self.firstName = contact?.firstName
        self.lastName = contact?.lastName
        self.email = contact?.email
        self.phoneNumber = contact?.phoneNumber
        
        self.isEnabled = isEnabled
    }
    
    static func empty() -> ContactViewState {
        return ContactViewState(contact: nil, isEnabled: true)
    }
    
}

extension ContactViewState {

    func nameAttributedString() -> NSAttributedString? {
        guard let firstName = firstName, let lastName = lastName else { return nil }
        
        let name = firstName + " " + lastName
        let nameElement = TextElement(text: name,
                                      style: nameStyle)
        
        return nameElement.attributedString()
    }
    
    private var nameStyle: TextStyle {
        return TextStyle(
            color: .black,
            font: UIFont.systemFont(ofSize: 20.0),
            align: .left)
    }
    
    var phoneViewState: DetailTextFieldViewState {
        return DetailTextFieldViewState(
            type: .phoneNumber,
            text: phoneNumber,
            isEnabled: isEnabled)
    }
    
    var emailViewState: DetailTextFieldViewState {
        return DetailTextFieldViewState(
            type: .email,
            text: email,
            isEnabled: isEnabled)
    }
    
    var firstNameViewState: DetailTextFieldViewState {
        return DetailTextFieldViewState(
            type: .firstName,
            text: firstName,
            isEnabled: isEnabled)
    }
    
    var lastNameViewState: DetailTextFieldViewState {
        return DetailTextFieldViewState(
            type: .lastName,
            text: lastName,
            isEnabled: isEnabled)
    }

}
