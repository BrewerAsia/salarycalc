import Foundation

/// Repository for managing calculation persistence
/// Handles saving and loading calculations and user preferences
class CalculationRepository {

    private let calculationDefaults = UserDefaults.standard
    private let calculationKey = "calcpro.calculations"
    private let preferencesKey = "calcpro.preferences"

    // MARK: - Calculation Operations

    func saveCalculation(_ calculation: Calculation) {
        var history = loadCalculationHistory()
        history.insert(calculation, at: 0)

        if let encoded = try? JSONEncoder().encode(history) {
            calculationDefaults.set(encoded, forKey: calculationKey)
        }
    }

    func loadCalculationHistory() -> [Calculation] {
        guard let data = calculationDefaults.data(forKey: calculationKey),
              let history = try? JSONDecoder().decode([Calculation].self, from: data) else {
            return []
        }
        return history
    }

    func deleteCalculation(_ calculation: Calculation) {
        var history = loadCalculationHistory()
        history.removeAll { $0.id == calculation.id }

        if let encoded = try? JSONEncoder().encode(history) {
            calculationDefaults.set(encoded, forKey: calculationKey)
        }
    }

    func clearHistory() {
        calculationDefaults.removeObject(forKey: calculationKey)
    }

    // MARK: - Preferences Operations

    func savePreferences(_ preferences: UserPreferences) {
        if let encoded = try? JSONEncoder().encode(preferences) {
            calculationDefaults.set(encoded, forKey: preferencesKey)
        }
    }

    func loadPreferences() -> UserPreferences? {
        guard let data = calculationDefaults.data(forKey: preferencesKey),
              let preferences = try? JSONDecoder().decode(UserPreferences.self, from: data) else {
            return nil
        }
        return preferences
    }
}
