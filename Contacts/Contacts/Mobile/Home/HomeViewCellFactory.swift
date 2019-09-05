import UIKit

class HomeViewCellFactory {
    
    static func registerViews(for tableView: UITableView) {
        tableView.register(TableViewCell<ContactView>.self)
    }
    
    static func cell(for contact: ContactViewState,
                     at indexPath: IndexPath,
                     in tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as TableViewCell<ContactView>
        cell.reusableViewDelegate = cell.view
        cell.view.update(with: contact)
        return cell
    }
    
}
