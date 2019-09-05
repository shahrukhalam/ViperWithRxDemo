import Foundation
import RxSwift

public protocol ContactDetailDataSource {
    func contact(for id: String, with isFavourite: Bool) -> Observable<Contact>
    func contact(for id: String) -> Observable<Contact>
}

public class GoContactDetailDataSource: ContactDetailDataSource {
    private let fetcher: ContactDetailFetcher
    
    public init(fetcher: ContactDetailFetcher) {
        self.fetcher = fetcher
    }
    
    public func contact(for id: String, with isFavourite: Bool) -> Observable<Contact> {
        return fetcher.contact(for: id, with: isFavourite)
    }
    
    public func contact(for id: String) -> Observable<Contact> {
        return fetcher.contact(for: id)
    }
    
}
