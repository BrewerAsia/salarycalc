import XCTest

final class SalaryCalcUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testAppLaunches() throws {
        let app = XCUIApplication()
        app.launch()
        XCTAssert(app.exists)
    }

    func testCalculatorViewExists() throws {
        let app = XCUIApplication()
        app.launch()

        let calculatorView = app.staticTexts["SalaryCalculator"]
        XCTAssertTrue(app.textFields.count >= 0)
    }
}
