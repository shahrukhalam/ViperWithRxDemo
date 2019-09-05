import Foundation

struct ContactViewStates: Equatable {
    public let contacts: [ContactViewState]
}

extension ContactViewStates {
    
    static func initialState() -> ContactViewStates{
        return ContactViewStates(contacts: [])
    }
    
}
