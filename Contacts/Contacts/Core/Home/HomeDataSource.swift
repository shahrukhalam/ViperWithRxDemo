import Foundation
import RxSwift

public protocol HomeDataSource {
    func home() -> Observable<Contacts>
}

public class GoHomeDataSource: HomeDataSource {
    private let fetcher: HomeFetcher

    public init(fetcher: HomeFetcher) {
        self.fetcher = fetcher
    }

    public func home() -> Observable<Contacts> {
        return fetcher.home()
    }

}
