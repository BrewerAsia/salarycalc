import Foundation

/// Core calculator engine using Decimal for precise arithmetic
/// Handles all mathematical operations for business calculations
class CalculatorEngine {

    enum OperationType: String, Equatable {
        case add = "+"
        case subtract = "−"
        case multiply = "×"
        case divide = "÷"
    }

    enum CalculationError: Error, Equatable {
        case divisionByZero
        case invalidExpression
        case overflow
    }

    // MARK: - State
    private var accumulator: Decimal = 0
    private var currentInput: String = "0"
    private var operation: OperationType? = nil
    private var shouldClearNextInput: Bool = false

    // MARK: - Properties
    var displayValue: String {
        if currentInput.isEmpty || currentInput == "0" {
            return formatDecimal(accumulator)
        }
        return currentInput
    }

    var operationSymbol: String? {
        operation?.rawValue
    }

    // MARK: - Public Methods

    /// Adds a digit to current input
    func addDigit(_ digit: Int) {
        guard digit >= 0 && digit <= 9 else { return }

        if shouldClearNextInput {
            currentInput = String(digit)
            shouldClearNextInput = false
        } else {
            if currentInput == "0" && digit == 0 { return }
            if currentInput == "0" {
                currentInput = String(digit)
            } else if currentInput.count < 20 {
                currentInput.append(String(digit))
            }
        }
    }

    /// Adds decimal point to current input
    func addDecimal() {
        if shouldClearNextInput {
            currentInput = "0."
            shouldClearNextInput = false
            return
        }

        if !currentInput.contains(".") && currentInput.count < 20 {
            currentInput.append(".")
        }
    }

    /// Performs arithmetic operation
    func performOperation(_ op: OperationType) -> Result<Void, CalculationError> {
        if let previousOperation = operation {
            let result = calculate()
            switch result {
            case .success:
                operation = op
                shouldClearNextInput = true
            case .failure(let error):
                return .failure(error)
            }
        } else {
            accumulator = Decimal(string: currentInput) ?? 0
            operation = op
            shouldClearNextInput = true
        }

        return .success(())
    }

    /// Calculates the result
    func calculate() -> Result<Void, CalculationError> {
        guard let op = operation else {
            return .success(())
        }

        guard let current = Decimal(string: currentInput) else {
            return .failure(.invalidExpression)
        }

        let result: Result<Decimal, CalculationError>

        switch op {
        case .add:
            result = .success(accumulator + current)
        case .subtract:
            result = .success(accumulator - current)
        case .multiply:
            result = .success(accumulator * current)
        case .divide:
            if current == 0 {
                result = .failure(.divisionByZero)
            } else {
                result = .success(accumulator / current)
            }
        }

        switch result {
        case .success(let value):
            accumulator = value
            currentInput = formatDecimal(value)
            operation = nil
            shouldClearNextInput = true
            return .success(())
        case .failure(let error):
            return .failure(error)
        }
    }

    /// Clears all calculations (AC button)
    func clear() {
        accumulator = 0
        currentInput = "0"
        operation = nil
        shouldClearNextInput = false
    }

    /// Deletes last digit (backspace)
    func delete() {
        if shouldClearNextInput {
            currentInput = "0"
            shouldClearNextInput = false
            return
        }

        if currentInput.count == 1 {
            currentInput = "0"
        } else {
            currentInput.removeLast()
        }
    }

    /// Toggle sign of current input
    func toggleSign() {
        if let value = Decimal(string: currentInput) {
            currentInput = formatDecimal(-value)
        }
    }

    /// Calculate percentage of accumulated value
    func percentage() {
        if let value = Decimal(string: currentInput) {
            let result = value / 100
            currentInput = formatDecimal(result)
        }
    }

    /// Get current calculation as string for history
    func getCalculationExpression() -> String {
        if let op = operation {
            return "\(formatDecimal(accumulator)) \(op.rawValue) \(currentInput)"
        }
        return currentInput
    }

    /// Get current result
    func getCurrentResult() -> Decimal {
        return Decimal(string: currentInput) ?? accumulator
    }

    // MARK: - Private Methods

    /// Format Decimal for display
    private func formatDecimal(_ value: Decimal) -> String {
        // Remove trailing zeros and unnecessary decimal points
        let number = NSDecimalNumber(decimal: value)
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 15
        formatter.minimumIntegerDigits = 1
        formatter.groupingSeparator = ""

        if let formatted = formatter.string(from: number) {
            // Remove trailing zeros after decimal point
            if formatted.contains(".") {
                let trimmed = formatted.trimmingCharacters(in: CharacterSet(charactersIn: "0"))
                if trimmed.hasSuffix(".") {
                    return String(trimmed.dropLast())
                }
                return trimmed
            }
            return formatted
        }

        return String(describing: value)
    }
}
