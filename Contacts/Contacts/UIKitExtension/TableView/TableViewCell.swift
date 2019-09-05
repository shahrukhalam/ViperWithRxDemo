import UIKit

public protocol ReusableView: class {
    func prepareForReuse()
}

public class TableViewCell<ContentView>: UITableViewCell where ContentView: UIView {
    public let view = ContentView()

    public weak var reusableViewDelegate: ReusableView?

    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("This view is not designed to be used with xib or storyboard files")
    }

    private func setup() {
        contentView.addSubview(view)
        view.pinToSuperviewEdges()
    }
    
    override public func prepareForReuse() {
        reusableViewDelegate?.prepareForReuse()
        super.prepareForReuse()
    }

}
