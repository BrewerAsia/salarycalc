import SwiftUI

/// Main salary calculator view
struct SalaryCalculatorView: View {

    @StateObject private var viewModel = SalaryCalculatorViewModel()
    @State private var showHistory = false
    @State private var showSettings = false

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

                    Text("SalaryCalc")
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

                ScrollView {
                    VStack(spacing: 20) {
                        // Country Selection
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Country")
                                .font(.headline)

                            Picker("Country", selection: $viewModel.selectedCountry) {
                                ForEach(CountryConfig.allCountries, id: \.id) { country in
                                    Text("\(country.flag) \(country.name)").tag(country.name)
                                }
                            }
                            .pickerStyle(.menu)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding()
                        .background(Color(UIColor { $0.userInterfaceStyle == .dark ? UIColor(white: 0.1, alpha: 1) : .white }))
                        .cornerRadius(12)

                        // State Selection (if applicable)
                        if viewModel.requiresStateSelection() {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("State/Province")
                                    .font(.headline)

                                Picker("State", selection: $viewModel.selectedState) {
                                    ForEach(viewModel.getAvailableStates(), id: \.self) { state in
                                        Text(state).tag(state)
                                    }
                                }
                                .pickerStyle(.menu)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding()
                            .background(Color(UIColor { $0.userInterfaceStyle == .dark ? UIColor(white: 0.1, alpha: 1) : .white }))
                            .cornerRadius(12)
                        }

                        // Employment Type
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Employment Type")
                                .font(.headline)

                            Picker("Type", selection: $viewModel.selectedEmploymentType) {
                                Text("Full-time Employee").tag("Full-time Employee")
                                Text("Part-time Employee").tag("Part-time Employee")
                                Text("Freelancer/Self-Employed").tag("Freelancer/Self-Employed")
                                Text("Contractor").tag("Contractor")
                            }
                            .pickerStyle(.menu)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding()
                        .background(Color(UIColor { $0.userInterfaceStyle == .dark ? UIColor(white: 0.1, alpha: 1) : .white }))
                        .cornerRadius(12)

                        // Salary Input
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Gross Annual Salary")
                                .font(.headline)

                            HStack {
                                Text(viewModel.getCountryCurrencySymbol())
                                    .font(.system(size: 18, weight: .semibold))

                                TextField("Enter salary", text: $viewModel.grossSalary)
                                    .keyboardType(.decimalPad)
                                    .font(.system(size: 18, design: .default))
                                    .onChange(of: viewModel.grossSalary) { _ in
                                        viewModel.calculateSalary()
                                    }
                            }
                            .padding()
                            .background(Color(UIColor { $0.userInterfaceStyle == .dark ? UIColor(white: 0.15, alpha: 1) : UIColor(white: 0.95, alpha: 1) }))
                            .cornerRadius(8)
                        }
                        .padding()
                        .background(Color(UIColor { $0.userInterfaceStyle == .dark ? UIColor(white: 0.1, alpha: 1) : .white }))
                        .cornerRadius(12)

                        // Results
                        if let breakdown = viewModel.salaryBreakdown {
                            VStack(spacing: 16) {
                                // Net Salary Summary
                                VStack(spacing: 12) {
                                    Text("NET TAKE-HOME")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)

                                    VStack(alignment: .leading, spacing: 8) {
                                        HStack {
                                            Text("Monthly:")
                                            Spacer()
                                            Text(formatCurrency(breakdown.netMonthlySalary))
                                                .font(.system(size: 18, weight: .semibold))
                                        }
                                        Divider()
                                        HStack {
                                            Text("Annual:")
                                            Spacer()
                                            Text(formatCurrency(breakdown.netAnnualSalary))
                                                .font(.system(size: 18, weight: .semibold))
                                        }
                                    }
                                }
                                .padding()
                                .background(Color.green.opacity(0.1))
                                .cornerRadius(8)

                                // Tax Breakdown
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("Tax Breakdown")
                                        .font(.headline)

                                    VStack(spacing: 8) {
                                        ForEach(viewModel.taxBreakdownItems) { item in
                                            HStack {
                                                Text(item.label)
                                                    .font(.subheadline)
                                                Spacer()
                                                VStack(alignment: .trailing, spacing: 2) {
                                                    Text(formatCurrency(item.amount))
                                                        .font(.subheadline)
                                                    Text(String(format: "%.1f%%", NSDecimalNumber(decimal: item.percentage).doubleValue))
                                                        .font(.caption)
                                                        .foregroundColor(.gray)
                                                }
                                            }
                                            .padding(.vertical, 4)
                                        }
                                    }
                                }
                                .padding()
                                .background(Color(UIColor { $0.userInterfaceStyle == .dark ? UIColor(white: 0.1, alpha: 1) : UIColor(white: 0.95, alpha: 1) }))
                                .cornerRadius(8)

                                // Effective Tax Rate
                                VStack {
                                    HStack {
                                        Text("Effective Tax Rate:")
                                        Spacer()
                                        Text(String(format: "%.1f%%", NSDecimalNumber(decimal: breakdown.effectiveTaxRate).doubleValue))
                                            .font(.system(size: 16, weight: .semibold))
                                    }
                                }
                                .padding()
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(8)

                                // Action Buttons
                                HStack(spacing: 12) {
                                    Button(action: { viewModel.saveCurrentCalculation() }) {
                                        Label("Save", systemImage: "bookmark")
                                            .frame(maxWidth: .infinity)
                                            .padding()
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                            .cornerRadius(8)
                                    }

                                    Button(action: { copyToClipboard(breakdown) }) {
                                        Label("Copy", systemImage: "doc.on.doc")
                                            .frame(maxWidth: .infinity)
                                            .padding()
                                            .background(Color.gray.opacity(0.3))
                                            .foregroundColor(.primary)
                                            .cornerRadius(8)
                                    }
                                }
                            }
                            .padding()
                            .background(Color(UIColor { $0.userInterfaceStyle == .dark ? UIColor(white: 0.1, alpha: 1) : .white }))
                            .cornerRadius(12)
                        }

                        Spacer(minLength: 20)
                    }
                    .padding()
                }

                // History Sidebar
                if showHistory {
                    HistoryView(viewModel: viewModel, isPresented: $showHistory)
                        .transition(.move(edge: .leading))
                }
            }
        }
        .sheet(isPresented: $showSettings) {
            SettingsView(viewModel: viewModel)
        }
    }

    private func formatCurrency(_ amount: Decimal) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = viewModel.getCountryCurrencySymbol()
        formatter.maximumFractionDigits = 0

        return formatter.string(from: NSDecimalNumber(decimal: amount)) ?? "N/A"
    }

    private func copyToClipboard(_ breakdown: SalaryCalculationEngine.SalaryBreakdown) {
        let text = """
        SalaryCalc Result
        Country: \(viewModel.selectedCountry)
        Gross Annual: \(formatCurrency(breakdown.grossSalary))
        Net Annual: \(formatCurrency(breakdown.netAnnualSalary))
        Net Monthly: \(formatCurrency(breakdown.netMonthlySalary))
        Tax Rate: \(String(format: "%.1f%%", NSDecimalNumber(decimal: breakdown.effectiveTaxRate).doubleValue))
        """

        UIPasteboard.general.string = text
    }
}

// MARK: - History View

struct HistoryView: View {
    @ObservedObject var viewModel: SalaryCalculatorViewModel
    @Binding var isPresented: Bool

    var body: some View {
        VStack {
            HStack {
                Text("Calculation History")
                    .font(.headline)
                Spacer()
                Button(action: { isPresented = false }) {
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
    }
}

// MARK: - Settings View

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: SalaryCalculatorViewModel

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Default Settings")) {
                    Picker("Country", selection: $viewModel.userPreferences.defaultCountry) {
                        ForEach(CountryConfig.allCountries, id: \.id) { country in
                            Text(country.name).tag(country.name)
                        }
                    }

                    Picker("Employment Type", selection: $viewModel.userPreferences.defaultEmploymentType) {
                        Text("Full-time Employee").tag("Full-time Employee")
                        Text("Part-time Employee").tag("Part-time Employee")
                        Text("Freelancer/Self-Employed").tag("Freelancer/Self-Employed")
                    }
                }

                Section(header: Text("Display")) {
                    Stepper("Decimal Places: \(viewModel.userPreferences.decimalPlaces)",
                            value: $viewModel.userPreferences.decimalPlaces, in: 0...4)
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
    SalaryCalculatorView()
}
