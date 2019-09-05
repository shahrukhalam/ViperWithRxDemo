import UIKit

struct VerticalButtonViewState {
    let image: UIImage
    let title: String
}

extension VerticalButtonViewState {
    static let message = VerticalButtonViewState(image: UIImage(named: "message")!,
                                                 title: "message")
    static let call = VerticalButtonViewState(image: UIImage(named: "call")!,
                                              title: "call")
    static let email = VerticalButtonViewState(image: UIImage(named: "email")!,
                                               title: "email")
    static let favourite = VerticalButtonViewState(image: UIImage(named: "favourite")!,
                                                   title: "favourite")
    static let notFavourite = VerticalButtonViewState(image: UIImage(named: "notFavourite")!,
                                                      title: "favourite")
}

public class VerticalButton: UIControl {
    
    private let icon = UIImageView()
    private let action = UILabel()

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
        addSubview(icon)
        addSubview(action)
    }
    
    func setupViews() {
        action.textAlignment = .center
    }
    
    func applyConstraints() {
        icon.pinToSuperviewTop(constant: 8)
        icon.pinCenterX(to: self)
        icon.pinToSuperview(edges: [.leading, .trailing], constant: 8, relatedBy: .greaterThanOrEqual)
        
        action.pin(edge: .top, to: .bottom, of: icon, constant: 8)
        action.pinToSuperview(edges: [.leading, .trailing], constant: 8)
        action.pinToSuperviewBottom(constant: 8)
    }
    
    func update(with viewState: VerticalButtonViewState, isEnabled: Bool = true) {
        action.text = viewState.title
        
        if isEnabled {
            isUserInteractionEnabled = true
            icon.image = viewState.image
            action.textColor = .black
        } else {
            isUserInteractionEnabled = false
            icon.image = viewState.image.alpha(0.3)
            action.textColor = .lightGray
        }

    }
    
}
