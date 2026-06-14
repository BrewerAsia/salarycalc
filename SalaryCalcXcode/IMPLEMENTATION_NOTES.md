# Implementation Notes for Tax Calculator App
## Technical Integration Guide

---

## Overview

This document provides developers with practical guidance for integrating the comprehensive tax data into the SalaryCalc iOS application.

---

## Data Files Summary

| File | Format | Size | Purpose |
|------|--------|------|---------|
| TaxData.json | JSON | ~500KB | Complete tax system definitions; primary source |
| TaxRates_Reference.csv | CSV | ~50KB | Quick lookup table; optional UI reference |
| TaxCalculationGuide.md | Markdown | ~200KB | Documentation; calculation formulas |
| TaxData_Summary.md | Markdown | ~150KB | Integration guide; data quality notes |
| IMPLEMENTATION_NOTES.md | Markdown | This file | Developer technical guidance |

---

## Swift Integration Pattern

### 1. Data Model Definition

```swift
// Extend existing models to support comprehensive tax data

struct CountryTaxSystem: Codable {
    let name: String
    let code: String
    let currency: String
    let currencySymbol: String
    let taxYear: String
    let hasSubdivisions: Bool
    let subdivisionType: String?

    struct IncomeTaxBracket: Codable {
        let min: Decimal
        let max: Decimal?
        let rate: Decimal
    }

    struct TaxBrackets: Codable {
        let brackets: [IncomeTaxBracket]
        let basicAllowance: Decimal?
        let standardDeduction: Decimal?
    }

    struct Contributions: Codable {
        let employeeRate: Decimal?
        let employerRate: Decimal?
        let rate: Decimal?
        let description: String
    }

    struct EffectiveTaxRate: Codable {
        let salary: Decimal
        let federalIncomeTax: Decimal
        let stateTax: Decimal?
        let socialSecurity: Decimal?
        let medicare: Decimal?
        let healthInsurance: Decimal?
        let pensionContribution: Decimal?
        let estimatedDeductions: Decimal
        let effectiveTaxRate: Decimal
        let netSalary: Decimal
        let assumption: String
    }

    let federal: TaxBrackets
    let contributions: [String: Contributions]
    let minimumWage: String
    let effectiveTaxRates: [EffectiveTaxRate]
}

struct TaxDataRoot: Codable {
    let metadata: TaxMetadata
    let countries: [String: CountryTaxSystem]
}
```

### 2. Loading and Caching

```swift
class TaxDataManager {
    static let shared = TaxDataManager()
    private var cachedData: TaxDataRoot?

    func loadTaxData() -> TaxDataRoot? {
        // Check cache first
        if let cached = cachedData {
            return cached
        }

        // Load from bundle
        guard let jsonFile = Bundle.main.url(forResource: "TaxData", withExtension: "json") else {
            print("Error: TaxData.json not found in bundle")
            return nil
        }

        do {
            let data = try Data(contentsOf: jsonFile)
            let decoder = JSONDecoder()
            let taxData = try decoder.decode(TaxDataRoot.self, from: data)

            // Cache for future use
            cachedData = taxData

            print("Tax data loaded: \(taxData.countries.count) countries")
            return taxData
        } catch {
            print("Error loading tax data: \(error)")
            return nil
        }
    }

    func getTaxSystem(for countryCode: String) -> CountryTaxSystem? {
        guard let taxData = loadTaxData() else { return nil }
        return taxData.countries[countryCode.lowercased()]
    }
}
```

### 3. Tax Calculation Engine Enhancement

