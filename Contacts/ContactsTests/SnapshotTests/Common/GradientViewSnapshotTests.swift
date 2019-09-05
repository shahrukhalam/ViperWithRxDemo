import FBSnapshotTestCase
@testable import Contacts

class GradientViewSnapshotTests: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    func testThatGradientViewIsCreatedCorrectly() {
        let view = GradientView(frame: CGRect(x: 0, y: 0, width: 375, height: 375))
        view.setup()
        FBSnapshotVerifyView(view)
    }
    
}
