import Foundation
import RxSwift
import RxCocoa

protocol APIService {
    func fetchJSON<T>(request: URLRequest) -> Observable<T> where T: JSONInitializable
    func fetchArray<T>(request: URLRequest) -> Observable<T> where T: JSONArrayInitializable
}

struct JSONConversionError: Error {}
extension Data {

    static func toJSON(data: Data) throws -> JSON {
        let anyJSON = try JSONSerialization.jsonObject(with: data, options: [])
        guard let json = anyJSON as? JSON else {
            throw JSONConversionError()
        }
        return json
    }
    
    static func toJSONArray(data: Data) throws -> [JSON] {
        let anyJSONArray = try JSONSerialization.jsonObject(with: data, options: [])
        guard let jsonArray = anyJSONArray as? [JSON] else {
            throw JSONConversionError()
        }
        return jsonArray
    }

}

class HTTPAPIService: APIService {
    private let urlSessionFactory: ContactsURLSessionFactory

    static let standard = HTTPAPIService(configuration: ContactsURLSessionConfigurationFactory.standard())

    init(configuration: URLSessionConfiguration) {
        self.urlSessionFactory = ContactsURLSessionFactory(configuration: configuration)
    }

    func fetchJSON<T>(request: URLRequest) -> Observable<T> where T: JSONInitializable {
        return urlSessionFactory.makeSession().rx
                .data(request: request)
                .catchError(transformToNoConnectionErrorIfOffline)
                .catchError(transformToNotFoundErrorIfHttpRequestFailed)
                .map(Data.toJSON)
                .map(T.init)
    }
    
    func fetchArray<T>(request: URLRequest) -> Observable<T> where T: JSONArrayInitializable {
        return urlSessionFactory.makeSession().rx
            .data(request: request)
            .catchError(transformToNoConnectionErrorIfOffline)
            .catchError(transformToNotFoundErrorIfHttpRequestFailed)
            .map(Data.toJSONArray)
            .map(T.init)
    }

    private func transformToNoConnectionErrorIfOffline(error: Error) -> Observable<Data> {
        let offlineError = NSError(domain: NSURLErrorDomain, code: NSURLErrorNotConnectedToInternet)
        return Observable.error(offlineError)
    }

    private func transformToNotFoundErrorIfHttpRequestFailed(error: Error) -> Observable<Data> {
        guard case RxCocoaURLError.httpRequestFailed(let response, _) = error else {
            return Observable.error(error)
        }

        guard response.statusCode == 404 else {
            let genericError = NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown)
            return Observable.error(genericError)
        }

        let notFoundError = NSError(domain: NSURLErrorDomain, code: NSURLErrorResourceUnavailable)
        return Observable.error(notFoundError)
    }

}

final class ContactsURLSessionConfigurationFactory {
    private static let defaultTimeout = TimeInterval(30)
    private static let defaultDiskCapacity = 20 * 1024 * 1024
    static let standardCache = URLCache(memoryCapacity: 16 * 1024 * 1024,
                                        diskCapacity: defaultDiskCapacity,
                                        diskPath: "default")

    static func standard() -> URLSessionConfiguration {
        return createConfiguration(timeout: defaultTimeout,
                                   urlCache: standardCache,
                                   cachePolicy: .useProtocolCachePolicy)
    }

    private static func createConfiguration(timeout: TimeInterval,
                                            urlCache: URLCache,
                                            cachePolicy: NSURLRequest.CachePolicy) -> URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeout
        configuration.urlCache = urlCache
        configuration.requestCachePolicy = cachePolicy

        return configuration
    }

}
