import Foundation

// MARK: - Multi-Language Support
class Localization {
    static let shared = Localization()

    enum Language: String, CaseIterable {
        case english = "en"
        case spanish = "es"
        case french = "fr"
        case german = "de"
        case chinese = "zh"
        case japanese = "ja"
        case arabic = "ar"
        case portuguese = "pt"

        var displayName: String {
            switch self {
            case .english: return "English"
            case .spanish: return "Español"
            case .french: return "Français"
            case .german: return "Deutsch"
            case .chinese: return "中文"
            case .japanese: return "日本語"
            case .arabic: return "العربية"
            case .portuguese: return "Português"
            }
        }
    }

    @Published var currentLanguage: Language = .english

    private var translations: [String: [String: String]] = [:]

    init() {
        loadTranslations()
    }

    private func loadTranslations() {
        // English
        translations["en"] = [
            "app.title": "SalaryCalc",
            "app.subtitle": "Global Salary Calculator",

            // Main Fields
            "field.country": "Country",
            "field.state": "State/Province",
            "field.employment": "Employment Type",
            "field.salary": "Gross Annual Salary",
            "field.currency": "Currency",

            // Employment Types
            "employment.fullTime": "Full-time Employee",
            "employment.partTime": "Part-time Employee",
            "employment.freelance": "Freelancer",
            "employment.contractor": "Contractor",

            // Results
            "result.grossSalary": "Gross Annual Salary",
            "result.netAnnual": "Net Annual Salary",
            "result.netMonthly": "Net Monthly Salary",
            "result.netWeekly": "Net Weekly Salary",
            "result.taxBreakdown": "Tax Breakdown",
            "result.effectiveTaxRate": "Effective Tax Rate",
            "result.totalDeductions": "Total Deductions",

            // Tax Components
            "tax.federalIncome": "Federal Income Tax",
            "tax.stateIncome": "State Income Tax",
            "tax.socialSecurity": "Social Security",
            "tax.medicare": "Medicare",
            "tax.healthInsurance": "Health Insurance",
            "tax.pension": "Pension Contribution",
            "tax.other": "Other Deductions",

            // Comparison
            "comparison.title": "Salary Comparison",
            "comparison.selectCountries": "Select Countries to Compare",
            "comparison.netSalary": "Net Salary",
            "comparison.taxRate": "Tax Rate",
            "comparison.takHome": "Take Home",
            "comparison.saveMore": "Save More",
            "comparison.payMore": "Pay More Taxes",

            // Actions
            "action.calculate": "Calculate",
            "action.compare": "Compare",
            "action.save": "Save",
            "action.copy": "Copy to Clipboard",
            "action.reset": "Reset",
            "action.settings": "Settings",
            "action.share": "Share",

            // Messages
            "message.success": "Calculation Complete",
            "message.error": "Error Calculating Salary",
            "message.noData": "No data available",
            "message.selectCountry": "Please select a country",
            "message.selectSalary": "Please enter a salary",

            // Settings
            "setting.language": "Language",
            "setting.currency": "Currency Display",
            "setting.theme": "Theme",
            "setting.about": "About",
            "setting.privacy": "Privacy Policy",
        ]

        // Spanish
        translations["es"] = [
            "app.title": "CalculadoraSalario",
            "app.subtitle": "Calculadora de Salario Global",

            "field.country": "País",
            "field.state": "Estado/Provincia",
            "field.employment": "Tipo de Empleo",
            "field.salary": "Salario Bruto Anual",

            "result.netAnnual": "Salario Neto Anual",
            "result.netMonthly": "Salario Neto Mensual",
            "result.effectiveTaxRate": "Tasa Impositiva Efectiva",

            "action.calculate": "Calcular",
            "action.compare": "Comparar",

            "comparison.title": "Comparación de Salarios",
        ]

        // French
        translations["fr"] = [
            "app.title": "CalculSalaire",
            "app.subtitle": "Calculatrice de Salaire Mondiale",

            "field.country": "Pays",
            "field.state": "État/Province",
            "field.employment": "Type d'emploi",
            "field.salary": "Salaire Brut Annuel",

            "result.netAnnual": "Salaire Net Annuel",
            "result.netMonthly": "Salaire Net Mensuel",
            "result.effectiveTaxRate": "Taux d'Imposition Effectif",

            "action.calculate": "Calculer",
            "action.compare": "Comparer",

            "comparison.title": "Comparaison des Salaires",
        ]

        // German
        translations["de"] = [
            "app.title": "GehaltsRechner",
            "app.subtitle": "Globaler Gehaltsrechner",

            "field.country": "Land",
            "field.state": "Staat/Provinz",
            "field.employment": "Beschäftigungstyp",
            "field.salary": "Bruttojahresgehalt",

            "result.netAnnual": "Nettojahresgehalt",
            "result.netMonthly": "Nettomonatsgehalt",
            "result.effectiveTaxRate": "Effektiver Steuersatz",

            "action.calculate": "Berechnen",
            "action.compare": "Vergleichen",

            "comparison.title": "Gehaltsvergleich",
        ]

        // Chinese
        translations["zh"] = [
            "app.title": "薪资计算器",
            "app.subtitle": "全球薪资计算器",

            "field.country": "国家",
            "field.state": "州/省",
            "field.employment": "就业类型",
            "field.salary": "年总薪资",

            "result.netAnnual": "年净薪资",
            "result.netMonthly": "月净薪资",
            "result.effectiveTaxRate": "有效税率",

            "action.calculate": "计算",
            "action.compare": "比较",

            "comparison.title": "薪资对比",
        ]

        // Japanese
        translations["ja"] = [
            "app.title": "給与計算機",
            "app.subtitle": "グローバル給与計算機",

            "field.country": "国",
            "field.state": "州/県",
            "field.employment": "雇用形態",
            "field.salary": "年間総給与",

            "result.netAnnual": "年間純給与",
            "result.netMonthly": "月間純給与",
            "result.effectiveTaxRate": "実効税率",

            "action.calculate": "計算",
            "action.compare": "比較",

            "comparison.title": "給与比較",
        ]

        // Arabic
        translations["ar"] = [
            "app.title": "حاسبة الراتب",
            "app.subtitle": "حاسبة الراتب العالمية",

            "field.country": "البلد",
            "field.state": "الولاية/المقاطعة",
            "field.employment": "نوع التوظيف",
            "field.salary": "الراتب الإجمالي السنوي",

            "result.netAnnual": "الراتب الصافي السنوي",
            "result.netMonthly": "الراتب الصافي الشهري",
            "result.effectiveTaxRate": "معدل الضريبة الفعلي",

            "action.calculate": "حساب",
            "action.compare": "مقارنة",

            "comparison.title": "مقارنة الرواتب",
        ]

        // Portuguese
        translations["pt"] = [
            "app.title": "CalculadoraSalário",
            "app.subtitle": "Calculadora de Salário Global",

            "field.country": "País",
            "field.state": "Estado/Província",
            "field.employment": "Tipo de Emprego",
            "field.salary": "Salário Bruto Anual",

            "result.netAnnual": "Salário Líquido Anual",
            "result.netMonthly": "Salário Líquido Mensal",
            "result.effectiveTaxRate": "Taxa de Imposto Efetiva",

            "action.calculate": "Calcular",
            "action.compare": "Comparar",

            "comparison.title": "Comparação de Salários",
        ]
    }

    func translate(_ key: String, language: Language? = nil) -> String {
        let lang = language ?? currentLanguage
        return translations[lang.rawValue]?[key] ?? translations["en"]?[key] ?? key
    }

    func translate(_ key: String) -> String {
        return translate(key, language: currentLanguage)
    }
}

// MARK: - Extension for easy string access
extension String {
    func localized(language: Localization.Language? = nil) -> String {
        return Localization.shared.translate(self, language: language)
    }
}
