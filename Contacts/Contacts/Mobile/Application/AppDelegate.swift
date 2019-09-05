import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    fileprivate let mainNavigator: MainNavigator
    var window: UIWindow?
    
    override convenience init() {
        let mainNavigator = MainNavigator()
        self.init(mainNavigator: mainNavigator)
    }
    
    init(mainNavigator: MainNavigator) {
        self.mainNavigator = mainNavigator
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        setupWindow()
        guard let window = window else {
            return false
        }
        mainNavigator.toStart(inWindow: window)
        
        return true
    }

}

extension AppDelegate {
    
    fileprivate func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
    }

}

