import Foundation

/// Repository for managing salary calculation persistence
class SalaryCalculationRepository {

    private let defaults = UserDefaults.standard
    private let calculationKey = "salarycalc.calculations"
    private let preferencesKey = "salarycalc.preferences"

    // MARK: - Calculation Operations

    func saveCalculation(_ calculation: SavedCalculation) {
        var history = loadCalculationHistory()
        history.insert(calculation, at: 0)

        if let encoded = try? JSONEncoder().encode(history) {
            defaults.set(encoded, forKey: calculationKey)
        }
    }

    func loadCalculationHistory() -> [SavedCalculation] {
        guard let data = defaults.data(forKey: calculationKey),
              let history = try? JSONDecoder().decode([SavedCalculation].self, from: data) else {
            return []
        }
        return history
    }

    func deleteCalculation(_ calculation: SavedCalculation) {
        var history = loadCalculationHistory()
        history.removeAll { $0.id == calculation.id }

        if let encoded = try? JSONEncoder().encode(history) {
            defaults.set(encoded, forKey: calculationKey)
        }
    }

    func clearHistory() {
        defaults.removeObject(forKey: calculationKey)
    }

    // MARK: - Preferences Operations

    func savePreferences(_ preferences: UserPreferences) {
        if let encoded = try? JSONEncoder().encode(preferences) {
            defaults.set(encoded, forKey: preferencesKey)
        }
    }

    func loadPreferences() -> UserPreferences? {
        guard let data = defaults.data(forKey: preferencesKey),
              let preferences = try? JSONDecoder().decode(UserPreferences.self, from: data) else {
            return nil
        }
        return preferences
    }
}
