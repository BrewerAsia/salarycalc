import Foundation

/// Core salary calculation engine supporting multiple countries
/// Handles gross-to-net salary calculations with accurate tax rates
class SalaryCalculationEngine {

    // MARK: - Models

    enum EmploymentType: String, CaseIterable {
        case fullTime = "Full-time Employee"
        case partTime = "Part-time Employee"
        case freelance = "Freelancer/Self-Employed"
        case contractor = "Contractor"
    }

    enum Currency: String, CaseIterable {
        case usd = "USD"
        case gbp = "GBP"
        case cad = "CAD"
        case aud = "AUD"
        case eur = "EUR"
        case inr = "INR"
        case chf = "CHF"
    }

    struct SalaryInput {
        let grossAnnualSalary: Decimal
        let country: String
        let state: String? // For multi-state countries like USA
        let employmentType: EmploymentType
    }

    struct SalaryBreakdown {
        let grossSalary: Decimal
        let federalTax: Decimal
        let stateTax: Decimal
        let socialSecurity: Decimal
        let medicare: Decimal
        let healthInsurance: Decimal
        let pensionContribution: Decimal
        let otherDeductions: Decimal

        var totalDeductions: Decimal {
            federalTax + stateTax + socialSecurity + medicare +
            healthInsurance + pensionContribution + otherDeductions
        }

        var netAnnualSalary: Decimal {
            grossSalary - totalDeductions
        }

        var netMonthlySalary: Decimal {
            netAnnualSalary / 12
        }

        var netWeeklySalary: Decimal {
            netAnnualSalary / 52
        }

        var effectiveTaxRate: Decimal {
            guard grossSalary > 0 else { return 0 }
            return (totalDeductions / grossSalary) * 100
        }
    }

    // MARK: - Public Methods

    /// Calculate net salary based on input parameters
    func calculateSalary(_ input: SalaryInput) -> SalaryBreakdown {
        switch input.country {
        case "United States":
            return calculateUSASalary(input)
        case "United Kingdom":
            return calculateUKSalary(input)
        case "Canada":
            return calculateCanadaSalary(input)
        case "Australia":
            return calculateAustraliaSalary(input)
        case "Germany":
            return calculateGermanySalary(input)
        case "France":
            return calculateFranceSalary(input)
        case "India":
            return calculateIndiaSalary(input)
        case "Switzerland":
            return calculateSwitzerlandSalary(input)
        default:
            return SalaryBreakdown(
                grossSalary: input.grossAnnualSalary,
                federalTax: 0,
                stateTax: 0,
                socialSecurity: 0,
                medicare: 0,
                healthInsurance: 0,
                pensionContribution: 0,
                otherDeductions: 0
            )
        }
    }

    // MARK: - USA Calculation

    private func calculateUSASalary(_ input: SalaryInput) -> SalaryBreakdown {
        let gross = input.grossAnnualSalary

        // Federal income tax (2024 rates, single filer)
        let federalTax = calculateUSAFederalTax(gross)

        // FICA taxes (Social Security + Medicare)
        let socialSecurity = min(gross * Decimal(0.062), Decimal(168600) * Decimal(0.062))
        let medicare = gross * Decimal(0.0145)

        // State income tax (varies by state, California example: 9.3%)
        let stateRate = getUSAStateRate(input.state ?? "CA")
        let stateTax = gross * stateRate

        // Health insurance (estimate: 3.5%)
        let healthInsurance = gross * Decimal(0.035)

        // 401(k) contribution (5% average)
        let pensionContribution = gross * Decimal(0.05)

        return SalaryBreakdown(
            grossSalary: gross,
            federalTax: federalTax,
            stateTax: stateTax,
            socialSecurity: socialSecurity,
            medicare: medicare,
            healthInsurance: healthInsurance,
            pensionContribution: pensionContribution,
            otherDeductions: 0
        )
    }

    private func calculateUSAFederalTax(_ salary: Decimal) -> Decimal {
        // 2024 Federal tax brackets (single filer)
        if salary <= 11600 { return salary * Decimal(0.10) }
        if salary <= 47150 { return 1160 + (salary - 11600) * Decimal(0.12) }
        if salary <= 100525 { return 5426 + (salary - 47150) * Decimal(0.22) }
        if salary <= 191950 { return 17168.50 + (salary - 100525) * Decimal(0.24) }
        if salary <= 243725 { return 39110.50 + (salary - 191950) * Decimal(0.32) }
        if salary <= 609350 { return 55678.50 + (salary - 243725) * Decimal(0.35) }
        return 188291.50 + (salary - 609350) * Decimal(0.37)
    }

    private func getUSAStateRate(_ state: String) -> Decimal {
        switch state.uppercased() {
        case "CA": return Decimal(0.093)
        case "NY": return Decimal(0.0685)
        case "TX": return 0 // No state income tax
        case "FL": return 0 // No state income tax
        case "WA": return 0 // No state income tax
        default: return Decimal(0.05) // Average
        }
    }

    // MARK: - UK Calculation

