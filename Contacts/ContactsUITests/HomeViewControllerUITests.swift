import XCTest

class HomeViewControllerUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }
    
    func testNavBarIsPresent() {
        let navBar = app.navigationBars["Contact"]
        XCTAssert(navBar.exists)
    }
   
    func testAddContactButtonIsPresent() {
        let addContactButton = app.navigationBars.buttons["AddButton"]
        XCTAssert(addContactButton.exists)
    }
    
    func testNavBarTitleIsCorrect() {
        let navBar = app.navigationBars["Contact"]
        let title = navBar.staticTexts["Contact"]
        XCTAssert(title.exists)
    }
    
    func testItNavigatesToDetailScreen() {
        let cell = app.tables["HomeTableView"].cells.element(boundBy: 0)
        cell.tap()
        XCTAssert(app.navigationBars.buttons["Contact"].exists)
    }

}
