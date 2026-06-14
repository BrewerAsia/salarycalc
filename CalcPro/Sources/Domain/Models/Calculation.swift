import Foundation

/// Represents a single calculation saved in history
struct Calculation: Identifiable, Codable {
    let id: UUID
    let expression: String
    let result: String
    let timestamp: Date
    var tags: [String] = []

    init(id: UUID = UUID(), expression: String, result: String, timestamp: Date = Date(), tags: [String] = []) {
        self.id = id
        self.expression = expression
        self.result = result
        self.timestamp = timestamp
        self.tags = tags
    }

    /// Display format for history: "expression = result"
    var displayText: String {
        return "\(expression) = \(result)"
    }

    /// Human-readable timestamp
    var formattedTime: String {
        let formatter = DateFormatter()
        let calendar = Calendar.current

        if calendar.isDateInToday(timestamp) {
            formatter.timeStyle = .short
            formatter.dateStyle = .none
            return formatter.string(from: timestamp)
        } else if calendar.isDateInYesterday(timestamp) {
            return "Yesterday"
        } else {
            formatter.dateStyle = .short
            formatter.timeStyle = .none
            return formatter.string(from: timestamp)
        }
    }
}

/// Calculator state and preferences
struct UserPreferences: Codable {
    var decimalPlaces: Int = 2
    var currencySymbol: String = "$"
    var themeMode: String = "system" // "light", "dark", "system"
    var keyboardSound: Bool = true
    var historyLimit: Int = 1000

    static var `default`: UserPreferences {
        return UserPreferences()
    }
}

/// Business calculator result
struct BusinessCalculationResult: Identifiable {
    let id: UUID = UUID()
    let title: String
    let values: [String: String]
    let timestamp: Date = Date()

    init(title: String, values: [String: String]) {
        self.title = title
        self.values = values
    }
}
