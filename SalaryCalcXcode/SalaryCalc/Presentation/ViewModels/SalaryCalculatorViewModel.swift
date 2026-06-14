import Foundation
import SwiftUI

/// Main view model for salary calculator
class SalaryCalculatorViewModel: ObservableObject {

    @Published var grossSalary: String = ""
    @Published var selectedCountry: String = "United States"
    @Published var selectedState: String = "CA"
    @Published var selectedEmploymentType: String = "Full-time Employee"

    @Published var salaryBreakdown: SalaryCalculationEngine.SalaryBreakdown?
    @Published var calculationHistory: [SavedCalculation] = []
    @Published var userPreferences: UserPreferences = .default

    @Published var taxBreakdownItems: [TaxBreakdownDetail] = []

    private let engine = SalaryCalculationEngine()
    private let repository = SalaryCalculationRepository()

    init() {
        loadPreferences()
        loadHistory()
    }

    // MARK: - Calculation Methods

    func calculateSalary() {
        guard let gross = Decimal(string: grossSalary), gross > 0 else {
            salaryBreakdown = nil
            return
        }

        let input = SalaryCalculationEngine.SalaryInput(
            grossAnnualSalary: gross,
            country: selectedCountry,
            state: selectedCountry == "United States" ? selectedState : nil,
            employmentType: SalaryCalculationEngine.EmploymentType(
                rawValue: selectedEmploymentType
            ) ?? .fullTime
        )

        salaryBreakdown = engine.calculateSalary(input)
        updateTaxBreakdown()
    }

    private func updateTaxBreakdown() {
        guard let breakdown = salaryBreakdown else {
            taxBreakdownItems = []
            return
        }

        var items: [TaxBreakdownDetail] = []

        if breakdown.federalTax > 0 {
            items.append(TaxBreakdownDetail(
                id: "federal",
                label: "Federal Tax",
                amount: breakdown.federalTax,
                percentage: (breakdown.federalTax / breakdown.grossSalary) * 100
            ))
        }

        if breakdown.stateTax > 0 {
            items.append(TaxBreakdownDetail(
                id: "state",
                label: selectedCountry == "United States" ? "State Tax" : "Regional Tax",
                amount: breakdown.stateTax,
                percentage: (breakdown.stateTax / breakdown.grossSalary) * 100
            ))
        }

        if breakdown.socialSecurity > 0 {
            items.append(TaxBreakdownDetail(
                id: "social",
                label: "Social Security",
                amount: breakdown.socialSecurity,
                percentage: (breakdown.socialSecurity / breakdown.grossSalary) * 100
            ))
        }

        if breakdown.medicare > 0 {
            items.append(TaxBreakdownDetail(
                id: "medicare",
                label: "Medicare/Health",
                amount: breakdown.medicare,
                percentage: (breakdown.medicare / breakdown.grossSalary) * 100
            ))
        }

        if breakdown.healthInsurance > 0 {
            items.append(TaxBreakdownDetail(
                id: "health",
                label: "Health Insurance",
                amount: breakdown.healthInsurance,
                percentage: (breakdown.healthInsurance / breakdown.grossSalary) * 100
            ))
        }

        if breakdown.pensionContribution > 0 {
            items.append(TaxBreakdownDetail(
                id: "pension",
                label: "Pension/Retirement",
                amount: breakdown.pensionContribution,
                percentage: (breakdown.pensionContribution / breakdown.grossSalary) * 100
            ))
        }

        if breakdown.otherDeductions > 0 {
            items.append(TaxBreakdownDetail(
                id: "other",
                label: "Other Deductions",
                amount: breakdown.otherDeductions,
                percentage: (breakdown.otherDeductions / breakdown.grossSalary) * 100
            ))
        }

        taxBreakdownItems = items
    }

    // MARK: - History Methods

    func saveCurrentCalculation() {
        guard let breakdown = salaryBreakdown else { return }

        let calculation = SavedCalculation(
            country: selectedCountry,
            state: selectedCountry == "United States" ? selectedState : nil,
            employmentType: selectedEmploymentType,
            grossAnnualSalary: breakdown.grossSalary,
            netAnnualSalary: breakdown.netAnnualSalary,
            netMonthlySalary: breakdown.netMonthlySalary,
            totalTaxRate: breakdown.effectiveTaxRate
        )

        calculationHistory.insert(calculation, at: 0)

        if calculationHistory.count > userPreferences.historyLimit {
            calculationHistory.removeLast()
        }

        repository.saveCalculation(calculation)
    }

    func clearHistory() {
        calculationHistory.removeAll()
        repository.clearHistory()
    }

    func deleteHistoryItem(_ calculation: SavedCalculation) {
        calculationHistory.removeAll { $0.id == calculation.id }
        repository.deleteCalculation(calculation)
    }

    // MARK: - Preferences Methods

    func updatePreferences(_ preferences: UserPreferences) {
        userPreferences = preferences
        repository.savePreferences(preferences)
    }

    // MARK: - Getters

    func getCountryCurrencySymbol() -> String {
        return CountryConfig.allCountries
            .first { $0.name == selectedCountry }?
            .currencySymbol ?? "$"
    }

    func getAvailableStates() -> [String] {
        return CountryConfig.allCountries
            .first { $0.name == selectedCountry }?
            .stateOptions ?? []
    }

    func requiresStateSelection() -> Bool {
        return CountryConfig.allCountries
            .first { $0.name == selectedCountry }?
            .requiresState ?? false
    }

    // MARK: - Private Methods

    private func loadPreferences() {
        if let prefs = repository.loadPreferences() {
            userPreferences = prefs
            selectedCountry = prefs.defaultCountry
            selectedEmploymentType = prefs.defaultEmploymentType
        }
    }

    private func loadHistory() {
        calculationHistory = repository.loadCalculationHistory()
    }
}
