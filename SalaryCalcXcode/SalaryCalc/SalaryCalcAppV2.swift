import SwiftUI

@main
struct SalaryCalcAppV2: App {
    @StateObject private var subscriptionManager = SubscriptionManager.shared
    @State private var showPremiumPaywall = false

    var body: some Scene {
        WindowGroup {
            ZStack {
                TabView {
                    // MARK: - Calculator Tab
                    SalaryCalculatorViewV2()
                        .tabItem {
                            Label(
                                "field.salary".localized(),
                                systemImage: "calculator.fill"
                            )
                        }

                    // MARK: - Comparison Tab
                    SalaryComparisonView()
                        .tabItem {
                            Label(
                                "action.compare".localized(),
                                systemImage: "chart.bar.xaxis"
                            )
                        }

                    // MARK: - Cost of Living Tab
                    CostOfLivingConverterView()
                        .tabItem {
                            Label(
                                "Cost of Living",
                                systemImage: "globe"
                            )
                        }

                    // MARK: - Premium Features Tab
                    PremiumFeaturesView()
                        .tabItem {
                            Label(
                                "Premium",
                                systemImage: "star.fill"
                            )
                        }

                    // MARK: - Settings Tab
                    SettingsViewV2()
                        .tabItem {
                            Label(
                                "setting.about".localized(),
                                systemImage: "gear"
                            )
                        }
                }
                .accentColor(AppTheme.primaryBlue)
                .preferredColorScheme(nil) // Respect system dark mode
                .environmentObject(subscriptionManager)

                // Premium Paywall Sheet
                if showPremiumPaywall {
                    PremiumPaywallView()
                }
            }
            .onAppear {
                // Check if user has premium access
                _ = subscriptionManager.canAccessPremiumFeatures
            }
        }
    }
}