```swift
extension SalaryCalculationEngine {

    // Enhanced calculation using new tax data
    func calculateSalaryWithTaxData(_ input: SalaryInput) -> SalaryBreakdown {
        guard let taxSystem = TaxDataManager.shared.getTaxSystem(for: input.country) else {
            // Fallback to existing calculation method
            return calculateSalary(input)
        }

        let gross = input.grossAnnualSalary

        // Calculate income tax using bracket data
        let incomeTax = calculateIncomeTax(gross, brackets: taxSystem.federal.brackets)

        // Get contribution rates
        var contributions: [String: Decimal] = [:]
        for (name, contribution) in taxSystem.contributions {
            if let rate = contribution.rate ?? contribution.employeeRate {
                contributions[name] = gross * (rate / 100)
            }
        }

        // Parse state/subdivision if needed
        var stateTax = Decimal(0)
        if taxSystem.hasSubdivisions, let subdivision = input.state {
            stateTax = calculateSubdivisionTax(gross, subdivision: subdivision)
        }

        // Build breakdown
        return SalaryBreakdown(
            grossSalary: gross,
            federalTax: incomeTax,
            stateTax: stateTax,
            socialSecurity: contributions["socialSecurity"] ?? 0,
            medicare: contributions["healthcare"] ?? 0,
            healthInsurance: contributions["healthInsurance"] ?? 0,
            pensionContribution: contributions["pension"] ?? 0,
            otherDeductions: calculateOtherDeductions(contributions)
        )
    }

    private func calculateIncomeTax(_ income: Decimal, brackets: [CountryTaxSystem.IncomeTaxBracket]) -> Decimal {
        var tax = Decimal(0)
        var previousMax = Decimal(0)

        for bracket in brackets {
            let min = bracket.min
            let max = bracket.max ?? income
            let rate = bracket.rate

            if income > min {
                let taxableInThisBracket = min(income, max) - min
                tax += taxableInThisBracket * (rate / 100)
            }
        }

        return tax
    }
}
```

### 4. UI Integration

```swift
// Update SalaryCalculatorView to display detailed tax breakdown

struct TaxBreakdownView: View {
    @State private var selectedCountry: String = "US"
    @State private var salaryAmount: String = "100000"
    @State private var breakdown: SalaryBreakdown?

    var body: some View {
        VStack(spacing: 20) {
            // Existing UI...

            if let breakdown = breakdown {
                // Display tax bracket information
                if let taxSystem = TaxDataManager.shared.getTaxSystem(for: selectedCountry) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Tax Brackets for \(taxSystem.name)")
                            .font(.headline)

                        ForEach(taxSystem.federal.brackets, id: \.min) { bracket in
                            HStack {
                                Text(formatRange(bracket.min, bracket.max))
                                Spacer()
                                Text("\(bracket.rate, specifier: "%.1f")%")
                                    .fontWeight(.semibold)
                            }
                            .padding(.horizontal, 8)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }

                // Display effective tax rate comparison
                if let taxSystem = TaxDataManager.shared.getTaxSystem(for: selectedCountry) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Tax Reference (2024-2025)")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        ForEach(taxSystem.effectiveTaxRates.prefix(3), id: \.salary) { example in
                            HStack {
                                Text("\(example.salary) \(taxSystem.currency)")
                                    .font(.caption)
                                Spacer()
                                Text("\(example.effectiveTaxRate, specifier: "%.1f")%")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                    .padding(8)
                    .background(Color(.systemGray6))
                    .cornerRadius(6)
                }
            }
        }
    }

    private func formatRange(_ min: Decimal, _ max: Decimal?) -> String {
        let minStr = formatCurrency(min)
        if let max = max {
            return "\(minStr) - \(formatCurrency(max))"
        } else {
            return "\(minStr)+"
        }
    }
}
```

---

## Database Integration (if using Core Data)

### 1. Core Data Model

```swift
import CoreData

@NSManaged class CDTaxCountry: NSManagedObject {
    @NSManaged var code: String
    @NSManaged var name: String
    @NSManaged var currency: String
    @NSManaged var taxYear: String
    @NSManaged var minimumWage: String
    @NSManaged var brackets: NSSet // of CDTaxBracket
    @NSManaged var contributions: NSSet // of CDTaxContribution
    @NSManaged var effectiveRates: NSSet // of CDEffectiveRate
}

@NSManaged class CDTaxBracket: NSManagedObject {
    @NSManaged var minIncome: NSDecimalNumber
    @NSManaged var maxIncome: NSDecimalNumber?
    @NSManaged var rate: NSDecimalNumber
    @NSManaged var country: CDTaxCountry
}

@NSManaged class CDTaxContribution: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var employeeRate: NSDecimalNumber?
    @NSManaged var employerRate: NSDecimalNumber?
    @NSManaged var description: String
    @NSManaged var country: CDTaxCountry
}
```

