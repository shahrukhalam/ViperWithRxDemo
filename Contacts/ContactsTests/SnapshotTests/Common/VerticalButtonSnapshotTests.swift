import FBSnapshotTestCase
@testable import Contacts

class VerticalButtonSnapshotTests: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    func testThatVerticalButtonForShortTitleIsCreatedCorrectly() {
        verifyView(with: "call")
    }
    
    func testThatVerticalButtonForLongTitleIsCreatedCorrectly() {
        verifyView(with: "Send the Message")
    }
    
    func testThatVerticalButtonForShortTitleWithInteractionDisabledIsCreatedCorrectly() {
        verifyView(with: "call", isEnabled: false)
    }
    
}

extension VerticalButtonSnapshotTests {
    
    func verifyView(with title: String, isEnabled: Bool = true) {
        let view = VerticalButton()
        view.addWidthConstraint(constant: 200)
        view.backgroundColor = .white
        
        let image = UIImage(named: "favourite")!
        let viewState = VerticalButtonViewState(image: image, title: title)
        view.update(with: viewState, isEnabled: isEnabled)
        
        FBSnapshotVerifyView(view)
    }
    
}
