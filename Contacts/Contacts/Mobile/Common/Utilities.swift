import Foundation
import UIKit

typealias ActionHandler = ((UIAlertAction) -> Swift.Void)?

class Utilities: NSObject {
    
    static let shared = Utilities()
    
    func validate(phoneNumber: String?) -> Bool {
        guard let phoneNumber = phoneNumber else { return false }
        
        let phoneRegex = "^\\d{3}\\d{3}\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        let result =  phoneTest.evaluate(with: phoneNumber)
        return result
    }
    
    func showAlertMessage(withTitle: String?,
                          withMessage: String?,
                          okButton: String?,
                          handler: ActionHandler = nil,
                          controller: UIViewController?) -> Void {
        let alertController = UIAlertController(title: withTitle,
                                                message: withMessage,
                                                preferredStyle:.alert)
        
        let defaultAction = UIAlertAction(title: okButton, style: .default, handler: handler)
        alertController.addAction(defaultAction)
        
        controller?.present(alertController, animated: true, completion: nil)
    }
    
    func validate(email: String?) -> Bool {
        guard let email = email else { return false }
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }

}