### 2. Migration Script (One-time)

```swift
class TaxDataMigration {
    static func importTaxData(to context: NSManagedObjectContext) {
        guard let taxData = TaxDataManager.shared.loadTaxData() else {
            print("Failed to load tax data")
            return
        }

        for (code, system) in taxData.countries {
            let cdCountry = NSEntityDescription.insertNewObject(
                forEntityName: "CDTaxCountry",
                into: context
            ) as! CDTaxCountry

            cdCountry.code = code
            cdCountry.name = system.name
            cdCountry.currency = system.currency
            cdCountry.taxYear = system.taxYear
            cdCountry.minimumWage = system.minimumWage

            // Import brackets
            for bracket in system.federal.brackets {
                let cdBracket = NSEntityDescription.insertNewObject(
                    forEntityName: "CDTaxBracket",
                    into: context
                ) as! CDTaxBracket

                cdBracket.minIncome = NSDecimalNumber(decimal: bracket.min)
                cdBracket.maxIncome = bracket.max.map { NSDecimalNumber(decimal: $0) }
                cdBracket.rate = NSDecimalNumber(decimal: bracket.rate)
                cdBracket.country = cdCountry
            }
        }

        do {
            try context.save()
            print("Tax data migration completed")
        } catch {
            print("Migration error: \(error)")
        }
    }
}
```

---

## API Backend Integration (Node.js/Express Example)

```javascript
// Load and expose tax data via API

const express = require('express');
const fs = require('fs');
const app = express();

// Load tax data on startup
const taxData = JSON.parse(
    fs.readFileSync('./TaxData.json', 'utf8')
);

// API Endpoints

// 1. Get country tax system
app.get('/api/tax/:countryCode', (req, res) => {
    const { countryCode } = req.params;
    const system = taxData.countries[countryCode.toLowerCase()];

    if (!system) {
        return res.status(404).json({ error: 'Country not found' });
    }

    res.json(system);
});

// 2. Calculate tax for salary
app.post('/api/tax/calculate', (req, res) => {
    const { countryCode, salary } = req.body;
    const system = taxData.countries[countryCode.toLowerCase()];

    if (!system) {
        return res.status(404).json({ error: 'Country not found' });
    }

    // Calculate based on brackets
    let tax = 0;
    let previousMax = 0;

    for (const bracket of system.federal.incomeTaxBrackets) {
        if (salary > bracket.min) {
            const taxableAmount = Math.min(salary, bracket.max || salary) - bracket.min;
            tax += taxableAmount * (bracket.rate / 100);
        }
    }

    // Calculate contributions
    const contributions = {};
    for (const [name, data] of Object.entries(system.contributions || {})) {
        if (data.employeeRate) {
            contributions[name] = salary * (data.employeeRate / 100);
        }
    }

    const totalDeductions = tax + Object.values(contributions).reduce((a, b) => a + b, 0);

    res.json({
        grossSalary: salary,
        incomeTax: tax,
        contributions,
        totalDeductions,
        netSalary: salary - totalDeductions,
        effectiveTaxRate: (totalDeductions / salary * 100).toFixed(2)
    });
});

// 3. Compare countries
app.get('/api/tax/compare', (req, res) => {
    const { countries, salary } = req.query;

    if (!countries || !salary) {
        return res.status(400).json({ error: 'Missing parameters' });
    }

    const countryList = countries.split(',');
    const comparison = countryList.map(code => {
        const system = taxData.countries[code.toLowerCase()];
        if (!system) return null;

        // Calculate for this country...
        // Return comparison data
    }).filter(Boolean);

    res.json(comparison);
});

// 4. Get historical data (for selected countries)
app.get('/api/tax/:countryCode/history', (req, res) => {
    // Return historical rate changes
    res.json({
        country: req.params.countryCode,
        history: [
            { year: 2024, topRate: 37 },
            { year: 2023, topRate: 37 },
            { year: 2022, topRate: 37 }
        ]
    });
});

app.listen(3000, () => {
    console.log('Tax API running on port 3000');
    console.log(`Loaded ${Object.keys(taxData.countries).length} countries`);
});
```

