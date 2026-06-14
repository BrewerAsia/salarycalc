# SalaryCalc - Build Guide

## Quick Start

### Option 1: Using Makefile (Recommended)

```bash
cd /Users/kante/research/SalaryCalcXcode

# Build and run
make run

# Or just build
make build

# Run tests
make test

# See all commands
make help
```

### Option 2: Using Xcode GUI

1. Open Xcode project
2. Select iPhone 15 simulator
3. Press Cmd + R to run

### Option 3: Using xcodebuild CLI

```bash
cd /Users/kante/research/SalaryCalcXcode

# Build
xcodebuild -scheme SalaryCalc -configuration Debug \
  -destination 'platform=iOS Simulator,name=iPhone 15' build

# Run tests
xcodebuild -scheme SalaryCalc test \
  -destination 'platform=iOS Simulator,name=iPhone 15'
```

---

## Available Make Commands

### Development

| Command | Purpose |
|---------|---------|
| `make build` | Build for simulator |
| `make run` | Build and run on simulator |
| `make test` | Run all tests |
| `make clean` | Clean build folder |

### App Store

| Command | Purpose |
|---------|---------|
| `make build-release` | Build release version |
| `make archive` | Create App Store archive |
| `make validate` | Validate archive |
| `make upload` | Upload to App Store Connect |

### Utilities

| Command | Purpose |
|---------|---------|
| `make device-list` | List available simulators |
| `make erase-sim` | Erase simulator data |
| `make open-xcode` | Open Xcode project |
| `make info` | Show project info |

---

## Full Build Workflow

### 1. Clean (Optional)
```bash
make clean
```

### 2. Build
```bash
make build
```

**Expected output:**
```
Build complete!
```

### 3. Run on Simulator
```bash
make run
```

**Expected result:**
- Simulator launches
- SalaryCalc app opens
- Calculator is visible

### 4. Test
```bash
make test
```

**Expected output:**
```
All tests passed!
```

---

## Troubleshooting

### Build Fails with "Cannot find type"

**Solution:** Make sure all Swift files were added to the SalaryCalc target

1. In Xcode, select each .swift file
2. In File Inspector (right panel)
3. Check "SalaryCalc" in Target Membership

### Build Fails with "Code signing error"

**Solution:** Configure code signing

1. Click SalaryCalc.xcodeproj
2. Click SalaryCalc target
3. Click Signing & Capabilities
4. Select your Apple Developer Team

### Simulator Won't Launch

**Solution:** Erase simulator and try again

```bash
make erase-sim
make run
```

---

## App Store Submission Workflow

### 1. Build Release Version
```bash
make build-release
```

### 2. Create Archive
```bash
make archive
```

### 3. Validate Archive
```bash
make validate
```

### 4. Upload Archive

**Option A: Using Xcode Organizer (Recommended)**
```bash
make open-xcode
# Then: Window > Organizer > Archives > Select > Distribute App
```

**Option B: Using Command Line**
```bash
xcrun altool --upload-app \
  -f build/SalaryCalc.xcarchive \
  -u your-apple-id@email.com \
  -p your-app-specific-password \
  --apple-id com.brewersasia.salarycalc
```

---

## Build Configuration

### Debug (Default)
- Used for development
- Includes debug symbols
- Not optimized
- Faster build

### Release
- Used for App Store
- Optimized code
- Smaller size
- Slower build

---

## Performance Tips

### Faster Builds
```bash
# Only build for one simulator
make build

# Parallelize builds
defaults write com.apple.dt.Xcode IDEBuildingParallelizationEnabled YES
```

### Faster Testing
```bash
# Test only specific scheme
xcodebuild test -scheme SalaryCalc
```

### Check Build Time
```bash
time make build
```

---

## Project Structure for Build

```
SalaryCalcXcode/
├── SalaryCalc/              (Main app folder)
│   ├── SalaryCalcApp.swift
│   ├── Presentation/
│   ├── Domain/
│   ├── Data/
│   ├── Utilities/
│   ├── Assets.xcassets
│   └── ...
├── SalaryCalcTests/         (Test folder)
├── SalaryCalc.xcodeproj     (Project file)
├── Makefile                 (This file)
├── ExportOptions.plist      (App Store config)
└── BUILD_GUIDE.md           (This guide)
```

---

## Environment Variables

You can customize builds with environment variables:

```bash
# Build for different simulator
DEVICE_SIMULATOR="iPhone 15 Pro" make run

# Use Release configuration
CONFIGURATION=Release make build

# Custom build path
BUILD_PATH=./custom-build make build
```

---

## CI/CD Integration

### GitHub Actions Example

```yaml
name: Build SalaryCalc

on: [push]

jobs:
  build:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v2
      - name: Build
        run: cd SalaryCalcXcode && make build
      - name: Test
        run: cd SalaryCalcXcode && make test
```

---

## Additional Resources

- [Xcode Build Settings Reference](https://developer.apple.com/documentation/xcode)
- [Apple Developer Documentation](https://developer.apple.com/documentation/)
- [App Store Connect Help](https://help.apple.com/app-store-connect/)

---

## Next Steps

1. **Build:** `make run`
2. **Test:** `make test`
3. **Create assets:** App icon + screenshots
4. **Submit:** `make archive`

---

**Ready to build? Run: `make run`**

🚀
