import SwiftUI

/// Reusable calculator button component
struct CalculatorButton: View {

    enum ButtonType {
        case digit
        case operation
        case function
        case equals
    }

    let label: String
    let type: ButtonType
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(labelColor)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(backgroundColor)
                .contentShape(Rectangle())
        }
        .accessibilityLabel(accessibilityLabel)
    }

    // MARK: - Styling

    private var backgroundColor: Color {
        switch type {
        case .digit:
            return Color(UIColor { $0.userInterfaceStyle == .dark ? UIColor(white: 0.2, alpha: 1) : UIColor(white: 0.95, alpha: 1) })
        case .operation, .function:
            return Color(UIColor { $0.userInterfaceStyle == .dark ? UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1) : UIColor(red: 0.95, green: 0.5, blue: 0, alpha: 1) })
        case .equals:
            return Color(UIColor { $0.userInterfaceStyle == .dark ? UIColor(red: 0.3, green: 0.6, blue: 0.3, alpha: 1) : UIColor(red: 0.3, green: 0.7, blue: 0.3, alpha: 1) })
        }
    }

    private var labelColor: Color {
        switch type {
        case .digit:
            return Color(UIColor { $0.userInterfaceStyle == .dark ? .white : .black })
        case .operation, .function, .equals:
            return .white
        }
    }

    private var accessibilityLabel: String {
        switch label {
        case "+": return "Add"
        case "−": return "Subtract"
        case "×": return "Multiply"
        case "÷": return "Divide"
        case "=": return "Equals"
        case "AC": return "All Clear"
        case "%": return "Percent"
        case "±": return "Toggle Sign"
        case ".": return "Decimal Point"
        default: return label
        }
    }
}

#Preview {
    VStack(spacing: 12) {
        HStack(spacing: 12) {
            CalculatorButton(label: "7", type: .digit) {}
            CalculatorButton(label: "+", type: .operation) {}
            CalculatorButton(label: "=", type: .equals) {}
        }
    }
    .padding()
    .previewLayout(.sizeThatFits)
}
