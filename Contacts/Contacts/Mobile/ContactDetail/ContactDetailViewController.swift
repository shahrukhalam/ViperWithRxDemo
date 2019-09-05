import UIKit

class ContactDetailViewController: UIViewController {
    
    private let presenter: ContactDetailPresenter
    private let contactDetailView: ContactDetailView
    
    init(navigator: ContactDetailViewNavigator, viewState: ContactViewState) {
        let dataSource = GoContactDetailDataSource(fetcher: APIContactDetailFetcher())
        let useCase = GoContactDetailUseCase(dataSource: dataSource, viewState: viewState)
        
        self.contactDetailView = ContactDetailView()
        self.presenter = ContactDetailPresenter(navigator: navigator,
                                                displayer: contactDetailView,
                                                useCase: useCase)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(contactDetailView)
        contactDetailView.pinToSuperviewEdges()
        
        setupNavigationBar()
        
        presenter.startPresenting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !isBeingPresented && !isMovingToParentViewController {
            presenter.refreshIfNeeded()
        }
    }
    
    func setupNavigationBar() {
        title = "Detail"
        navigationItem.rightBarButtonItem = NavigationBarFactory
            .setupSystemBarButton(with: .edit,
                                  target: self,
                                  action: #selector(toEditContactAction))
    }
    
    @objc func toEditContactAction() {
        presenter.navigateToEditContactDetail()
    }
    
    deinit {
        presenter.stopPresenting()
    }
    
}
