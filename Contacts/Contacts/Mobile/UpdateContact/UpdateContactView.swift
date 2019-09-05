import UIKit

class UpdateContactView: UIView, UpdateContactDisplayer {
    
    private var actionListener: UpdateContactActionListener?
    
    private let scrollView = UIScrollView()
    private let scrollViewContainer = UIView()
    
    private let headerGradient = GradientView()
    private let profilePic = URLImageView()
    private let camera = UIImageView()
    
    private let firstNameTextField = DetailTextField()
    private let lastNameTextField = DetailTextField()
    private let phoneTextField = DetailTextField()
    private let emailTextField = DetailTextField()
    
    private let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("This view is not designed to be used with xib or storyboard files")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupForKeyboard()
    }
    
    func attachListener(listener: UpdateContactActionListener) {
        actionListener = listener
    }
    
    func detachListener() {
        actionListener = nil
    }
    
    private func setup() {
        addSubViews()
        setupViews()
        applyConstraints()
    }
    
    private func addSubViews() {
        addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
    }
    
    private func setupViews() {
        backgroundColor = .white
        activityIndicator.color = .white
        
        headerGradient.setup()
        
        profilePic.image = UIImage(named: "placeholderProfilePicture")
        camera.image = UIImage(named: "camera")
        profilePic.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        profilePic.isUserInteractionEnabled = true
        profilePic.addGestureRecognizer(tapGestureRecognizer)
        
        setupScrollView()
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        phoneTextField.delegate = self
    }
    
    private func applyConstraints() {
        scrollView.pinToSuperviewEdges()
        applyConstraintsForContainer()
    }
    
    private func setupScrollView() {
        
        scrollView.showsVerticalScrollIndicator = false
        
        scrollViewContainer.addSubview(headerGradient)
        scrollViewContainer.addSubview(profilePic)
        scrollViewContainer.addSubview(camera)
        
        scrollViewContainer.addSubview(firstNameTextField)
        scrollViewContainer.addSubview(lastNameTextField)
        scrollViewContainer.addSubview(phoneTextField)
        scrollViewContainer.addSubview(emailTextField)
        
        scrollViewContainer.addSubview(activityIndicator)
    }
    
    private func setupForKeyboard() {
        UIScrollView.CustumProperties.totalRect = CGRect(x: 0, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
        
        scrollView.registerForKeyboardNotifications()
        UIScrollView.CustumProperties.scrollViewExtensionDelegate = self
    }
    
    private func applyConstraintsForContainer() {
        scrollViewContainer.pinToSuperviewEdges()
        scrollViewContainer.setWidthEqualToWidth(of: scrollView)
        
        headerGradient.pinToSuperview(edges: [.leading, .trailing, .top])
        headerGradient.addHeightConstraint(constant: Constants.width * (9/16))
        
        profilePic.addSizeConstraint(size: CGSize(width: 100, height: 100))
        profilePic.pinCenter(to: headerGradient)
        
        camera.pin(edge: .leading, to: .trailing, of: profilePic, constant: -41)
        camera.pin(edge: .top, to: .bottom, of: profilePic, constant: -41)
        
        firstNameTextField.pin(edge: .top, to: .bottom, of: headerGradient)
        firstNameTextField.pinToSuperview(edges: [.leading, .trailing])

        lastNameTextField.pin(edge: .top, to: .bottom, of: firstNameTextField)
        lastNameTextField.pinToSuperview(edges: [.leading, .trailing])

        phoneTextField.pin(edge: .top, to: .bottom, of: lastNameTextField)
        phoneTextField.pinToSuperview(edges: [.leading, .trailing])
        
        emailTextField.pin(edge: .top, to: .bottom, of: phoneTextField)
        emailTextField.pinToSuperview(edges: [.leading, .trailing, .bottom])
        
        activityIndicator.pinCenter(to: scrollViewContainer)
    }
    
    func update(with viewState: ContactViewState) {
        hideLoading()
        
        let profilePictureEndPoint = viewState.contact?.profilePictureEndPoint
        profilePic.update(with: profilePictureEndPoint)
        
        firstNameTextField.update(with: viewState.firstNameViewState)
        lastNameTextField.update(with: viewState.lastNameViewState)
        phoneTextField.update(with: viewState.phoneViewState)
        emailTextField.update(with: viewState.emailViewState)
    }
    
    func update(with image: UIImage) {
        profilePic.image = image
    }
    
    func setLoading() {
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
    }
    
    @objc private func imageTapped() {
        actionListener?.toUIImagePickerAction?()
    }
    
    deinit {
        scrollView.deRegisterForKeyboardNotifications()
        UIScrollView.CustumProperties.scrollViewExtensionDelegate = nil
    }
    
}

extension UpdateContactView: DetailTextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: TextField) {
        UIScrollView.CustumProperties.activeRect = textField.frame
    }

    func textFieldDidChange(_ textField: TextField) {
        actionListener?.updateTextFieldAction?(textField.fieldType,
                                               textField.text)
    }
    
}

extension UpdateContactView: ScrollViewExtensionProtocol {
    
    func scrollViewExtensionTapped() -> Void {
        endEditing(true)
    }
    
}
