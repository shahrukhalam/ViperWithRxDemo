import UIKit
import RxSwift

class APIContactDetailFetcher: ContactDetailFetcher {
    
    private let apiService: APIService
    
    init(apiService: APIService = HTTPAPIService.standard) {
        self.apiService = apiService
    }
    
    func contact(for id: String, with isFavourite: Bool) -> Observable<Contact> {
        return apiService.fetchJSON(request: GoContactsAPI
            .contactDetail(id: id, isFavourite: isFavourite).urlRequest!)
    }
    
    func contact(for id: String) -> Observable<Contact> {
        return apiService.fetchJSON(request: GoContactsAPI.contact(id: id).urlRequest!)
    }
    
}
