import Foundation

// MARK: - Enhanced Tax Data Models
struct TaxDataProvider {
    static let shared = TaxDataProvider()

    var taxData: [String: CountryTaxInfo] = [:]

    init() {
        loadTaxData()
    }

    mutating func loadTaxData() {
        // Load from TaxData.json
        if let jsonData = loadJSON(filename: "TaxData") {
            do {
                let decoder = JSONDecoder()
                let fullData = try decoder.decode(TaxDataModel.self, from: jsonData)
                // Convert to our models
                for (key, country) in fullData.countries {
                    taxData[key] = country
                }
            } catch {
                print("Error loading tax data: \(error)")
            }
        }
    }

    private func loadJSON(filename: String) -> Data? {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            return nil
        }
        return try? Data(contentsOf: url)
    }

    func getCountries() -> [CountryTaxInfo] {
        return Array(taxData.values).sorted { $0.name < $1.name }
    }

    func getCountry(code: String) -> CountryTaxInfo? {
        return taxData[code.lowercased()]
    }

    func getSubdivisions(for countryCode: String) -> [SubdivisionInfo] {
        guard let country = getCountry(code: countryCode) else { return [] }
        return country.subdivisions ?? []
    }
}

struct TaxDataModel: Codable {
    let metadata: Metadata
    let countries: [String: CountryTaxInfo]
}

struct Metadata: Codable {
    let version: String
    let lastUpdated: String
    let taxYears: [String]
    let dataSource: String
    let disclaimer: String
}

struct CountryTaxInfo: Codable {
    let name: String
    let code: String
    let currency: String
    let currencySymbol: String
    let taxYear: String
    let hasSubdivisions: Bool
    let subdivisionType: String?
    let description: String
    let federal: FederalTaxInfo
    let subdivisions: [SubdivisionInfo]?

    enum CodingKeys: String, CodingKey {
        case name, code, currency, currencySymbol, taxYear
        case hasSubdivisions = "hasSubdivisions"
        case subdivisionType = "subdivisionType"
        case description, federal, subdivisions
    }
}

struct FederalTaxInfo: Codable {
    let incomeTaxBrackets: [TaxBracket]?
    let incomeTaxRate: Double?
    let standardDeduction: Double?
    let socialSecurityRate: Double?
    let healthInsuranceRate: Double?
    let description: String
}

struct TaxBracket: Codable {
    let min: Double
    let max: Double?
    let rate: Double
}

struct SubdivisionInfo: Codable {
    let name: String
    let code: String
    let incomeTaxRate: Double?
    let incomeTaxBrackets: [TaxBracket]?
    let minWage: Double?
    let notes: String?
}

// MARK: - Enhanced Salary Calculator
class SalaryCalculationEngineV2 {
    static let shared = SalaryCalculationEngineV2()

    var taxDataProvider = TaxDataProvider()

    func calculateSalary(
        grossAnnual: Decimal,
        countryCode: String,
        subdivisionCode: String? = nil,
        employmentType: EmploymentType
    ) -> EnhancedSalaryBreakdown {

        guard let country = taxDataProvider.getCountry(code: countryCode) else {
            return EnhancedSalaryBreakdown(
                grossAnnualSalary: grossAnnual,
                netAnnualSalary: grossAnnual,
                country: countryCode,
                subdivision: subdivisionCode,
                taxBreakdown: [],
                currency: "$"
            )
        }

        var breakdown = EnhancedSalaryBreakdown(
            grossAnnualSalary: grossAnnual,
            netAnnualSalary: grossAnnual,
            country: countryCode,
            subdivision: subdivisionCode,
            taxBreakdown: [],
            currency: country.currencySymbol
        )

        var totalDeductions: Decimal = 0

        // Calculate Federal/National Tax
        if let brackets = country.federal.incomeTaxBrackets {
            let federalTax = calculateProgressiveTax(
                income: grossAnnual,
                brackets: brackets
            )
            totalDeductions += federalTax
            breakdown.taxBreakdown.append(
                TaxComponent(
                    name: "Federal Income Tax",
                    amount: federalTax,
                    rate: (federalTax / grossAnnual * 100)
                )
            )
        } else if let rate = country.federal.incomeTaxRate {
            let federalTax = grossAnnual * Decimal(rate) / 100
            totalDeductions += federalTax
            breakdown.taxBreakdown.append(
                TaxComponent(
                    name: "Income Tax",
                    amount: federalTax,
                    rate: rate
                )
            )
        }

        // Calculate Social Security
        if let ssRate = country.federal.socialSecurityRate {
            let ssTax = grossAnnual * Decimal(ssRate) / 100
            totalDeductions += ssTax
            breakdown.taxBreakdown.append(
                TaxComponent(
                    name: "Social Security",
                    amount: ssTax,
                    rate: ssRate
                )
            )
        }

        // Calculate Health Insurance
        if let healthRate = country.federal.healthInsuranceRate {
            let healthTax = grossAnnual * Decimal(healthRate) / 100
            totalDeductions += healthTax
            breakdown.taxBreakdown.append(
                TaxComponent(
                    name: "Health Insurance",
                    amount: healthTax,
                    rate: healthRate
                )
            )
        }

        // Calculate Subdivision Tax if applicable
        if let subdivisionCode = subdivisionCode,
           let subdivisions = country.subdivisions,
           let subdivision = subdivisions.first(where: { $0.code.lowercased() == subdivisionCode.lowercased() }) {

            if let subBrackets = subdivision.incomeTaxBrackets {
                let subTax = calculateProgressiveTax(income: grossAnnual, brackets: subBrackets)
                totalDeductions += subTax
                breakdown.taxBreakdown.append(
                    TaxComponent(
                        name: "\(subdivision.name) Tax",
                        amount: subTax,
                        rate: (subTax / grossAnnual * 100)
                    )
                )
            } else if let subRate = subdivision.incomeTaxRate {
                let subTax = grossAnnual * Decimal(subRate) / 100
                totalDeductions += subTax
                breakdown.taxBreakdown.append(
                    TaxComponent(
                        name: "\(subdivision.name) Tax",
                        amount: subTax,
                        rate: subRate
                    )
                )
            }
        }

        breakdown.netAnnualSalary = grossAnnual - totalDeductions
        breakdown.netMonthlySalary = breakdown.netAnnualSalary / 12
        breakdown.effectiveTaxRate = (totalDeductions / grossAnnual * 100)

        return breakdown
    }

    private func calculateProgressiveTax(income: Decimal, brackets: [TaxBracket]) -> Decimal {
        var tax: Decimal = 0

        for bracket in brackets {
            let minIncome = Decimal(bracket.min)
            let maxIncome = bracket.max.map(Decimal.init) ?? income
            let rate = Decimal(bracket.rate) / 100

            if income > minIncome {
                let taxableInThisBracket = min(income, maxIncome) - minIncome
                tax += taxableInThisBracket * rate
            }
        }

        return tax
    }
}

// MARK: - Models
struct EnhancedSalaryBreakdown {
    var grossAnnualSalary: Decimal
    var netAnnualSalary: Decimal
    var netMonthlySalary: Decimal = 0
    var netWeeklySalary: Decimal = 0
    var country: String
    var subdivision: String?
    var taxBreakdown: [TaxComponent]
    var effectiveTaxRate: Decimal = 0
    var currency: String
}

struct TaxComponent {
    let name: String
    let amount: Decimal
    let rate: Decimal
}

enum EmploymentType: String, CaseIterable {
    case fullTime = "Full-time Employee"
    case partTime = "Part-time Employee"
    case freelance = "Freelancer"
    case contractor = "Contractor"
}