    private func calculateUKSalary(_ input: SalaryInput) -> SalaryBreakdown {
        let gross = input.grossAnnualSalary

        // Income tax (2024 rates)
        let incomeTax = calculateUKIncomeTax(gross)

        // National Insurance
        let nationalInsurance = calculateUKNationalInsurance(gross)

        // Pension contribution
        let pension = gross * Decimal(0.08)

        return SalaryBreakdown(
            grossSalary: gross,
            federalTax: incomeTax,
            stateTax: nationalInsurance,
            socialSecurity: 0,
            medicare: 0,
            healthInsurance: 0,
            pensionContribution: pension,
            otherDeductions: 0
        )
    }

    private func calculateUKIncomeTax(_ salary: Decimal) -> Decimal {
        let personalAllowance = Decimal(12570)
        let taxableIncome = max(salary - personalAllowance, 0)

        if taxableIncome <= 50270 { return taxableIncome * Decimal(0.20) }
        if taxableIncome <= 125140 { return 10054 + (taxableIncome - 50270) * Decimal(0.40) }
        return 40054 + (taxableIncome - 125140) * Decimal(0.45)
    }

    private func calculateUKNationalInsurance(_ salary: Decimal) -> Decimal {
        let threshold = Decimal(12570)
        let taxable = max(salary - threshold, 0)

        if taxable <= 50270 { return taxable * Decimal(0.08) }
        return 50270 * Decimal(0.08) + (taxable - 50270) * Decimal(0.02)
    }

    // MARK: - Canada Calculation

    private func calculateCanadaSalary(_ input: SalaryInput) -> SalaryBreakdown {
        let gross = input.grossAnnualSalary

        // Federal tax
        let federalTax = calculateCanadaFederalTax(gross)

        // Provincial tax (Ontario average)
        let provincialTax = calculateCanadaProvincialTax(gross, province: input.state ?? "ON")

        // CPP (Canada Pension Plan)
        let cpp = min((gross - 3500) * Decimal(0.0595), 3867.50)

        // EI (Employment Insurance)
        let ei = min(gross * Decimal(0.0163), 1049.12)

        return SalaryBreakdown(
            grossSalary: gross,
            federalTax: federalTax,
            stateTax: provincialTax,
            socialSecurity: cpp,
            medicare: 0,
            healthInsurance: 0,
            pensionContribution: 0,
            otherDeductions: ei
        )
    }

    private func calculateCanadaFederalTax(_ salary: Decimal) -> Decimal {
        // 2024 Federal brackets
        if salary <= 55867 { return salary * Decimal(0.15) }
        if salary <= 111733 { return 8380.05 + (salary - 55867) * Decimal(0.205) }
        if salary <= 173205 { return 20535.05 + (salary - 111733) * Decimal(0.26) }
        if salary <= 246752 { return 41121.31 + (salary - 173205) * Decimal(0.29) }
        return 62341.80 + (salary - 246752) * Decimal(0.33)
    }

    private func calculateCanadaProvincialTax(_ salary: Decimal, province: String) -> Decimal {
        // Ontario rates as example
        if salary <= 51446 { return salary * Decimal(0.0505) }
        if salary <= 102894 { return 2598.02 + (salary - 51446) * Decimal(0.0915) }
        if salary <= 150000 { return 7305.90 + (salary - 102894) * Decimal(0.1116) }
        return 12564.74 + (salary - 150000) * Decimal(0.1216)
    }

    // MARK: - Australia Calculation

    private func calculateAustraliaSalary(_ input: SalaryInput) -> SalaryBreakdown {
        let gross = input.grossAnnualSalary

        // Income tax
        let incomeTax = calculateAustraliaIncomeTax(gross)

        // Medicare levy
        let medicareLevY = gross * Decimal(0.02)

        // Superannuation (9.5%)
        let superannuation = gross * Decimal(0.095)

        return SalaryBreakdown(
            grossSalary: gross,
            federalTax: incomeTax,
            stateTax: 0,
            socialSecurity: 0,
            medicare: medicareLevY,
            healthInsurance: 0,
            pensionContribution: superannuation,
            otherDeductions: 0
        )
    }

    private func calculateAustraliaIncomeTax(_ salary: Decimal) -> Decimal {
        // 2024 tax year
        if salary <= 18200 { return 0 }
        if salary <= 45000 { return (salary - 18200) * Decimal(0.19) }
        if salary <= 120000 { return 5092 + (salary - 45000) * Decimal(0.325) }
        if salary <= 180000 { return 29467 + (salary - 120000) * Decimal(0.37) }
        return 51667 + (salary - 180000) * Decimal(0.45)
    }

    // MARK: - Germany Calculation

    private func calculateGermanySalary(_ input: SalaryInput) -> SalaryBreakdown {
        let gross = input.grossAnnualSalary

        // Income tax
        let incomeTax = calculateGermanyIncomeTax(gross)

        // Solidarity surcharge
        let solidarity = incomeTax * Decimal(0.055)

        // Social insurance contributions
        let socialInsurance = gross * Decimal(0.0875) // Employee portion

        // Pension insurance
        let pension = gross * Decimal(0.0855)

        return SalaryBreakdown(
            grossSalary: gross,
            federalTax: incomeTax + solidarity,
            stateTax: 0,
            socialSecurity: socialInsurance,
            medicare: 0,
            healthInsurance: 0,
            pensionContribution: pension,
            otherDeductions: 0
        )
    }

