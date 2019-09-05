import UIKit

protocol DetailTextFieldDelegate: class {
    func textFieldDidBeginEditing(_ textField: TextField)
    func textFieldDidChange(_ textField: TextField)
}

public class DetailTextField: UIView {
    
    private let descriptionLabel = UILabel()
    private let textField = TextField()
    private let separator = UIView()
    
    weak var delegate: DetailTextFieldDelegate? {
        didSet {
            textField.delegate = self
        }
    }

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
        addSubview(descriptionLabel)
        addSubview(textField)
        addSubview(separator)
    }
    
    func setupViews() {
        backgroundColor = .white
        descriptionLabel.textColor = .gray
        descriptionLabel.textAlignment = .right
        textField.borderStyle = .none
        separator.backgroundColor = .gray
        
        textField.addTarget(self,
                            action: #selector(textFieldDidChange),
                            for: UIControlEvents.editingChanged)
    }
    
    func applyConstraints() {
        addHeightConstraint(constant: 50)
        
        descriptionLabel.pinToSuperviewLeading(constant: 10)
        descriptionLabel.pinCenterY(to: textField)
        descriptionLabel.addWidthConstraint(constant: 100)
        
        textField.pin(edge: .leading, to: .trailing, of: descriptionLabel, constant: 32)
        textField.pinToSuperview(edges: [.trailing, .top])
        textField.pin(edge: .bottom, to: .top, of: separator)
        
        separator.pinToSuperviewLeading(constant: 10)
        separator.addHeightConstraint(constant: 1)
        separator.pinToSuperview(edges: [.bottom, .trailing])
    }
    
    func update(with viewState: DetailTextFieldViewState) {
        textField.placeholder = viewState.placeholderViewState.placeholder
        textField.text = viewState.text
        textField.isUserInteractionEnabled = viewState.isEnabled
        textField.backgroundColor = viewState.isEnabled ? .white : .groupTableViewBackground
        descriptionLabel.text = viewState.placeholderViewState.description
        
        textField.fieldType = viewState.type
    }
    
}

extension DetailTextField: UITextFieldDelegate {
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.textFieldDidBeginEditing(textField as! TextField)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        delegate?.textFieldDidChange(textField as! TextField)
    }
    
}

class TextField: UITextField {
    var fieldType: DetailTextFieldType?
}
