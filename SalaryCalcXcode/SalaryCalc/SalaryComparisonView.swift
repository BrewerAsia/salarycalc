import SwiftUI

// MARK: - Salary Comparison View
struct SalaryComparisonView: View {
    @State private var selectedCountries: Set<String> = []
    @State private var salaryAmount: String = ""
    @State private var comparisons: [ComparisonResult] = []
    @State private var showResults = false

    let engine = SalaryCalculationEngineV2.shared
    let localization = Localization.shared

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Title
                VStack(alignment: .center, spacing: 8) {
                    Text(localization.translate("comparison.title"))
                        .font(.title2)
                        .fontWeight(.bold)
                }
                .padding()

                // Salary Input
                VStack(alignment: .leading, spacing: 8) {
                    Text(localization.translate("field.salary"))
                        .fontWeight(.semibold)

                    HStack {
                        Text("$")
                            .foregroundColor(.gray)
                        TextField(
                            localization.translate("field.salary"),
                            text: $salaryAmount
                        )
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.roundedBorder)
                    }
                }
                .padding()

                // Country Selection
                VStack(alignment: .leading, spacing: 12) {
                    Text(localization.translate("comparison.selectCountries"))
                        .fontWeight(.semibold)

                    ScrollView {
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(getTopCountries(), id: \.code) { country in
                                HStack {
                                    Image(systemName: selectedCountries.contains(country.code) ? "checkmark.square.fill" : "square")
                                        .foregroundColor(selectedCountries.contains(country.code) ? .blue : .gray)
                                        .onTapGesture {
                                            if selectedCountries.contains(country.code) {
                                                selectedCountries.remove(country.code)
                                            } else {
                                                selectedCountries.insert(country.code)
                                            }
                                        }

                                    Text(country.name)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text(country.currencySymbol)
                                        .foregroundColor(.gray)
                                        .font(.caption)
                                }
                                .padding(12)
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                            }
                        }
                        .padding()
                    }
                    .frame(maxHeight: 300)
                }
                .padding()

                // Compare Button
                Button(action: performComparison) {
                    HStack {
                        Image(systemName: "chart.bar.xaxis")
                        Text(localization.translate("action.compare"))
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding()
                .disabled(selectedCountries.isEmpty || salaryAmount.isEmpty)

                Spacer()
            }
            .navigationTitle(localization.translate("app.title"))
        }
        .sheet(isPresented: $showResults) {
            ComparisonResultsView(results: comparisons, salaryAmount: salaryAmount)
        }
    }

    private func getTopCountries() -> [CountryTaxInfo] {
        let provider = TaxDataProvider()
        let topCountries = [
            "usa", "uk", "canada", "australia", "germany",
            "france", "spain", "netherlands", "japan", "singapore",
            "india", "uae", "brazil", "mexico", "switzerland"
        ]
        return topCountries.compactMap { provider.getCountry(code: $0) }
    }

    private func performComparison() {
        guard let salary = Decimal(string: salaryAmount) else { return }

        comparisons = selectedCountries.compactMap { countryCode in
            let breakdown = engine.calculateSalary(
                grossAnnual: salary,
                countryCode: countryCode
            )

            return ComparisonResult(
                country: countryCode,
                countryName: engine.taxDataProvider.getCountry(code: countryCode)?.name ?? countryCode,
                grossSalary: breakdown.grossAnnualSalary,
                netSalary: breakdown.netAnnualSalary,
                taxRate: breakdown.effectiveTaxRate,
                currency: breakdown.currency
            )
        }
        .sorted { $0.netSalary > $1.netSalary }

        showResults = true
    }
}

// MARK: - Comparison Results View
struct ComparisonResultsView: View {
    let results: [ComparisonResult]
    let salaryAmount: String
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack {
                // Summary
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Gross Salary:")
                            .fontWeight(.semibold)
                        Spacer()
                        Text("$\(salaryAmount)")
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    }

                    Divider()

                    Text("Results Ranked by Net Salary")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding()

                // Results List
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(results, id: \.country) { result in
                            ComparisonRowView(result: result)
                        }
                    }
                    .padding()
                }

                Spacer()

                // Close Button
                Button(action: { dismiss() }) {
                    Text("Close")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("Comparison Results")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Comparison Row
struct ComparisonRowView: View {
    let result: ComparisonResult

    var savingsVsLowest: Decimal = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(result.countryName)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(result.currency)
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Net Annual")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("\(result.currency)\(formatCurrency(result.netSalary))")
                        .fontWeight(.semibold)
                        .foregroundColor(.green)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text("Tax Rate")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("\(String(format: "%.1f", result.taxRate))%")
                        .fontWeight(.semibold)
                        .foregroundColor(.red)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text("Monthly")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("\(result.currency)\(formatCurrency(result.netSalary / 12))")
                        .fontWeight(.semibold)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }

    private func formatCurrency(_ amount: Decimal) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSDecimalNumber(decimal: amount)) ?? "0"
    }
}

// MARK: - Models
struct ComparisonResult {
    let country: String
    let countryName: String
    let grossSalary: Decimal
    let netSalary: Decimal
    let taxRate: Decimal
    let currency: String
}

#Preview {
    SalaryComparisonView()
}
