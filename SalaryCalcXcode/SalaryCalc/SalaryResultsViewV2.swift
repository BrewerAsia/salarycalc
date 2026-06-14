import SwiftUI

struct SalaryResultsViewV2: View {
    let breakdown: EnhancedSalaryBreakdown?
    @Environment(\.dismiss) var dismiss
    @State private var copiedToClipboard = false

    var body: some View {
        NavigationStack {
            if let breakdown = breakdown {
                ScrollView {
                    VStack(spacing: 16) {
                        // MARK: - Summary Card
                        VStack(spacing: 12) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("result.grossSalary".localized())
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Text("\(breakdown.currency)\(formatCurrency(breakdown.grossAnnualSalary))")
                                        .font(.headline)
                                }
                                Spacer()
                                VStack(alignment: .trailing, spacing: 4) {
                                    Text("result.effectiveTaxRate".localized())
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Text("\(String(format: "%.1f", breakdown.effectiveTaxRate))%")
                                        .font(.headline)
                                        .foregroundColor(.red)
                                }
                            }

                            Divider()

                            VStack(alignment: .leading, spacing: 8) {
                                Text("result.netAnnual".localized())
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text("\(breakdown.currency)\(formatCurrency(breakdown.netAnnualSalary))")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(.green)
                            }

                            HStack(spacing: 16) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("result.netMonthly".localized())
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Text("\(breakdown.currency)\(formatCurrency(breakdown.netAnnualSalary / 12))")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                }

                                Spacer()

                                VStack(alignment: .trailing, spacing: 4) {
                                    Text("result.netWeekly".localized())
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Text("\(breakdown.currency)\(formatCurrency(breakdown.netAnnualSalary / 52))")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                }
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)

                        // MARK: - Tax Breakdown
                        VStack(alignment: .leading, spacing: 12) {
                            Text("result.taxBreakdown".localized())
                                .font(.headline)
                                .padding(.horizontal)

                            VStack(spacing: 8) {
                                ForEach(breakdown.taxBreakdown, id: \.name) { component in
                                    TaxComponentRow(component: component, currency: breakdown.currency)
                                }
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        }

                        // MARK: - Copy Button
                        Button(action: copyToClipboard) {
                            HStack {
                                Image(systemName: copiedToClipboard ? "checkmark.circle.fill" : "doc.on.doc")
                                Text(copiedToClipboard ? "Copied!" : "action.copy".localized())
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        .padding()
                    }
                    .padding()
                }
                .navigationTitle("result.grossSalary".localized())
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") { dismiss() }
                    }
                }
            } else {
                Text("message.noData".localized())
            }
        }
    }

    private func formatCurrency(_ amount: Decimal) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSDecimalNumber(decimal: amount)) ?? "0"
    }

    private func copyToClipboard() {
        guard let breakdown = breakdown else { return }

        let text = """
        \(breakdown.country) - Salary Breakdown
        Gross Annual: \(breakdown.currency)\(formatCurrency(breakdown.grossAnnualSalary))
        Net Annual: \(breakdown.currency)\(formatCurrency(breakdown.netAnnualSalary))
        Net Monthly: \(breakdown.currency)\(formatCurrency(breakdown.netAnnualSalary / 12))
        Effective Tax Rate: \(String(format: "%.1f", breakdown.effectiveTaxRate))%
        """

        UIPasteboard.general.string = text
        copiedToClipboard = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            copiedToClipboard = false
        }
    }
}

// MARK: - Tax Component Row
struct TaxComponentRow: View {
    let component: TaxComponent
    let currency: String

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(component.name)
                    .fontWeight(.semibold)
                Text("\(String(format: "%.1f", component.rate))%")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text("\(currency)\(formatCurrency(component.amount))")
                .fontWeight(.semibold)
        }
        .padding(12)
        .background(Color(.white))
        .cornerRadius(8)
    }

    private func formatCurrency(_ amount: Decimal) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSDecimalNumber(decimal: amount)) ?? "0"
    }
}

#Preview {
    SalaryResultsViewV2(
        breakdown: EnhancedSalaryBreakdown(
            grossAnnualSalary: 100000,
            netAnnualSalary: 75000,
            netMonthlySalary: 6250,
            netWeeklySalary: 1442,
            country: "usa",
            subdivision: "california",
            taxBreakdown: [
                TaxComponent(name: "Federal Tax", amount: 12000, rate: 12),
                TaxComponent(name: "Social Security", amount: 6200, rate: 6.2),
                TaxComponent(name: "Medicare", amount: 1450, rate: 1.45),
                TaxComponent(name: "State Tax", amount: 5350, rate: 5.35)
            ],
            effectiveTaxRate: 25,
            currency: "$"
        )
    )
}
