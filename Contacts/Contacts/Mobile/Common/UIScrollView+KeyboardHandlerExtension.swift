import UIKit

protocol ScrollViewExtensionProtocol {
    func scrollViewExtensionTapped() -> Void
}

extension UIScrollView {
    
    struct CustumProperties{
        static var totalRect = CGRect()
        static var activeRect = CGRect()
        static var viewUp = false
        static var scrollViewExtensionDelegate: ScrollViewExtensionProtocol?
    }
    
    func registerForKeyboardNotifications() -> Void {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(notification:)), name: .UIKeyboardWillHide, object: nil)
        
        let scrollViewTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(scrollViewTapped(_:)))
        scrollViewTapGestureRecognizer.numberOfTapsRequired = 1
        self.addGestureRecognizer(scrollViewTapGestureRecognizer)
    }
    
    @objc func scrollViewTapped(_ sender: UITapGestureRecognizer) {
        CustumProperties.scrollViewExtensionDelegate?.scrollViewExtensionTapped()
    }
    
    func deRegisterForKeyboardNotifications() -> Void {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardDidShow(notification:NSNotification) -> Void {
        
        let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        
        let edgeInset = UIEdgeInsetsMake(0, 0, (keyboardSize?.height)!, 0)
        self.contentInset = edgeInset

        var visibleRect = CustumProperties.totalRect
        visibleRect.size.height -= (keyboardSize?.height)!
        
        let isVisible = visibleRect.contains(CGPoint(x:CustumProperties.activeRect.origin.x, y: CustumProperties.activeRect.origin.y + CustumProperties.activeRect.size.height))
        
        if !isVisible {
            
            let scrollPoint = CGPoint(x: 0, y: CustumProperties.activeRect.origin.y + CustumProperties.activeRect.height - visibleRect.height)
            
            self.setContentOffset(scrollPoint, animated: true)
        }
        
        CustumProperties.viewUp = true
    }
    
    @objc func keyboardDidHide(notification:NSNotification) -> Void {
        if CustumProperties.viewUp {
            self.contentInset = UIEdgeInsets.zero
            self.scrollIndicatorInsets = UIEdgeInsets.zero
            CustumProperties.viewUp = false
        }
    }

}
