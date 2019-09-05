import UIKit

class MainNavigator: NSObject {

    fileprivate let homeNavigator = HomeNavigator()
    fileprivate var window: UIWindow?
    
    func toStart(inWindow mainWindow: UIWindow) {
        window = mainWindow
        window?.backgroundColor = .white
        window?.rootViewController = homeNavigator.navController
        window?.makeKeyAndVisible()
    }

}
