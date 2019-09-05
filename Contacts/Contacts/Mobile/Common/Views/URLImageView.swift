import UIKit
import RxSwift
import RxCocoa

typealias ImageCache = NSCache<NSString, UIImage>

class URLImageView: UIImageView {

    private let imageCache: ImageCache
    private var currentURL: URL?
    private var disposeBag = DisposeBag()

    init(sharedImageCache: ImageCache = ImageCache()) {
        self.imageCache = sharedImageCache
        super.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    func setup() {
        clipsToBounds = true
        layer.masksToBounds = true
        layer.cornerRadius = bounds.width/2
    }

    func update(with path: String?) {
        image = UIImage(named: "placeholderProfilePicture")

        guard let path = path else {
            return
        }
        
        let finalURL: URL
        if path == "/images/missing.png" {
            guard let url = URL(string: Constants.baseURL + path) else {
                return
            }
            finalURL = url
        }
        else {
            guard let url = URL(string: path) else {
                return
            }
            finalURL = url
        }
        
        guard finalURL != currentURL else {
            return
        }
        updateView(with: finalURL)
    }

    private func updateView(with url: URL) {
        currentURL = url
        disposeBag = DisposeBag()

        let key = url.absoluteString as NSString
        if let cached = imageCache.object(forKey: key) {
            image = cached
            return
        }

        let request = URLRequest(url: url)
        return URLSession.shared.rx
            .data(request: request)
            .map(UIImage.init)
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] image in
                    if let image = image {
                        self?.imageCache.setObject(image, forKey: key)
                        self?.image = image
                    }
                },
                onError: { [weak self] _ in
                    self?.image = UIImage(named: "placeholderProfilePicture")
            }).disposed(by: disposeBag)
    }

    func reset() {
        image = nil
        currentURL = nil
        disposeBag = DisposeBag()
    }

}
