import UIKit

class HomeView: UIView, HomeDisplayer {
    private let adapter = HomeTableViewAdapter()
    private var actionListener: HomeActionListener?

    private let tableView: UITableView
    private let refreshControl = UIRefreshControl()
    private let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    private let tableBackgroundView = UILabel()

    override init(frame: CGRect) {
        self.tableView = UITableView(frame: .zero)
        super.init(frame: .zero)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("This view is not designed to be used with xib or storyboard files")
    }

    func attachListener(listener: HomeActionListener) {
        actionListener = listener
        adapter.attachListener(listener: listener)
    }

    func detachListener() {
        actionListener = nil
        adapter.detachListener()
    }

    private func setup() {
        addSubViews()
        setupViews()
        applyConstraints()
    }

    private func addSubViews() {
        addSubview(activityIndicator)
        addSubview(tableView)
        activityIndicator.accessibilityIdentifier = "HomeActivity"
        tableView.accessibilityIdentifier = "HomeTableView"
    }

    private func applyConstraints() {
        tableView.pinToSuperviewEdges()
        activityIndicator.pinCenter(to: self)
    }
    
    private func setupViews() {
        tableBackgroundView.text = "Oops, No Contacts Found"
        tableBackgroundView.textAlignment = .center
        tableBackgroundView.textColor = .gray
        
        activityIndicator.color = .gray

        setupTableView()
    }
    
    private func setupTableView() {
        HomeViewCellFactory.registerViews(for: tableView)
        tableView.dataSource = adapter
        tableView.delegate = adapter
        tableView.estimatedRowHeight = 91.0
        tableView.tableFooterView = UIView()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func setLoading() {
        activityIndicator.startAnimating()
        tableView.isHidden = true
    }
    
    func endRefreshing() {
        refreshControl.endRefreshing()
    }
    
    func update(with viewState: ContactViewStates) {
        endRefreshing()
        activityIndicator.stopAnimating()

        tableView.backgroundView = viewState.contacts.count > 0 ? nil : tableBackgroundView

        tableView.isHidden = false
        adapter.update(with: viewState)
        tableView.reloadData()
    }
    
    @objc func refresh() {
        actionListener?.refreshAction()
    }

}
