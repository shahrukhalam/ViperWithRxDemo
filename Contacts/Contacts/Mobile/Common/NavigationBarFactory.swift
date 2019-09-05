import UIKit

class NavigationBarFactory: NSObject {
    
    static func setupBarButton(with image: UIImage?,
                               target: Any?,
                               action: Selector?,
                               renderingMode: UIImageRenderingMode = .automatic) -> UIBarButtonItem {
        let barButton = UIBarButtonItem(
            image: image?.withRenderingMode(renderingMode),
            style: .plain,
            target: target,
            action: action
        )
        return barButton
    }
    
    static func setupSystemBarButton(with type: UIBarButtonSystemItem,
                                     target: Any?,
                                     action: Selector?) -> UIBarButtonItem {
        let barButton = UIBarButtonItem(barButtonSystemItem: type,
                                        target: target,
                                        action: action)
        return barButton
    }
    
    static func backBarButtonWithoutTitle() -> UIBarButtonItem {
        let barButton = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil)
        return barButton
    }
}
