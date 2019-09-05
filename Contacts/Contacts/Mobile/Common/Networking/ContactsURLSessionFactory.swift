import Foundation

final class ContactsURLSessionFactory {
   private let configuration: URLSessionConfiguration

    init(configuration: URLSessionConfiguration) {
        self.configuration = configuration
    }

    func makeSession() -> URLSession {
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
    }
}