    private func calculateGermanyIncomeTax(_ salary: Decimal) -> Decimal {
        // Simplified German tax calculation
        let taxableIncome = salary - 11600 // Basic exemption

        if taxableIncome <= 0 { return 0 }
        if taxableIncome <= 16000 { return taxableIncome * Decimal(0.14) }
        if taxableIncome <= 80000 { return 2240 + (taxableIncome - 16000) * Decimal(0.24) }
        return 17600 + (taxableIncome - 80000) * Decimal(0.42)
    }

    // MARK: - France Calculation

    private func calculateFranceSalary(_ input: SalaryInput) -> SalaryBreakdown {
        let gross = input.grossAnnualSalary

        // Income tax
        let incomeTax = calculateFranceIncomeTax(gross)

        // Social contributions (employee portion)
        let socialContributions = gross * Decimal(0.0805)

        // General social contribution (CSG)
        let csg = gross * Decimal(0.0825)

        return SalaryBreakdown(
            grossSalary: gross,
            federalTax: incomeTax,
            stateTax: 0,
            socialSecurity: socialContributions,
            medicare: 0,
            healthInsurance: 0,
            pensionContribution: csg,
            otherDeductions: 0
        )
    }

    private func calculateFranceIncomeTax(_ salary: Decimal) -> Decimal {
        // Simplified French tax
        if salary <= 10225 { return 0 }
        if salary <= 26070 { return (salary - 10225) * Decimal(0.11) }
        if salary <= 74545 { return 1744.95 + (salary - 26070) * Decimal(0.30) }
        return 16896.45 + (salary - 74545) * Decimal(0.41)
    }

    // MARK: - India Calculation

    private func calculateIndiaSalary(_ input: SalaryInput) -> SalaryBreakdown {
        let gross = input.grossAnnualSalary

        // Income tax (FY 2024-25)
        let incomeTax = calculateIndiaIncomeTax(gross)

        // Professional tax (varies, maximum ₹2,500)
        let profTax = min(gross * Decimal(0.01), Decimal(2500))

        // Provident fund contribution (12%)
        let epf = gross * Decimal(0.12)

        return SalaryBreakdown(
            grossSalary: gross,
            federalTax: incomeTax,
            stateTax: profTax,
            socialSecurity: 0,
            medicare: 0,
            healthInsurance: 0,
            pensionContribution: epf,
            otherDeductions: 0
        )
    }

    private func calculateIndiaIncomeTax(_ salary: Decimal) -> Decimal {
        // Simplified India tax (standard deduction ₹50,000)
        let taxableIncome = max(salary - 50000, 0)

        if taxableIncome <= 300000 { return 0 }
        if taxableIncome <= 500000 { return (taxableIncome - 300000) * Decimal(0.05) }
        if taxableIncome <= 1000000 { return 10000 + (taxableIncome - 500000) * Decimal(0.20) }
        return 110000 + (taxableIncome - 1000000) * Decimal(0.30)
    }

    // MARK: - Switzerland Calculation

    private func calculateSwitzerlandSalary(_ input: SalaryInput) -> SalaryBreakdown {
        let gross = input.grossAnnualSalary

        // Federal tax (simplified)
        let federalTax = calculateSwitzerlandFederalTax(gross)

        // Cantonal + Municipal tax (combined average ~20%)
        let cantonalTax = gross * Decimal(0.12)

        // AHV/AVS (Old Age Insurance)
        let ahv = gross * Decimal(0.0820)

        // Occupational pension
        let pension = gross * Decimal(0.095)

        // Unemployment insurance
        let unemployment = gross * Decimal(0.011)

        return SalaryBreakdown(
            grossSalary: gross,
            federalTax: federalTax,
            stateTax: cantonalTax,
            socialSecurity: ahv,
            medicare: 0,
            healthInsurance: 0,
            pensionContribution: pension,
            otherDeductions: unemployment
        )
    }

    private func calculateSwitzerlandFederalTax(_ salary: Decimal) -> Decimal {
        // Simplified federal tax
        if salary <= 20000 { return 0 }
        if salary <= 50000 { return (salary - 20000) * Decimal(0.07) }
        if salary <= 100000 { return 2100 + (salary - 50000) * Decimal(0.11) }
        return 7600 + (salary - 100000) * Decimal(0.15)
    }

    // MARK: - Supported Countries

    static let supportedCountries = [
        "United States",
        "United Kingdom",
        "Canada",
        "Australia",
        "Germany",
        "France",
        "India",
        "Switzerland"
    ]

    static let usStates = [
        "CA", "NY", "TX", "FL", "WA", "IL", "PA", "OH",
        "GA", "NC", "MI", "NJ", "VA", "WA", "MA"
    ]
}
