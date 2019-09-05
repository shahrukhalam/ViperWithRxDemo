import UIKit

extension UIImage {

    public func tint(with color: UIColor, imageSize: CGSize? = nil) -> UIImage {
        let requiredImageSize: CGSize
        if let size = imageSize {
            requiredImageSize = size
        } else {
            requiredImageSize = size
        }

        let image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(requiredImageSize, false, scale)
        color.set()

        image.draw(in: CGRect(origin: .zero, size: requiredImageSize))
        guard let imageFromContext = UIGraphicsGetImageFromCurrentImageContext() else {
            assertionFailure("Tinted image could not be returned")
            return image
        }
        UIGraphicsEndImageContext()
        return imageFromContext
    }
    
    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }

}
