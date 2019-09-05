import UIKit

class HomeNavigator: NSObject {

    lazy var homeViewController: HomeViewController = {
        return HomeViewController(navigator: self)
    }()
    
    lazy var navController: UINavigationController = {
        let navController = UINavigationController(rootViewController: self.homeViewController)
        navController.navigationBar.tintColor = Constants.appTintColor
        navController.navigationBar.isTranslucent = false
        return navController
    }()

}

extension HomeNavigator: HomeViewNavigator {
    
    func toContactDetail(viewState: ContactViewState) {
        let viewController = ContactDetailViewController(navigator: self,
                                                         viewState: viewState)
        navController.pushViewController(viewController, animated: true)
    }
    
    func toAddContact(viewState: ContactViewState) {
        let navigator = UpdateContactNavigator(viewstate: viewState, type: .add)
        navController.present(navigator.navController, animated: true)
    }
    
}

extension HomeNavigator: ContactDetailViewNavigator {
    
    func toEditContactDetail(viewState: ContactViewState) {
        let navigator = UpdateContactNavigator(viewstate: viewState, type: .edit)
        navController.present(navigator.navController, animated: true, completion: nil)
    }
    
    func messageAction(for number: String) {
        open(for: number, type: .sms)
    }
    
    func callAction(for number: String) {
        open(for: number, type: .call)
    }
    
    func emailAction(for email: String) {
        open(for: email, type: .mail)
    }
    
    private func open(for urlString: String, type: ActionTypes) {
        guard let url = URL(string: type.rawValue + urlString) else { return }
        UIApplication.shared.openURL(url)
    }
    
}

enum ActionTypes: String {
    case mail = "mailto:/"
    case call = "tel://"
    case sms = "sms:"
}
