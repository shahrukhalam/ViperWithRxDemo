import Foundation
import RxSwift

public protocol UpdateContactDataSource {
    func contact(for id: String, with params: JSON) -> Observable<Contact>
    func addContact(with params: JSON) -> Observable<Contact>
}

public class GoUpdateContactDataSource: UpdateContactDataSource {
    private let fetcher: UpdateContactFetcher
    
    public init(fetcher: UpdateContactFetcher) {
        self.fetcher = fetcher
    }
    
    public func contact(for id: String, with params: JSON) -> Observable<Contact> {
        return fetcher.contact(for: id, with: params)
    }
    
    public func addContact(with params: JSON) -> Observable<Contact> {
        return fetcher.addContact(with: params)
    }
    
}
