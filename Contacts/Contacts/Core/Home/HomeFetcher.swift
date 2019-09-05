import Foundation
import RxSwift

public protocol HomeFetcher {
    func home() -> Observable<Contacts>
}
