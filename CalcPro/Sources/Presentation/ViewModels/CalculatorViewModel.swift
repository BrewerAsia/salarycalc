import Foundation
import SwiftUI

/// Main calculator view model
/// Manages calculator state, operations, and history
class CalculatorViewModel: ObservableObject {

    @Published var displayValue: String = "0"
    @Published var operationSymbol: String? = nil
    @Published var calculationHistory: [Calculation] = []
    @Published var userPreferences: UserPreferences = .default

    private let engine = CalculatorEngine()
    private let repository = CalculationRepository()

    init() {
        loadPreferences()
        loadHistory()
    }

    // MARK: - Input Methods

    func addDigit(_ digit: Int) {
        engine.addDigit(digit)
        updateDisplay()
    }

    func addDecimal() {
        engine.addDecimal()
        updateDisplay()
    }

    func performOperation(_ op: CalculatorEngine.OperationType) {
        let result = engine.performOperation(op)
        switch result {
        case .success:
            updateDisplay()
        case .failure(let error):
            handleError(error)
        }
    }

    func equals() {
        let result = engine.calculate()
        switch result {
        case .success:
            updateDisplay()
            saveToHistory()
        case .failure(let error):
            handleError(error)
        }
    }

    func clear() {
        engine.clear()
        updateDisplay()
    }

    func delete() {
        engine.delete()
        updateDisplay()
    }

    func toggleSign() {
        engine.toggleSign()
        updateDisplay()
    }

    func percentage() {
        engine.percentage()
        updateDisplay()
    }

    // MARK: - History Methods

    private func saveToHistory() {
        let expression = engine.getCalculationExpression()
        let result = engine.getCurrentResult()
        let calculation = Calculation(
            expression: expression,
            result: formatResult(result)
        )

        calculationHistory.insert(calculation, at: 0)

        // Keep history limit
        if calculationHistory.count > userPreferences.historyLimit {
            calculationHistory.removeLast()
        }

        repository.saveCalculation(calculation)
    }

    func clearHistory() {
        calculationHistory.removeAll()
        repository.clearHistory()
    }

    func deleteHistoryItem(_ calculation: Calculation) {
        calculationHistory.removeAll { $0.id == calculation.id }
        repository.deleteCalculation(calculation)
    }

    // MARK: - Preferences Methods

    func updatePreferences(_ preferences: UserPreferences) {
        userPreferences = preferences
        repository.savePreferences(preferences)
    }

    // MARK: - Private Methods

    private func updateDisplay() {
        displayValue = engine.displayValue
        operationSymbol = engine.operationSymbol
        objectWillChange.send()
    }

    private func formatResult(_ value: Decimal) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = min(userPreferences.decimalPlaces, 15)
        formatter.minimumIntegerDigits = 1
        formatter.groupingSeparator = ""

        let number = NSDecimalNumber(decimal: value)
        return formatter.string(from: number) ?? String(describing: value)
    }

    private func handleError(_ error: CalculatorEngine.CalculationError) {
        switch error {
        case .divisionByZero:
            displayValue = "Error"
        case .invalidExpression:
            displayValue = "Error"
        case .overflow:
            displayValue = "Overflow"
        }
    }

    private func loadPreferences() {
        if let prefs = repository.loadPreferences() {
            userPreferences = prefs
        }
    }

    private func loadHistory() {
        calculationHistory = repository.loadCalculationHistory()
    }
}
