import UIKit
import RxSwift

class APIHomeFetcher: HomeFetcher {

    private let apiService: APIService

    init(apiService: APIService = HTTPAPIService.standard) {
        self.apiService = apiService
    }

    func home() -> Observable<Contacts> {
        return apiService.fetchArray(request: GoContactsAPI.home.urlRequest!)
    }
    
}
