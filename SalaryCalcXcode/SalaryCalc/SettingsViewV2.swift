import SwiftUI

struct SettingsViewV2: View {
    @StateObject private var localization = Localization.shared
    @State private var showAbout = false

    var body: some View {
        NavigationStack {
            Form {
                // MARK: - Language Settings
                Section(header: Text("Language")) {
                    Picker(
                        "setting.language".localized(),
                        selection: $localization.currentLanguage
                    ) {
                        ForEach(Localization.Language.allCases, id: \.self) { language in
                            Text(language.displayName).tag(language)
                        }
                    }
                    .pickerStyle(.menu)
                }

                // MARK: - App Information
                Section(header: Text("About")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.gray)
                    }

                    HStack {
                        Text("Build")
                        Spacer()
                        Text("1")
                            .foregroundColor(.gray)
                    }

                    HStack {
                        Text("Countries Supported")
                        Spacer()
                        Text("35+")
                            .fontWeight(.semibold)
                            .foregroundColor(.green)
                    }

                    HStack {
                        Text("Languages")
                        Spacer()
                        Text("8")
                            .fontWeight(.semibold)
                            .foregroundColor(.green)
                    }
                }

                // MARK: - Data Information
                Section(header: Text("Tax Data")) {
                    HStack {
                        Text("Last Updated")
                        Spacer()
                        Text("June 2025")
                            .foregroundColor(.gray)
                    }

                    HStack {
                        Text("Tax Year")
                        Spacer()
                        Text("2024-2025")
                            .foregroundColor(.gray)
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Data includes:")
                            .fontWeight(.semibold)
                        VStack(alignment: .leading, spacing: 4) {
                            Label("USA - All 50 States", systemImage: "checkmark.circle.fill")
                                .font(.caption)
                            Label("Canada - All 10 Provinces", systemImage: "checkmark.circle.fill")
                                .font(.caption)
                            Label("Europe - 15+ Countries", systemImage: "checkmark.circle.fill")
                                .font(.caption)
                            Label("Asia-Pacific - 8+ Regions", systemImage: "checkmark.circle.fill")
                                .font(.caption)
                        }
                        .foregroundColor(.green)
                    }
                }

                // MARK: - Legal & Privacy
                Section(header: Text("Legal")) {
                    NavigationLink(destination: DisclaimerView()) {
                        Text("Tax Disclaimer")
                    }

                    NavigationLink(destination: PrivacyView()) {
                        Text("Privacy Policy")
                    }

                    NavigationLink(destination: TermsView()) {
                        Text("Terms of Service")
                    }
                }

                // MARK: - Support
                Section(header: Text("Support")) {
                    Link("Visit Our Website", destination: URL(string: "https://github.com/BrewerAsia/salarycalc")!)

                    Link("Report an Issue", destination: URL(string: "https://github.com/BrewerAsia/salarycalc/issues")!)

                    Link("Email Support", destination: URL(string: "mailto:support@brewersasia.com")!)
                }
            }
            .navigationTitle("setting.about".localized())
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Disclaimer View
struct DisclaimerView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text("Tax Disclaimer")
                    .font(.headline)

                Text("""
                ⚠️ Important Legal Notice

                This calculator provides estimates based on 2024-2025 tax data. Tax laws change frequently and vary significantly by individual circumstances.

                **This is NOT professional tax advice.**

                You should:
                • Consult with qualified tax professionals
                • Verify with local tax authorities
                • Check official government websites
                • Consider your specific situation

                We make no guarantees about accuracy for your personal situation. Use at your own discretion.

                For accurate calculations, always consult with:
                • Certified Public Accountants (CPAs)
                • Enrolled Agents (EAs)
                • Tax attorneys
                • Official government tax agencies
                """)
                .font(.body)
                .lineSpacing(6)

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Tax Disclaimer")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Privacy View
struct PrivacyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text("Privacy Policy")
                    .font(.headline)

                Text("""
                Privacy Policy

                **Data Collection**
                • We do NOT collect personal salary information
                • We do NOT send calculations to any servers
                • All calculations happen locally on your device
                • No data is stored or transmitted

                **Usage Data**
                • App usage may be collected by Apple
                • This is governed by Apple's privacy policy
                • No salary or financial data is included

                **Third-party Services**
                • This app does not use third-party analytics
                • No tracking or profiling occurs
                • Your privacy is our priority

                **Your Rights**
                • You control all data on your device
                • You can delete the app to clear all data
                • No personal data is retained on our servers
                """)
                .font(.body)
                .lineSpacing(6)

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Privacy Policy")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Terms View
struct TermsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text("Terms of Service")
                    .font(.headline)

                Text("""
                Terms of Service

                **License**
                SalaryCalc is provided "as-is" for personal, non-commercial use.

                **Disclaimer**
                This app is not intended as professional tax advice. Users are responsible for verifying calculations with qualified professionals.

                **Accuracy**
                While we strive for accuracy, tax laws change frequently. We cannot guarantee accuracy for all situations.

                **Limitation of Liability**
                In no event shall BrewerAsia be liable for any indirect, incidental, special, or consequential damages.

                **User Responsibilities**
                • Verify all calculations independently
                • Consult with tax professionals
                • Keep records for verification
                • Comply with local tax laws

                **Changes**
                We reserve the right to modify this app and terms at any time.

                **Governing Law**
                These terms are governed by applicable laws.
                """)
                .font(.body)
                .lineSpacing(6)

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Terms of Service")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SettingsViewV2()
}
