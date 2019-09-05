import UIKit

class HomeViewController: UIViewController {

    private let presenter: HomePresenter
    private let homeView: HomeView
    
    init(navigator: HomeNavigator) {
        let dataSource = GoHomeDataSource(fetcher: APIHomeFetcher())
        let useCase = GoHomeUseCase(homeDataSource: dataSource)
        
        self.homeView = HomeView()
        self.presenter = HomePresenter(navigator: navigator,
                                       displayer: homeView,
                                       useCase: useCase)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(homeView)
        homeView.pinToSuperviewEdges()
        
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.startPresenting()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.stopPresenting()
    }
    
    func setupNavigationBar() {
        title = "Contact"
        navigationItem.rightBarButtonItem = NavigationBarFactory
            .setupSystemBarButton(with: .add,
                                  target: self,
                                  action: #selector(toAddContactAction))
        navigationItem.rightBarButtonItem?.accessibilityIdentifier = "AddButton"
    }
    
    @objc func toAddContactAction() {
        presenter.navigateToAddContact()
    }

}
