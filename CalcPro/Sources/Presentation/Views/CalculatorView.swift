import SwiftUI

/// Main calculator view with number pad and business calculators
struct CalculatorView: View {

    @StateObject private var viewModel = CalculatorViewModel()
    @State private var showHistory = false
    @State private var showSettings = false
    @State private var selectedTab: CalculatorTab = .basic

    enum CalculatorTab {
        case basic
        case tax
        case markup
        case tip
        case invoice
    }

    var body: some View {
        ZStack {
            Color(UIColor { $0.userInterfaceStyle == .dark ? UIColor(white: 0.05, alpha: 1) : UIColor(white: 0.99, alpha: 1) })
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Header
                HStack {
                    Button(action: { showHistory.toggle() }) {
                        Image(systemName: "clock.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.blue)
                    }
                    .accessibilityLabel("History")

                    Spacer()

                    Text("CalcPro")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.primary)

                    Spacer()

                    Button(action: { showSettings.toggle() }) {
                        Image(systemName: "gear")
                            .font(.system(size: 20))
                            .foregroundColor(.blue)
                    }
                    .accessibilityLabel("Settings")
                }
                .padding()
                .background(Color(UIColor { $0.userInterfaceStyle == .dark ? UIColor(white: 0.1, alpha: 1) : UIColor(white: 0.95, alpha: 1) }))

                // Display
                CalculatorDisplay(value: viewModel.displayValue, operationSymbol: viewModel.operationSymbol)
                    .padding()

                // Calculator selector
                Picker("Calculator Type", selection: $selectedTab) {
                    Text("Basic").tag(CalculatorTab.basic)
                    Text("Tax").tag(CalculatorTab.tax)
                    Text("Markup").tag(CalculatorTab.markup)
                    Text("Tip").tag(CalculatorTab.tip)
                    Text("Invoice").tag(CalculatorTab.invoice)
                }
                .pickerStyle(.segmented)
                .padding()

                // Calculator pad based on tab
                Group {
                    switch selectedTab {
                    case .basic:
                        BasicCalculatorPad(viewModel: viewModel)
                    case .tax:
                        TaxCalculatorView()
                    case .markup:
                        MarkupDiscountView()
                    case .tip:
                        TipCalculatorView()
                    case .invoice:
                        InvoiceCalculatorView()
                    }
                }

                Spacer()
            }

            // History sidebar
            if showHistory {
                VStack {
                    HStack {
                        Text("History")
                            .font(.headline)
                        Spacer()
                        Button(action: { showHistory = false }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 20))
                        }
                    }
                    .padding()

                    if viewModel.calculationHistory.isEmpty {
                        VStack {
                            Image(systemName: "clock.slash")
                                .font(.system(size: 40))
                                .foregroundColor(.gray)
                            Text("No history")
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        List {
                            ForEach(viewModel.calculationHistory) { calculation in
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(calculation.displayText)
                                        .font(.system(.body, design: .monospaced))
                                    Text(calculation.formattedTime)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    // Copy to clipboard or restore
                                    UIPasteboard.general.string = calculation.result
                                }
                            }
                            .onDelete { indexSet in
                                indexSet.forEach { index in
                                    viewModel.deleteHistoryItem(viewModel.calculationHistory[index])
                                }
                            }
                        }
                    }

                    Button(action: { viewModel.clearHistory() }) {
                        Text("Clear All")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red.opacity(0.3))
                            .cornerRadius(8)
                    }
                    .padding()
                }
                .frame(maxWidth: 300)
                .background(Color(UIColor { $0.userInterfaceStyle == .dark ? UIColor(white: 0.1, alpha: 1) : .white }))
                .transition(.move(edge: .leading))
            }
        }
        .sheet(isPresented: $showSettings) {
            SettingsView(viewModel: viewModel)
        }
    }
}

// MARK: - Basic Calculator Pad

struct BasicCalculatorPad: View {
    @ObservedObject var viewModel: CalculatorViewModel

