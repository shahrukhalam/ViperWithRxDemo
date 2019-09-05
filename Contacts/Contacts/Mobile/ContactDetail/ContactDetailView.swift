import UIKit

class ContactDetailView: UIView, ContactDetailDisplayer, ContactDetailHeaderViewActions {
    private var actionListener: ContactDetailActionListener?
    
    private let scrollView = UIScrollView()
    private let scrollViewContainer = UIView()
    private let header = ContactDetailHeaderView()
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
    
    func attachListener(listener: ContactDetailActionListener) {
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
        header.delegate = self
        activityIndicator.color = .white
        setupScrollView()
    }
    
    private func applyConstraints() {
        scrollView.pinToSuperviewEdges()
        applyConstraintsForContainer()
    }
    
    private func setupScrollView() {
        scrollViewContainer.addSubview(header)
        scrollViewContainer.addSubview(phoneTextField)
        scrollViewContainer.addSubview(emailTextField)
        scrollViewContainer.addSubview(activityIndicator)
    }
    
    private func applyConstraintsForContainer() {
        scrollViewContainer.pinToSuperviewEdges()
        scrollViewContainer.setWidthEqualToWidth(of: scrollView)
        
        header.pinToSuperview(edges: [.leading, .trailing, .top])
        header.addHeightConstraint(constant: Constants.width)
        
        phoneTextField.pin(edge: .top, to: .bottom, of: header)
        phoneTextField.pinToSuperview(edges: [.leading, .trailing])
        
        emailTextField.pin(edge: .top, to: .bottom, of: phoneTextField)
        emailTextField.pinToSuperview(edges: [.leading, .trailing, .bottom])
        
        activityIndicator.pinCenter(to: scrollViewContainer)
    }
    
    func update(with viewState: ContactViewState) {
        hideLoading()
        
        header.update(with: viewState)
        
        phoneTextField.update(with: viewState.phoneViewState)
        emailTextField.update(with: viewState.emailViewState)
    }
    
    func setLoading() {
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
    }
    
    func messageAction() {
        actionListener?.messageAction?()
    }
    
    func callAction() {
        actionListener?.callAction?()
    }
    
    func emailAction() {
        actionListener?.emailAction?()
    }
    
    func favouriteAction() {
        actionListener?.favouriteAction?()
    }
    
}
