import XCTest

class ContactDetailControllerUITests: XCTestCase {
        
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }
    
    func testTheFunctionalButtonsForContactIsPresent() {
        
        waitForElementToAppear(app.tables.element(boundBy: 0), timeout: 10)
        let cell = app.tables["HomeTableView"].cells.element(boundBy: 0)
        cell.tap()
        
        waitForElementToAppear(app.scrollViews.element(boundBy: 0), timeout: 5)
        let labelElement = app.staticTexts["favourite"]
        let labelElement2 = app.staticTexts["email"]
        let labelElement3 = app.staticTexts["call"]
        let labelElement4 = app.staticTexts["message"]
        
        XCTAssert(labelElement.exists)
        XCTAssert(labelElement2.exists)
        XCTAssert(labelElement3.exists)
        XCTAssert(labelElement4.exists)
    }
    
}