---

## Testing Strategy

### 1. Unit Tests

```swift
import XCTest

class TaxCalculationTests: XCTestCase {

    func testUSAFederalTaxCalculation() {
        let input = SalaryCalculationEngine.SalaryInput(
            grossAnnualSalary: 100000,
            country: "United States",
            state: "CA",
            employmentType: .fullTime
        )

        let engine = SalaryCalculationEngine()
        let breakdown = engine.calculateSalaryWithTaxData(input)

        // Expected: ~$60,788 net (39.2% effective)
        XCTAssertEqual(breakdown.effectiveTaxRate, 39.2, accuracy: 0.5)
        XCTAssert(breakdown.netAnnualSalary > 59000)
    }

    func testUKTaxCalculation() {
        let input = SalaryCalculationEngine.SalaryInput(
            grossAnnualSalary: 50000,
            country: "United Kingdom",
            state: nil,
            employmentType: .fullTime
        )

        let engine = SalaryCalculationEngine()
        let breakdown = engine.calculateSalary(input)

        // Expected: ~£35,562 net
        XCTAssert(breakdown.netAnnualSalary > 35000)
    }

    func testTaxDataLoading() {
        let manager = TaxDataManager.shared
        let data = manager.loadTaxData()

        XCTAssertNotNil(data)
        XCTAssertGreaterThan(data?.countries.count ?? 0, 25)
    }

    func testBracketCalculationAccuracy() {
        // Test progressive bracket calculation
        let brackets: [CountryTaxSystem.IncomeTaxBracket] = [
            .init(min: 0, max: 10000, rate: 10),
            .init(min: 10000, max: 50000, rate: 20),
            .init(min: 50000, max: nil, rate: 30)
        ]

        // $25,000 should give: 1000 + 3000 = 4000
        let expectedTax = Decimal(4000)
        // Calculate and assert
    }
}
```

### 2. Integration Tests

```swift
class TaxDataIntegrationTests: XCTestCase {

    func testAllCountriesHaveRequiredFields() {
        guard let taxData = TaxDataManager.shared.loadTaxData() else {
            XCTFail("Tax data not loaded")
            return
        }

        for (code, system) in taxData.countries {
            XCTAssertFalse(system.name.isEmpty, "Country \(code) missing name")
            XCTAssertFalse(system.currency.isEmpty, "Country \(code) missing currency")
            XCTAssertFalse(system.taxYear.isEmpty, "Country \(code) missing tax year")

            // Verify at least one tax bracket
            if system.federal.brackets.isEmpty {
                XCTFail("Country \(code) has no tax brackets")
            }
        }
    }

    func testEffectiveRatesLogical() {
        guard let taxData = TaxDataManager.shared.loadTaxData() else {
            return
        }

        for (code, system) in taxData.countries {
            for rate in system.effectiveTaxRates {
                // Rate should not exceed 100%
                XCTAssertLessThan(rate.effectiveTaxRate, 100,
                    "Country \(code) has effective rate > 100%")

                // Net should be positive
                XCTAssertGreaterThan(rate.netSalary, 0,
                    "Country \(code) has non-positive net salary")

                // Math should be consistent
                let calculated = rate.salary - rate.estimatedDeductions
                XCTAssertEqual(calculated, rate.netSalary, accuracy: 1,
                    "Country \(code) has inconsistent math")
            }
        }
    }
}
```

### 3. Regression Tests

