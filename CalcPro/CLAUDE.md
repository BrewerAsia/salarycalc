# CalcPro - Project Context & Guidelines

## Project Overview

**CalcPro** is a professional iOS calculator app for business professionals. It launches with core calculator features and expands to specialized business calculators in later phases.

**Target Users:** Small business owners, accountants, contractors, retailers, anyone needing reliable offline calculations

**Platforms:** iOS 15.0+, iPad optimized
**Architecture:** MVVM with Clean Architecture
**Tech Stack:** SwiftUI, Swift 5.9+, UserDefaults persistence

## Phase Breakdown

### Phase 1 (Week 10) - Launch MVP
- Basic calculator with arithmetic operations
- Tax, Markup, Tip, Invoice calculators (UI only)
- Calculation history
- Settings (decimal places, currency symbol)
- Dark/light mode
- iPad support
- Accessibility (VoiceOver, WCAG AA)
- **Target Markets:** 5 (US, UK, Canada, Australia, Ireland)
- **Languages:** English only

### Phase 2 (Weeks 11-16) - Enhanced Features
- Localization (8 languages: German, French, Spanish, Italian, Dutch, Portuguese, Japanese, Simplified Chinese)
- Implement business calculators fully (tax with regional rates, markup/discount, tip with customization, invoice)
- Export to CSV/PDF
- Currency converter (with offline rates)
- Loan/mortgage calculator
- **Target Markets:** 25+ (EU + Asia entry)

