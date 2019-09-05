import UIKit

class GradientView: UIView {
    
    override open class var layerClass: AnyClass {
        get{
            return CAGradientLayer.classForCoder()
        }
    }
    
    func setup(with startColor: UIColor = .white, and endColor: UIColor = Constants.appTintColor) {
        let gradientLayer = self.layer as! CAGradientLayer        
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    
}
