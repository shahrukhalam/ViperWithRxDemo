import UIKit

class UpdateContactNavigator: NSObject {
    
    private let viewstate: ContactViewState
    private let type: UpdateContactType

    lazy var updateViewController: UpdateContactViewController = {
        return UpdateContactViewController(navigator: self,
                                           viewState: self.viewstate,
                                           type: type)
    }()
    
    lazy var navController: UINavigationController = {
        let navController = UINavigationController(rootViewController: self.updateViewController)
        navController.navigationBar.tintColor = Constants.appTintColor
        navController.navigationBar.isTranslucent = false
        return navController
    }()
    
    init(viewstate: ContactViewState, type: UpdateContactType) {
        self.viewstate = viewstate
        self.type = type
    }
    
}

extension UpdateContactNavigator: UpdateContactViewNavigator {
    
    func toUIImagePicker() {
        let picker = UIImagePickerController()
        picker.delegate = updateViewController
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        navController.present(picker, animated: true, completion: nil)
    }
    
    func toGoBack() {
        navController.dismiss(animated: true, completion: nil)
    }
    
    func toErrorMessage(withTitle: String?, withMessage: String?, okButton: String?) {
        Utilities.shared.showAlertMessage(withTitle: withTitle,
                                          withMessage: withMessage,
                                          okButton: okButton,
                                          controller: navController.topViewController)
    }
    
    func toSuccessMessage(withTitle: String?, withMessage: String?, okButton: String?) {
        Utilities.shared.showAlertMessage(withTitle: withTitle,
                                          withMessage: withMessage,
                                          okButton: okButton,
                                          handler: handler(),
                                          controller: navController.topViewController)
    }
    
    private func handler() -> ActionHandler {
        return { [weak self] _ in
            self?.navController.dismiss(animated: true, completion: nil)
        }
    }
    
}
