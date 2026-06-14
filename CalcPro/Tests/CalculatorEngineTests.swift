import XCTest

class CalculatorEngineTests: XCTestCase {

    var engine: CalculatorEngine!

    override func setUp() {
        super.setUp()
        engine = CalculatorEngine()
    }

    override func tearDown() {
        engine = nil
        super.tearDown()
    }

    // MARK: - Basic Arithmetic Tests

    func testAddition() {
        engine.addDigit(5)
        engine.performOperation(.add)
        engine.addDigit(3)
        engine.calculate()

        XCTAssertEqual(engine.displayValue, "8")
    }

    func testSubtraction() {
        engine.addDigit(1)
        engine.addDigit(0)
        engine.performOperation(.subtract)
        engine.addDigit(3)
        engine.calculate()

        XCTAssertEqual(engine.displayValue, "7")
    }

    func testMultiplication() {
        engine.addDigit(6)
        engine.performOperation(.multiply)
        engine.addDigit(7)
        engine.calculate()

        XCTAssertEqual(engine.displayValue, "42")
    }

    func testDivision() {
        engine.addDigit(2)
        engine.addDigit(0)
        engine.performOperation(.divide)
        engine.addDigit(4)
        engine.calculate()

        XCTAssertEqual(engine.displayValue, "5")
    }

    func testDivisionByZero() {
        engine.addDigit(5)
        engine.performOperation(.divide)
        engine.addDigit(0)
        let result = engine.calculate()

        switch result {
        case .failure(let error):
            XCTAssertEqual(error, CalculatorEngine.CalculationError.divisionByZero)
        case .success:
            XCTFail("Division by zero should fail")
        }
    }

    // MARK: - Decimal Tests

    func testDecimalAddition() {
        engine.addDigit(1)
        engine.addDecimal()
        engine.addDigit(5)
        engine.performOperation(.add)
        engine.addDigit(2)
        engine.addDecimal()
        engine.addDigit(3)
        engine.calculate()

        XCTAssertEqual(engine.displayValue, "3.8")
    }

    func testDecimalMultiplication() {
        engine.addDigit(2)
        engine.addDecimal()
        engine.addDigit(5)
        engine.performOperation(.multiply)
        engine.addDigit(4)
        engine.calculate()

        XCTAssertEqual(engine.displayValue, "10")
    }

    // MARK: - Function Tests

    func testPercentage() {
        engine.addDigit(2)
        engine.addDigit(0)
        engine.percentage()

        XCTAssertEqual(engine.displayValue, "0.2")
    }

    func testToggleSign() {
        engine.addDigit(5)
        engine.toggleSign()

        XCTAssertEqual(engine.displayValue, "-5")
    }

    func testToggleSignNegative() {
        engine.addDigit(5)
        engine.toggleSign()
        engine.toggleSign()

        XCTAssertEqual(engine.displayValue, "5")
    }

    func testDelete() {
        engine.addDigit(1)
        engine.addDigit(2)
        engine.addDigit(3)
        engine.delete()

        XCTAssertEqual(engine.displayValue, "12")
    }

    func testClear() {
        engine.addDigit(1)
        engine.addDigit(2)
        engine.addDigit(3)
        engine.clear()

        XCTAssertEqual(engine.displayValue, "0")
    }

    // MARK: - Chain Operations Tests

    func testChainedOperations() {
        // (10 + 5) * 2 = 30
        engine.addDigit(1)
        engine.addDigit(0)
        engine.performOperation(.add)
        engine.addDigit(5)
        engine.performOperation(.multiply)
        engine.addDigit(2)
        engine.calculate()

        XCTAssertEqual(engine.displayValue, "30")
    }

    // MARK: - Edge Cases

    func testLeadingZero() {
        engine.addDigit(0)
        engine.addDigit(0)
        engine.addDigit(5)

        XCTAssertEqual(engine.displayValue, "5")
    }

    func testMultipleDecimals() {
        engine.addDigit(1)
        engine.addDecimal()
        engine.addDecimal()
        engine.addDigit(5)

        // Should only have one decimal
        XCTAssertEqual(engine.displayValue.filter { $0 == "." }.count, 1)
    }

    func testLargeNumbers() {
        for i in 0..<20 {
            engine.addDigit(i % 10)
        }

        // Should be limited to 20 digits
        XCTAssertLessThanOrEqual(engine.displayValue.count, 20)
    }

    // MARK: - Display Tests

    func testInitialDisplay() {
        XCTAssertEqual(engine.displayValue, "0")
    }

    func testOperationSymbolDisplay() {
        engine.addDigit(5)
        engine.performOperation(.add)

        XCTAssertEqual(engine.operationSymbol, "+")
    }

    func testCalculationExpression() {
        engine.addDigit(5)
        engine.performOperation(.add)
        engine.addDigit(3)

        let expression = engine.getCalculationExpression()
        XCTAssertTrue(expression.contains("+"))
        XCTAssertTrue(expression.contains("5"))
        XCTAssertTrue(expression.contains("3"))
    }
}
