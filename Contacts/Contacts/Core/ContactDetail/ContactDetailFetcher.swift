import Foundation
import RxSwift

public protocol ContactDetailFetcher {
    func contact(for id: String, with isFavourite: Bool) -> Observable<Contact>
    func contact(for id: String) -> Observable<Contact>
}
