import Foundation

enum Method: String {
    case GET
    case POST
    case PUT
}

protocol APIRequest {
    var baseURL: String { get }
    var path: String { get }

    var method: Method { get }
    var parameters: [String: Any]? { get }
    
    var urlRequest: URLRequest? { get }
}

extension APIRequest {
    
    var urlRequest: URLRequest? {
        let urlString = baseURL.appending(path)

        guard let unwrappedURL = URL(string: urlString) else {
            preconditionFailure("We should have a valid URL")
        }

        let request = NSMutableURLRequest(url: unwrappedURL)
        
        var defaultHeaders = [String : String]()
        defaultHeaders["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = defaultHeaders
                
        request.httpMethod = method.rawValue
        
        var postData = Data()
        if let params = parameters {
            do
            {
                postData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            }
            catch {
                return nil
            }
        }
        
        if method.rawValue != "GET" {
            request.httpBody = postData
        }
        
        return request as URLRequest
    }

    var baseURL: String {
        return Constants.baseURL
    }

}
