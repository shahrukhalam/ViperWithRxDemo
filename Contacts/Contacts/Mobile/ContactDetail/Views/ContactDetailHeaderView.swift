import UIKit

protocol ContactDetailHeaderViewActions: class {
    func messageAction()
    func callAction()
    func emailAction()
    func favouriteAction()
}

public class ContactDetailHeaderView: UIView {
    private let gradient = GradientView()
    private let profilePicture = URLImageView()
    private let name = UILabel()
    private let actionContainer = UIView()

    private let messageButton = VerticalButton()
    private let callButton = VerticalButton()
    private let emailButton = VerticalButton()
    private let favouriteButton = VerticalButton()
    
    weak var delegate: ContactDetailHeaderViewActions?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addSubViews()
        setupViews()
        applyConstraints()
    }
    
    func addSubViews() {
        addSubview(gradient)
        addSubview(profilePicture)
        addSubview(name)
        
        actionContainer.addSubview(messageButton)
        actionContainer.addSubview(callButton)
        actionContainer.addSubview(emailButton)
        actionContainer.addSubview(favouriteButton)
        addSubview(actionContainer)
    }
    
    func setupViews() {
        gradient.setup()
                
        messageButton.addTarget(self, action: #selector(messageAction), for: .touchUpInside)
        callButton.addTarget(self, action: #selector(callAction), for: .touchUpInside)
        emailButton.addTarget(self, action: #selector(emailAction), for: .touchUpInside)
        favouriteButton.addTarget(self, action: #selector(favouriteAction), for: .touchUpInside)
    }
    
    func applyConstraints() {
        gradient.pinToSuperviewEdges()
        
        profilePicture.addSizeConstraint(size: CGSize(width: 100, height: 100))
        profilePicture.pinCenter(to: self)
        
        name.pin(edge: .top, to: .bottom, of: profilePicture, constant: 8)
        name.pinCenterX(to: self)
        name.pinToSuperview(edges: [.leading, .trailing], constant: 8, relatedBy: .greaterThanOrEqual)
        
        applyConstraintsForActionContainerSubViews()
        actionContainer.pinCenterX(to: self)
        actionContainer.pinToSuperviewBottom(constant: 8)
    }
    
    func applyConstraintsForActionContainerSubViews() {
        messageButton.pinToSuperview(edges: [.leading, .top, .bottom])
        messageButton.pin(edge: .trailing, to: .leading, of: callButton, constant: -20)
        
        callButton.pinToSuperview(edges: [.top, .bottom])
        callButton.pin(edge: .trailing, to: .leading, of: emailButton, constant: -20)
        
        emailButton.pinToSuperview(edges: [.top, .bottom])
        emailButton.pin(edge: .trailing, to: .leading, of: favouriteButton, constant: -20)
        
        favouriteButton.pinToSuperview(edges: [.top, .bottom])
        favouriteButton.pinToSuperviewTrailing()
    }
    
    func update(with viewState: ContactViewState) {
        let profilePictureEndPoint = viewState.contact?.profilePictureEndPoint
        profilePicture.update(with: profilePictureEndPoint)
        
        name.attributedText = viewState.nameAttributedString()
        
        let isPhoneNumber: Bool
        if viewState.contact?.phoneNumber == nil {
            isPhoneNumber = false
        } else {
            isPhoneNumber = true
        }
        messageButton.update(with: VerticalButtonViewState.message, isEnabled: isPhoneNumber)
        callButton.update(with: VerticalButtonViewState.call, isEnabled: isPhoneNumber)

        let isEmail: Bool
        if viewState.contact?.email == nil {
            isEmail = false
        } else {
            isEmail = true
        }
        emailButton.update(with: VerticalButtonViewState.email, isEnabled: isEmail)

        guard let isFavourite = viewState.contact?.favourite
            else { preconditionFailure("Must have Favourite") }
        if isFavourite {
            favouriteButton.update(with: VerticalButtonViewState.favourite, isEnabled: true)
        } else {
            favouriteButton.update(with: VerticalButtonViewState.notFavourite, isEnabled: true)
        }
    }
    
    @objc func messageAction() {
        delegate?.messageAction()
    }
    
    @objc func callAction() {
        delegate?.callAction()
    }
    
    @objc func emailAction() {
        delegate?.emailAction()
    }
    
    @objc func favouriteAction() {
        delegate?.favouriteAction()
    }
    
}