### Phase 3+ (Weeks 18-24) - Advanced Features
- Additional languages
- Scientific calculator
- Cloud sync (optional, optional premium tier
- More markets

## Code Standards & Patterns

### Architecture Decisions
- **MVVM Pattern:** Views → ViewModels → Models
- **Clean Architecture:** Separation of concerns (Presentation, Domain, Data, Utilities)
- **Decimal Arithmetic:** Use `Decimal` not `Double` for calculator (precision critical)
- **No External Dependencies (Phase 1):** Keep dependencies minimal for reliability

### Swift Standards
- Swift 5.9+ syntax only
- Use @Published for observable properties
- Use @StateObject for lifecycle management
- Prefer composition over inheritance
- Use Result<T, Error> for error handling
- Add accessibility labels to all interactive elements

### Naming Conventions
- **Views:** Suffix with `View` (CalculatorView, SettingsView)
- **ViewModels:** Suffix with `ViewModel` (CalculatorViewModel)
- **Buttons:** Suffix with `Button` (CalculatorButton)
- **Models:** Use clear business names (Calculation, UserPreferences)

### Accessibility Requirements
- VoiceOver: All UI elements must have accessibilityLabel
- Text Scaling: Support dynamic type (min 100%, max 200%)
- Color Contrast: 4.5:1 for text, 3:1 for graphics
- Touch Targets: Minimum 44x44 points
- Dark Mode: Full support required

### Testing Requirements
- Unit test CalculatorEngine thoroughly (target: 100% coverage)
- Test all edge cases: division by zero, negative numbers, decimals, large numbers
- Test view model state transitions
- Test data persistence (save/load)

## File Organization Rules

```
Sources/
├── App/
│   └── CalcProApp.swift          # Entry point only, minimal logic
├── Presentation/
│   ├── Views/
│   │   ├── CalculatorView.swift  # Main UI, tab-based calculator selection
│   │   ├── SettingsView.swift    # User preferences
│   │   └── [Business*View.swift]
│   ├── ViewModels/
│   │   └── CalculatorViewModel.swift  # Single source of truth for state
│   └── Components/
│       ├── CalculatorButton.swift
│       ├── CalculatorDisplay.swift
│       └── [Reusable components]
├── Domain/
│   ├── Models/
│   │   └── Calculation.swift     # Data models, NO logic
│   └── UseCases/                 # Future: business logic
├── Data/
│   ├── Repositories/
│   │   └── CalculationRepository.swift  # Persistence abstraction
│   └── Persistence/              # Implementation details
└── Utilities/
    ├── CalculatorEngine.swift    # Pure calculation logic
    ├── Extensions.swift          # String, Decimal, Color, etc.
    └── Constants.swift           # App constants
```

**Rule:** If adding a new file, put it in the appropriate folder. Don't create files outside this structure.

## Important Implementation Notes

### CalculatorEngine
- Pure Swift, no UIKit/SwiftUI imports
- Uses `Decimal` for precision (not `Double`)
- Input-based (addDigit, addDecimal, performOperation)
- Stateful (maintains accumulator, operation, currentInput)
- Result-based error handling
- **CRITICAL:** Every calculation change requires unit tests

### CalculatorViewModel
- Single source of truth for calculator state
- Publishes updates via @Published
- Delegates calculation to engine
- Manages history via repository
- Handles error presentation to UI
- **CRITICAL:** Mock this for UI testing (Phase 2)

### Data Persistence
- Phase 1: UserDefaults only (no Core Data)
- Phase 2: Maintain UserDefaults, add optional iCloud sync
- Never use sync across threads without coordination
- Calculation history limit: 1000 items max

### Business Calculators
- Tab-based selection in main view
- Each calculator is a separate View
- Share common components (input fields, display)
- Phase 2: Implement logic, Phase 1: UI only

## Localization Strategy

**Phase 1:** English only (no localization setup required)

**Phase 2:** Prepare for localization:
- Use Localizable.strings files
- Don't hardcode strings (make them NSLocalizedString)
- Support regional number formats (Locale.current)
- Currency symbols based on locale
- Tax rates by country

**Key Localization Files:**
- `Localizable.strings` (English)
- `Localizable.strings (de)` (German)
- `Localizable.strings (fr)` (French)
- etc.

## App Store Submission Checklist

**Before submission:**
- ☐ All tests pass (Cmd + U)
- ☐ Build succeeds on real device
- ☐ VoiceOver tested and works
- ☐ Dark/light modes tested
- ☐ iPad landscape tested
- ☐ Privacy policy completed
- ☐ Screenshots (2 sets: iPhone + iPad)
- ☐ Bundle identifier matches Apple account
- ☐ Code signing configured
- ☐ Build version incremented (1.0.0 for launch)

## Performance Requirements

- **App launch:** < 2 seconds
- **Calculation response:** < 100ms
- **Screen transitions:** < 300ms
- **Memory usage:** < 100MB average
- **Scrolling:** 60fps minimum (120fps on ProMotion)

## Security Considerations

- **No network requests (Phase 1):** Works offline entirely
- **No analytics:** Don't add any tracking
- **No ads:** App stays clean and professional
- **Crypto not needed (Phase 1):** Local UserDefaults is sufficient
- **Data encryption:** iOS handles automatically

**CRITICAL:** Any changes to privacy/data collection must be approved before implementation.

## Git Workflow

### Commit Strategy
- Commit frequently (per feature/fix, not per file)
- Use clear commit messages: "Add tax calculator UI" not "update files"
- Reference issue numbers if applicable
- Include Co-Authored-By for pair programming

### Branch Strategy
- `main`: Always release-ready
- `phase-2/*`: Feature branches for Phase 2
- `bugfix/*`: Bug fixes
- Tag releases: `v1.0.0` for App Store releases

### Before Pushing
- Verify all tests pass
- Verify build succeeds
- Review code for accessibility compliance
- Ensure no hardcoded URLs or debug code

## Common Pitfalls to Avoid

1. **Arithmetic Errors:** Always use Decimal, not Double
2. **Missing Accessibility:** Every button needs a label
3. **Dark Mode Issues:** Test in both modes before commit
4. **Memory Leaks:** Avoid strong reference cycles in closures
5. **UI Blocking:** Long operations must use async/await or DispatchQueue
6. **Hardcoded Values:** Use Constants.swift for all magic numbers
7. **Test Coverage:** New calculation logic needs unit tests
8. **Localization:** Don't hardcode strings ("Tax" → NSLocalizedString("tax.label"))

## Tools & Commands

```bash
# Build
xcodebuild -scheme CalcPro -configuration Debug

# Test
xcodebuild test -scheme CalcPro

# Clean
xcodebuild clean

# Archive for App Store
xcodebuild -scheme CalcPro archive
```

## When in Doubt

1. **Check CalculatorEngineTests.swift** for calculation examples
2. **Review PRIVACY_POLICY.md** before handling any data
3. **Follow WCAG 2.1 Level AA** for accessibility
4. **Use MVVM pattern** for state management
5. **Test on real device** before declaring done

## Contact & Escalation

For questions about:
- **Architecture:** Review Domain/Data/Presentation layer patterns
- **Accessibility:** Check WCAG 2.1 requirements
- **Localization:** See Phase 2 in planning docs
- **App Store:** Review CALCPRO_MULTI_COUNTRY_STRATEGY.md
- **Business Logic:** Reference CalculatorEngine tests

---

**Last Updated:** 2026-06-14
**Version:** Phase 1 Foundation
**Maintained By:** CalcPro Development Team