    var body: some View {
        VStack(spacing: 12) {
            // Row 1: AC, +/-, %, ÷
            HStack(spacing: 12) {
                CalculatorButton(label: "AC", type: .function) {
                    viewModel.clear()
                }
                CalculatorButton(label: "±", type: .function) {
                    viewModel.toggleSign()
                }
                CalculatorButton(label: "%", type: .function) {
                    viewModel.percentage()
                }
                CalculatorButton(label: "÷", type: .operation) {
                    viewModel.performOperation(.divide)
                }
            }
            .frame(height: 60)

            // Row 2: 7, 8, 9, ×
            HStack(spacing: 12) {
                CalculatorButton(label: "7", type: .digit) {
                    viewModel.addDigit(7)
                }
                CalculatorButton(label: "8", type: .digit) {
                    viewModel.addDigit(8)
                }
                CalculatorButton(label: "9", type: .digit) {
                    viewModel.addDigit(9)
                }
                CalculatorButton(label: "×", type: .operation) {
                    viewModel.performOperation(.multiply)
                }
            }
            .frame(height: 60)

            // Row 3: 4, 5, 6, −
            HStack(spacing: 12) {
                CalculatorButton(label: "4", type: .digit) {
                    viewModel.addDigit(4)
                }
                CalculatorButton(label: "5", type: .digit) {
                    viewModel.addDigit(5)
                }
                CalculatorButton(label: "6", type: .digit) {
                    viewModel.addDigit(6)
                }
                CalculatorButton(label: "−", type: .operation) {
                    viewModel.performOperation(.subtract)
                }
            }
            .frame(height: 60)

            // Row 4: 1, 2, 3, +
            HStack(spacing: 12) {
                CalculatorButton(label: "1", type: .digit) {
                    viewModel.addDigit(1)
                }
                CalculatorButton(label: "2", type: .digit) {
                    viewModel.addDigit(2)
                }
                CalculatorButton(label: "3", type: .digit) {
                    viewModel.addDigit(3)
                }
                CalculatorButton(label: "+", type: .operation) {
                    viewModel.performOperation(.add)
                }
            }
            .frame(height: 60)

            // Row 5: 0, ., Delete, =
            HStack(spacing: 12) {
                CalculatorButton(label: "0", type: .digit) {
                    viewModel.addDigit(0)
                }
                CalculatorButton(label: ".", type: .digit) {
                    viewModel.addDecimal()
                }
                CalculatorButton(label: "⌫", type: .function) {
                    viewModel.delete()
                }
                CalculatorButton(label: "=", type: .equals) {
                    viewModel.equals()
                }
            }
            .frame(height: 60)
        }
        .padding()
    }
}

// MARK: - Placeholder Business Calculators

struct TaxCalculatorView: View {
    var body: some View {
        VStack {
            Text("Tax Calculator")
                .font(.headline)
            Spacer()
            Text("Coming in Phase 2")
                .foregroundColor(.gray)
            Spacer()
        }
        .padding()
    }
}

struct MarkupDiscountView: View {
    var body: some View {
        VStack {
            Text("Markup/Discount Calculator")
                .font(.headline)
            Spacer()
            Text("Coming in Phase 2")
                .foregroundColor(.gray)
            Spacer()
        }
        .padding()
    }
}

struct TipCalculatorView: View {
    var body: some View {
        VStack {
            Text("Tip Calculator")
                .font(.headline)
            Spacer()
            Text("Coming in Phase 2")
                .foregroundColor(.gray)
            Spacer()
        }
        .padding()
    }
}

struct InvoiceCalculatorView: View {
    var body: some View {
        VStack {
            Text("Invoice Calculator")
                .font(.headline)
            Spacer()
            Text("Coming in Phase 2")
                .foregroundColor(.gray)
            Spacer()
        }
        .padding()
    }
}

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: CalculatorViewModel

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Display")) {
                    Stepper("Decimal Places: \(viewModel.userPreferences.decimalPlaces)", value: $viewModel.userPreferences.decimalPlaces, in: 0...15)
                    TextField("Currency Symbol", text: $viewModel.userPreferences.currencySymbol)
                }

                Section(header: Text("Preferences")) {
                    Toggle("Keyboard Sound", isOn: $viewModel.userPreferences.keyboardSound)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        viewModel.updatePreferences(viewModel.userPreferences)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    CalculatorView()
}
