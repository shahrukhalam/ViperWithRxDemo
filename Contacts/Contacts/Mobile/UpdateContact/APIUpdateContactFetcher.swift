import UIKit
import RxSwift

class APIUpdateContactFetcher: UpdateContactFetcher {
    
    private let apiService: APIService
    
    init(apiService: APIService = HTTPAPIService.standard) {
        self.apiService = apiService
    }
    
    func contact(for id: String, with params: JSON) -> Observable<Contact> {
        return apiService.fetchJSON(request: GoContactsAPI.editContact(id: id, params: params).urlRequest!)
    }
    
    func addContact(with params: JSON) -> Observable<Contact> {
        return apiService.fetchJSON(request: GoContactsAPI.addContact(params: params).urlRequest!)
    }
    
}
