import Foundation
import RxSwift

enum ContactContentState {
    case initial(ContactViewState)
    case loading(ContactViewState?)
    case idle(ContactViewState)
    case error(ContactViewState?, Error)

    var viewState: ContactViewState? {
        switch self {
        case .initial(let viewState), .idle(let viewState):
            return viewState
        case .loading(let viewState), .error(let viewState, _):
            return viewState
        }
    }

}

extension ContactContentState: Equatable {
    
    static func == (lhs: ContactContentState, rhs: ContactContentState) -> Bool {
        switch(lhs, rhs) {
        case(.initial(let lhsViewState), .initial(let rhsViewState)):
            return lhsViewState == rhsViewState
        case(.loading(let lhsViewState), .loading(let rhsViewState)):
            return lhsViewState == rhsViewState
        case(.idle(let lhsViewState), .idle(let rhsViewState)):
            return lhsViewState == rhsViewState
        case(.error(let lhsViewState, _), .error(let rhsViewState, _)):
            return lhsViewState == rhsViewState
        default:
            return false
        }
    }

}

extension ObservableType where E == ContactViewState {
    
    func toContentState(existingData: ContactViewState?) -> Observable<ContactContentState> {
        return map { .idle($0) }
            .catchError { .just(.error(existingData, $0)) }
            .startWith(.loading(existingData))
    }
    
}
