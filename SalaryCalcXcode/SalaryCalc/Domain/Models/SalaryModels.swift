import Foundation

// MARK: - Salary Calculation Models

/// Represents a saved salary calculation
struct SavedCalculation: Identifiable, Codable {
    let id: UUID
    let country: String
    let state: String?
    let employmentType: String
    let grossAnnualSalary: Decimal
    let netAnnualSalary: Decimal
    let netMonthlySalary: Decimal
    let totalTaxRate: Decimal
    let timestamp: Date

    init(
        id: UUID = UUID(),
        country: String,
        state: String?,
        employmentType: String,
        grossAnnualSalary: Decimal,
        netAnnualSalary: Decimal,
        netMonthlySalary: Decimal,
        totalTaxRate: Decimal,
        timestamp: Date = Date()
    ) {
        self.id = id
        self.country = country
        self.state = state
        self.employmentType = employmentType
        self.grossAnnualSalary = grossAnnualSalary
        self.netAnnualSalary = netAnnualSalary
        self.netMonthlySalary = netMonthlySalary
        self.totalTaxRate = totalTaxRate
        self.timestamp = timestamp
    }

    var displayText: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"

        let gross = formatter.string(from: NSDecimalNumber(decimal: grossAnnualSalary)) ?? "N/A"
        let net = formatter.string(from: NSDecimalNumber(decimal: netAnnualSalary)) ?? "N/A"

        return "\(country): \(gross) → \(net)"
    }

    var formattedTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        return formatter.string(from: timestamp)
    }
}

/// Country configuration
struct CountryConfig: Identifiable {
    let id: String
    let name: String
    let flag: String
    let currency: String
    let currencySymbol: String
    let requiresState: Bool
    let stateOptions: [String]?

    static let allCountries: [CountryConfig] = [
        CountryConfig(
            id: "US",
            name: "United States",
            flag: "🇺🇸",
            currency: "USD",
            currencySymbol: "$",
            requiresState: true,
            stateOptions: [
                "CA", "NY", "TX", "FL", "WA", "IL", "PA", "OH",
                "GA", "NC", "MI", "NJ", "VA", "MA", "CO"
            ]
        ),
        CountryConfig(
            id: "UK",
            name: "United Kingdom",
            flag: "🇬🇧",
            currency: "GBP",
            currencySymbol: "£",
            requiresState: false,
            stateOptions: nil
        ),
        CountryConfig(
            id: "CA",
            name: "Canada",
            flag: "🇨🇦",
            currency: "CAD",
            currencySymbol: "C$",
            requiresState: true,
            stateOptions: [
                "ON", "QC", "BC", "AB", "MB", "SK", "NS", "NB", "NL", "PE"
            ]
        ),
        CountryConfig(
            id: "AU",
            name: "Australia",
            flag: "🇦🇺",
            currency: "AUD",
            currencySymbol: "A$",
            requiresState: false,
            stateOptions: nil
        ),
        CountryConfig(
            id: "DE",
            name: "Germany",
            flag: "🇩🇪",
            currency: "EUR",
            currencySymbol: "€",
            requiresState: false,
            stateOptions: nil
        ),
        CountryConfig(
            id: "FR",
            name: "France",
            flag: "🇫🇷",
            currency: "EUR",
            currencySymbol: "€",
            requiresState: false,
            stateOptions: nil
        ),
        CountryConfig(
            id: "IN",
            name: "India",
            flag: "🇮🇳",
            currency: "INR",
            currencySymbol: "₹",
            requiresState: false,
            stateOptions: nil
        ),
        CountryConfig(
            id: "CH",
            name: "Switzerland",
            flag: "🇨🇭",
            currency: "CHF",
            currencySymbol: "CHF",
            requiresState: false,
            stateOptions: nil
        )
    ]
}

/// User preferences
struct UserPreferences: Codable {
    var defaultCountry: String = "United States"
    var defaultEmploymentType: String = "Full-time Employee"
    var theme: String = "system" // "light", "dark", "system"
    var decimalPlaces: Int = 2
    var historyLimit: Int = 100

    static var `default`: UserPreferences {
        return UserPreferences()
    }
}

/// Tax breakdown details
struct TaxBreakdownDetail: Identifiable {
    let id: String
    let label: String
    let amount: Decimal
    let percentage: Decimal

    var displayText: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 0

        let amountStr = formatter.string(from: NSDecimalNumber(decimal: amount)) ?? "N/A"
        let percentStr = String(format: "%.1f%%", NSDecimalNumber(decimal: percentage).doubleValue)

        return "\(label): \(amountStr) (\(percentStr))"
    }
}
