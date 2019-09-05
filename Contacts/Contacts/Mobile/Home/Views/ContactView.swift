import UIKit

public class ContactView: UIView, ReusableView {
    private let name = UILabel()
    private let profilePicture = URLImageView()
    private let favourite = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        backgroundColor = .white
        addSubview(name)
        addSubview(profilePicture)
        addSubview(favourite)
        
        applyConstraints()
    }
    
    func applyConstraints() {
        profilePicture.addSizeConstraint(size: CGSize(width: 75, height: 75))
        profilePicture.pinToSuperview(edges: [.leading, .top, .bottom], constant: 8)
        
        name.pin(edge: .leading, to: .trailing, of: profilePicture, constant: 8)
        name.pinCenterY(to: self)
        favourite.pin(edge: .leading, to: .trailing, of: name, constant: 8)
        
        favourite.addSizeConstraint(size: CGSize(width: 20, height: 20))
        favourite.pinCenterY(to: self)
        favourite.pinToSuperviewTrailing(constant: 8)
    }
    
    func update(with viewState: ContactViewState) {
        let profilePictureEndPoint = viewState.contact?.profilePictureEndPoint
        profilePicture.update(with: profilePictureEndPoint)
        
        name.attributedText = viewState.nameAttributedString()
        
        if let isFavourite = viewState.contact?.favourite, isFavourite {
            favourite.image = UIImage(named: "favouriteHome")
        }
    }
    
    public func prepareForReuse() {
        profilePicture.reset()
    }
    
}