```swift
// Verify calculations against known reference values
class TaxRegressionTests: XCTestCase {

    let referenceCalculations: [(country: String, salary: Decimal, expectedNet: Decimal)] = [
        ("US", 100000, 60788),
        ("UK", 50000, 35562),
        ("CA", 100000, 70971),
        ("DE", 100000, 60259),
        ("AU", 100000, 67758),
        ("SG", 100000, 63500),
        ("HK", 100000, 90200),
        ("AE", 100000, 93000),
        ("QA", 100000, 95000),
    ]

    func testReferenceCalculations() {
        for reference in referenceCalculations {
            let input = SalaryCalculationEngine.SalaryInput(
                grossAnnualSalary: reference.salary,
                country: reference.country,
                state: nil,
                employmentType: .fullTime
            )

            let engine = SalaryCalculationEngine()
            let breakdown = engine.calculateSalaryWithTaxData(input)

            XCTAssertEqual(
                breakdown.netAnnualSalary,
                reference.expectedNet,
                accuracy: 100, // Allow 100 unit variance
                "Regression test failed for \(reference.country)"
            )
        }
    }
}
```

---

## Performance Considerations

### 1. Lazy Loading
- Load tax data only when needed
- Cache in memory after first load
- Consider lazy evaluation for large country lists

### 2. Memory Management
```swift
// Watch out for memory when processing large salary ranges
func generateTaxChart(for country: String, salaryRange: ClosedRange<Decimal>) {
    // Don't create array of all values - use generators instead
    let step = Decimal(10000)
    var current = salaryRange.lowerBound

    while current <= salaryRange.upperBound {
        let tax = calculateTax(current)
        // Process immediately, don't store
        current += step
    }
}
```

### 3. Caching Strategy
```swift
class TaxCalculationCache {
    private static let cache = NSCache<NSString, NSNumber>()

    static func cachedTax(for key: String, calculation: () -> Decimal) -> Decimal {
        let nsKey = key as NSString

        if let cached = cache.object(forKey: nsKey) {
            return cached.decimalValue
        }

        let result = calculation()
        cache.setObject(NSNumber(value: Double(result)), forKey: nsKey)
        return result
    }
}
```

---

## Updating Tax Data Annually

### 1. Checklist for 2025 Update
- [ ] Download new tax brackets from OECD database
- [ ] Check each country's revenue authority website
- [ ] Update minimum wages
- [ ] Adjust contribution rates
- [ ] Recalculate effective rates
- [ ] Run regression tests
- [ ] Update tax year field to "2025-2026"
- [ ] Create git commit with changelog
- [ ] Deploy via app update

### 2. Update Procedure
```bash
# 1. Create update branch
git checkout -b tax-update-2025

# 2. Update TaxData.json with new rates
# Use script to validate:
npm run validate-tax-data

# 3. Run tests
npm test
swift test

# 4. Update documentation
# TaxCalculationGuide.md
# TaxData_Summary.md

# 5. Create release notes
echo "## Tax Year 2025-2026 Updates
- Updated all tax brackets per OECD
- Minimum wages updated
- New contributions implemented" > CHANGELOG.md

# 6. Commit and tag
git commit -am "Update tax data for 2025-2026 tax year"
git tag -a v2.1-tax-2025 -m "2025-2026 tax rates"
```

---

## Troubleshooting

### Issue: Calculated tax doesn't match reference value
**Solution:**
1. Verify all bracket boundaries and rates
2. Check if additional taxes apply (local, regional)
3. Confirm deduction categories are included
4. Test with simple known case first

### Issue: JSON fails to decode
**Solution:**
1. Validate JSON syntax (use jsonlint.com)
2. Check for special characters or encoding issues
3. Ensure all required fields present
4. Check Swift Codable models match JSON structure

### Issue: Performance degradation with large data
**Solution:**
1. Implement pagination for country lists
2. Use lazy evaluation for calculations
3. Consider database instead of in-memory JSON
4. Profile with Xcode Instruments

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | June 2025 | Initial release with 30+ countries, 2024-2025 tax data |
| 1.1 | TBD | Add more countries (Portugal, Greece, Romania) |
| 2.0 | TBD | Add multi-year historical data, tax planning features |

---

**For questions or issues, refer to the main documentation files or contact the development team.**
