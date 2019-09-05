import FBSnapshotTestCase
@testable import Contacts

class DetailTextFieldSnapshotTests: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    func testThatDetailEmailTextFieldWithNoTextIsCreatedCorrectly() {
        verifyView(for: .email)
    }
    
    func testThatDetailEmailTextFieldWithTextIsCreatedCorrectly() {
        verifyView(with: "This is Your Email Field", for: .email)
    }
    
    func testThatDetailPhoneTextFieldWithNoTextIsCreatedCorrectly() {
        verifyView(for: .phoneNumber)
    }
    
    func testThatDetailPhoneTextFieldWithTextIsCreatedCorrectly() {
        verifyView(with: "This is Your Phone Field", for: .phoneNumber)
    }
    
}

extension DetailTextFieldSnapshotTests {
    
    func verifyView(with text: String? = nil, for type: DetailTextFieldType) {
        let view = DetailTextField()
        view.addWidthConstraint(constant: 375)
        
        let viewState = DetailTextFieldViewState.testData(
            type: type,
            text: text,
            isEnabled: true)
        view.update(with: viewState)
        
        FBSnapshotVerifyView(view)
    }
    
}
