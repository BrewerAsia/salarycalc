import SwiftUI

/// Display component showing the current calculation value and operation
struct CalculatorDisplay: View {

    let value: String
    let operationSymbol: String?

    var body: some View {
        VStack(alignment: .trailing, spacing: 8) {
            // Operation indicator
            if let op = operationSymbol {
                Text(op)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.gray)
                    .transition(.opacity)
            }

            // Main display value
            Text(value)
                .font(.system(size: 48, weight: .semibold, design: .default))
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .foregroundColor(.primary)
                .transition(.identity)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.horizontal, 24)
        .padding(.vertical, 20)
        .background(
            Color(UIColor { $0.userInterfaceStyle == .dark ? UIColor(white: 0.1, alpha: 1) : UIColor(white: 0.98, alpha: 1) })
        )
        .cornerRadius(12)
        .accessibilityLabel("Display")
        .accessibilityValue(value)
    }
}

#Preview {
    VStack(spacing: 20) {
        CalculatorDisplay(value: "1,234.56", operationSymbol: "+")
        CalculatorDisplay(value: "0", operationSymbol: nil)
    }
    .padding()
    .previewLayout(.sizeThatFits)
}
