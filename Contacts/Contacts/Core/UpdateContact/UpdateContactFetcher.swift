import Foundation
import RxSwift

public protocol UpdateContactFetcher {
    func contact(for id: String, with params: JSON) -> Observable<Contact>
    func addContact(with params: JSON) -> Observable<Contact>
}
