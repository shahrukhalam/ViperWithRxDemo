import UIKit

enum UpdateContactType {
    case add
    case edit
}

class UpdateContactViewController: UIViewController {
    
    private let presenter: UpdateContactPresenter
    private let updateContactView: UpdateContactView
    
    init(navigator: UpdateContactViewNavigator,
         viewState: ContactViewState,
         type: UpdateContactType) {
        let dataSource = GoUpdateContactDataSource(fetcher: APIUpdateContactFetcher())
        let useCase = GoUpdateContactUseCase(dataSource: dataSource, viewState: viewState)
        
        self.updateContactView = UpdateContactView()
        self.presenter = UpdateContactPresenter(navigator: navigator,
                                                displayer: updateContactView,
                                                useCase: useCase,
                                                type: type)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(updateContactView)
        updateContactView.pinToSuperviewEdges()
        
        setupNavigationBar()
        presenter.startPresenting()
    }
    
    func setupNavigationBar() {
        title = "Edit"
        navigationItem.rightBarButtonItem = NavigationBarFactory
            .setupSystemBarButton(with: .done,
                                  target: self,
                                  action: #selector(toSaveContactAction))
        navigationItem.leftBarButtonItem = NavigationBarFactory
            .setupSystemBarButton(with: .cancel,
                                  target: self,
                                  action: #selector(toCancelAction))
    }
    
    @objc func toSaveContactAction() {
        presenter.save()
    }
    
    @objc func toCancelAction() {
        presenter.goBack()
    }
    
    deinit {
        presenter.stopPresenting()
    }
    
}

extension UpdateContactViewController:
    UINavigationControllerDelegate,
    UIImagePickerControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [String : Any]) {
        // No need to upload the image as discussed
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            presenter.update(with: image)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
}
