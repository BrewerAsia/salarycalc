import XCTest
@testable import SalaryCalc

final class SalaryCalcTests: XCTestCase {
    func testUSASalaryCalculation() {
        let input = SalaryInput(
            grossAnnualSalary: 100000,
            country: "USA",
            state: "California",
            employmentType: .fullTime
        )

        let result = SalaryCalculationEngine.calculateSalary(for: input)
        XCTAssertGreater(result.netAnnualSalary, 0)
        XCTAssertLess(result.netAnnualSalary, input.grossAnnualSalary)
    }

    func testUKSalaryCalculation() {
        let input = SalaryInput(
            grossAnnualSalary: 50000,
            country: "UK",
            state: "",
            employmentType: .fullTime
        )

        let result = SalaryCalculationEngine.calculateSalary(for: input)
        XCTAssertGreater(result.netAnnualSalary, 0)
        XCTAssertLess(result.netAnnualSalary, input.grossAnnualSalary)
    }
}
