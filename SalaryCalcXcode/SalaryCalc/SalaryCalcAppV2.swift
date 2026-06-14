import SwiftUI

@main
struct SalaryCalcAppV2: App {
    var body: some Scene {
        WindowGroup {
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

                // MARK: - Settings Tab
                SettingsViewV2()
                    .tabItem {
                        Label(
                            "setting.about".localized(),
                            systemImage: "gear"
                        )
                    }
            }
            .preferredColorScheme(nil) // Respect system dark mode
        }
    }
}
