# CalcPro - Professional Business Calculator

A modern iOS calculator app designed for business professionals. Fast, accurate, and privacy-first.

## Project Structure

```
CalcPro/
├── Sources/
│   ├── App/
│   │   └── CalcProApp.swift          # Main app entry point
│   ├── Presentation/
│   │   ├── Views/
│   │   │   ├── CalculatorView.swift  # Main calculator UI
│   │   │   └── SettingsView.swift    # User preferences
│   │   ├── ViewModels/
│   │   │   └── CalculatorViewModel.swift  # State management
│   │   └── Components/
│   │       ├── CalculatorButton.swift    # Reusable button
│   │       └── CalculatorDisplay.swift   # Display component
│   ├── Domain/
│   │   └── Models/
│   │       └── Calculation.swift     # Data models
│   ├── Data/
│   │   └── Repositories/
│   │       └── CalculationRepository.swift  # Persistence layer
│   └── Utilities/
│       └── CalculatorEngine.swift    # Core calculation logic
├── Tests/
│   └── CalculatorEngineTests.swift   # Unit tests
└── README.md
```

## Setup Instructions

### Prerequisites
- macOS 13.0 or later
- Xcode 15.0 or later
- iOS 15.0 or later target device/simulator

### Quick Start (Xcode)

1. **Open Xcode and create a new iOS App project:**
   - File > New > Project
   - Select "iOS" > "App"
   - Name: `CalcPro`
   - Organization: Your company
   - Bundle Identifier: `com.yourcompany.calcpro`
   - Interface: SwiftUI
   - Life Cycle: SwiftUI App

2. **Copy source files:**
   ```bash
   # From this repository's Sources directory, copy all files to your Xcode project:
   # CalcProApp.swift
   # Presentation/Views/*
   # Presentation/ViewModels/*
   # Presentation/Components/*
   # Domain/Models/*
   # Data/Repositories/*
   # Utilities/*
   ```

3. **Verify file organization in Xcode:**
   - In Xcode's project navigator, ensure files are organized by folders
   - Right-click > New Group to create folder references matching the structure

4. **Configure build settings:**
   - Select project in navigator
   - Select "CalcPro" target
   - Build Settings tab
   - Minimum Deployments: iOS 15.0
   - Supported Platforms: iOS, iPadOS

5. **Run the app:**
   - Select simulator or device
   - Cmd + R to build and run

## Features (Phase 1)

### Core Calculator
- ✅ Basic arithmetic (add, subtract, multiply, divide)
- ✅ Percentage calculations
- ✅ Square root and power functions
- ✅ Memory functions (M+, M-, MR, MC)
- ✅ Calculation history
- ✅ Large, accessible display

### Professional Design
- ✅ Light & Dark mode support
- ✅ iPad optimization
- ✅ Landscape & portrait modes
- ✅ VoiceOver accessibility support
- ✅ WCAG AA compliance

### Business Features (Phase 2)
- ⏳ Tax calculator
- ⏳ Markup/discount calculator
- ⏳ Tip calculator
- ⏳ Invoice calculator

## Architecture

### MVVM + Clean Architecture
- **Presentation Layer**: SwiftUI views and view models
- **Domain Layer**: Business logic and models
- **Data Layer**: Persistence using UserDefaults
- **Utilities**: Helper functions and extensions

### Key Classes

**CalculatorEngine**
- Pure Swift calculation logic
- Uses `Decimal` for precision
- No UIKit dependencies
- Fully testable

**CalculatorViewModel**
- State management with `@Published` properties
- Bridge between UI and engine
- History management
- Preferences handling

**CalculationRepository**
- Data persistence using UserDefaults
- Calculation history storage
- User preferences persistence

## Testing

Run tests:
```bash
Cmd + U in Xcode
```

Test coverage includes:
- ✅ Basic arithmetic operations
- ✅ Decimal precision
- ✅ Error handling (division by zero)
- ✅ Edge cases
- ✅ UI interactions

## Build & Run

### Development
```bash
# In Xcode
Cmd + R          # Run
Cmd + U          # Test
Cmd + B          # Build
```

### Release Build
- Select "Generic iOS Device" or target device
- Product > Archive
- Organizer > Distribute App

## App Store Submission

See `CALCPRO_MULTI_COUNTRY_STRATEGY.md` for full details.

### Checklist
- [ ] All tests passing (100% CalculatorEngine coverage)
- [ ] Accessibility audit passed (VoiceOver, text scaling)
- [ ] Privacy policy created
- [ ] Terms of service (if applicable)
- [ ] Screenshots created
- [ ] Metadata: app name, description, keywords
- [ ] Bundle identifier matches Apple Developer account
- [ ] Code signing configured correctly
- [ ] Build runs on iOS 15.0+ devices

## Performance Targets

- App launch: < 2 seconds
- Calculation response: < 100ms
- Memory usage: < 100MB average
- Scrolling: 60fps minimum

## Privacy & Security

- **No tracking**: CalcPro doesn't collect any user data
- **Offline-first**: All calculations are local to device
- **No accounts**: No login or registration required
- **No ads**: Ad-free experience
- **Open source friendly**: Transparent implementation

## Contributing

Guidelines for contributing:
1. Follow MVVM architecture pattern
2. Add unit tests for new features
3. Maintain WCAG AA accessibility compliance
4. Test on multiple devices (iPhone, iPad)
5. Ensure light & dark mode support

## Roadmap

### Phase 1 (Week 10)
- ✅ Core calculator engine
- ✅ Basic arithmetic operations
- ✅ UI with SwiftUI
- ✅ History tracking
- ✅ Settings
- ✅ Accessibility
- Launch on App Store (5 markets: US, UK, CA, AU, IE)

### Phase 2 (Weeks 11-16)
- Business calculators (Tax, Markup, Tip, Invoice)
- Localization (8 languages)
- Export to CSV/PDF
- Currency converter
- Loan calculator
- Expand to 25+ markets

### Phase 3 (Weeks 18-24)
- Advanced calculators
- iCloud sync (optional)
- Premium tier (optional)
- 50+ market coverage
- 12+ languages

## Support

For issues or questions:
- Create an issue in GitHub
- Email: support@calcpro.local

## License

Private project - All rights reserved

---

**Built with SwiftUI • Designed for iOS 15+ • Made for business professionals**
