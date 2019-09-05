import Foundation
import UIKit

class HomeTableViewAdapter: NSObject {
    
    fileprivate (set) var viewState = ContactViewStates.initialState()
    fileprivate var actionListener: HomeActionListener?

    func attachListener(listener: HomeActionListener) {
        actionListener = listener
    }

    func detachListener() {
        actionListener = nil
    }

    func update(with viewState: ContactViewStates) {
        self.viewState = viewState
    }

}

extension HomeTableViewAdapter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = viewState.contacts[indexPath.row]
        actionListener?.toContactDetailAction?(contact)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension HomeTableViewAdapter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewState.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contact = viewState.contacts[indexPath.row]
        return HomeViewCellFactory.cell(for: contact, at: indexPath, in: tableView)
    }
    
}
