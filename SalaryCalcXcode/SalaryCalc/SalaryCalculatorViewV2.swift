import SwiftUI

struct SalaryCalculatorViewV2: View {
    @StateObject private var viewModel = SalaryCalculatorViewModelV2()
    @State private var showResults = false

    var body: some View {
        NavigationStack {
            Form {
                // MARK: - Country Selection
                Section(header: Text("field.country".localized())) {
                    Picker("field.country".localized(), selection: $viewModel.selectedCountry) {
                        Text("Select Country").tag("")
                        ForEach(viewModel.availableCountries, id: \.code) { country in
                            Text(country.name).tag(country.code)
                        }
                    }
                    .pickerStyle(.navigationLink)
                    .onChange(of: viewModel.selectedCountry) { oldValue, newValue in
                        viewModel.updateSubdivisions()
                    }
                }

                // MARK: - State/Province Selection
                if !viewModel.availableSubdivisions.isEmpty {
                    Section(header: Text("field.state".localized())) {
                        Picker("field.state".localized(), selection: $viewModel.selectedSubdivision) {
                            Text("Select \(viewModel.subdivisionType)").tag("")
                            ForEach(viewModel.availableSubdivisions, id: \.code) { subdivision in
                                Text(subdivision.name).tag(subdivision.code)
                            }
                        }
                        .pickerStyle(.navigationLink)
                    }
                }

                // MARK: - Employment Type
                Section(header: Text("field.employment".localized())) {
                    Picker("field.employment".localized(), selection: $viewModel.selectedEmploymentType) {
                        ForEach(EmploymentType.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                // MARK: - Salary Input
                Section(header: Text("field.salary".localized())) {
                    HStack {
                        Text(viewModel.currencySymbol)
                            .foregroundColor(.gray)
                        TextField(
                            "field.salary".localized(),
                            text: $viewModel.salaryInput
                        )
                        .keyboardType(.decimalPad)
                    }
                }

                // MARK: - Calculate Button
                Section {
                    Button(action: calculateSalary) {
                        HStack {
                            Image(systemName: "calculator.fill")
                            Text("action.calculate".localized())
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(.white)
                    }
                    .listRowBackground(Color.blue)
                }
            }
            .navigationTitle("app.title".localized())
            .navigationBarTitleDisplayMode(.inline)
        }
        .sheet(isPresented: $showResults) {
            SalaryResultsViewV2(breakdown: viewModel.currentBreakdown)
        }
    }

    private func calculateSalary() {
        guard viewModel.validateInput() else {
            viewModel.showError = true
            return
        }
        viewModel.calculate()
        showResults = true
    }
}

// MARK: - View Model
@MainActor
class SalaryCalculatorViewModelV2: ObservableObject {
    @Published var selectedCountry = ""
    @Published var selectedSubdivision = ""
    @Published var selectedEmploymentType = EmploymentType.fullTime
    @Published var salaryInput = ""
    @Published var availableCountries: [CountryTaxInfo] = []
    @Published var availableSubdivisions: [SubdivisionInfo] = []
    @Published var currentBreakdown: EnhancedSalaryBreakdown?
    @Published var showError = false
    @Published var subdivisionType = "State"
    @Published var currencySymbol = "$"

    private let engine = SalaryCalculationEngineV2.shared
    private let taxDataProvider = TaxDataProvider()

    init() {
        loadCountries()
    }

    func loadCountries() {
        availableCountries = taxDataProvider.getCountries()
    }

    func updateSubdivisions() {
        availableSubdivisions = taxDataProvider.getSubdivisions(for: selectedCountry)
        subdivisionType = taxDataProvider.getCountry(code: selectedCountry)?.subdivisionType ?? "State"
        currencySymbol = taxDataProvider.getCountry(code: selectedCountry)?.currencySymbol ?? "$"
        selectedSubdivision = ""
    }

    func validateInput() -> Bool {
        guard !selectedCountry.isEmpty else { return false }
        guard !salaryInput.isEmpty else { return false }
        guard Decimal(string: salaryInput) != nil else { return false }
        return true
    }

    func calculate() {
        guard let salary = Decimal(string: salaryInput) else { return }

        currentBreakdown = engine.calculateSalary(
            grossAnnual: salary,
            countryCode: selectedCountry,
            subdivisionCode: selectedSubdivision.isEmpty ? nil : selectedSubdivision,
            employmentType: selectedEmploymentType
        )
    }
}

#Preview {
    SalaryCalculatorViewV2()
}
