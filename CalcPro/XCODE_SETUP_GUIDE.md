# CalcPro - Xcode Project Setup Guide

This guide walks you through creating an Xcode project and integrating the CalcPro source files.

## Step 1: Create a New Xcode Project

### 1.1 Launch Xcode
- Open Xcode from Applications
- File > New > Project (or Cmd + Shift + N)

### 1.2 Select iOS App Template
- Click "iOS"
- Select "App"
- Click "Next"

### 1.3 Configure Project Settings
Fill in the following fields:

| Field | Value |
|-------|-------|
| Product Name | `CalcPro` |
| Team | Your Apple Developer Team |
| Organization Identifier | `com.yourcompany` (replace with your domain) |
| Bundle Identifier | `com.yourcompany.calcpro` |
| Interface | `SwiftUI` |
| Life Cycle | `SwiftUI App` |
| Language | `Swift` |
| Storage | `None` (we'll use UserDefaults) |
| ☐ Include Tests | ✓ Check this |
| ☐ Use Core Data | Uncheck |

Click "Next" and choose a save location.

### 1.4 Verify Project Structure
After creation, your project should have:
```
CalcPro/
├── CalcPro.xcodeproj
├── CalcPro/
│   ├── CalcProApp.swift
│   ├── ContentView.swift (delete this)
│   ├── Assets.xcassets
│   └── Preview Content/
├── CalcProTests/
└── CalcProUITests/
```

## Step 2: Organize Project Structure

### 2.1 Create Folder Groups
In Xcode, right-click the "CalcPro" project folder and create these groups:

1. **Presentation**
   - Views
   - ViewModels
   - Components

2. **Domain**
   - Models
   - UseCases

3. **Data**
   - Repositories
   - Persistence

4. **Utilities**

### 2.2 Delete Unnecessary Files
- Delete the default `ContentView.swift`
- Keep `CalcProApp.swift` (we'll replace its content)

## Step 3: Add Source Files

### 3.1 Copy Core Files
Copy these files from the repository into your Xcode project:

**Utilities folder:**
- `CalculatorEngine.swift`

**Domain/Models folder:**
- `Calculation.swift`

**Data/Repositories folder:**
- `CalculationRepository.swift`

**Presentation/ViewModels folder:**
- `CalculatorViewModel.swift`

**Presentation/Views folder:**
- `CalculatorView.swift`

**Presentation/Components folder:**
- `CalculatorButton.swift`
- `CalculatorDisplay.swift`

**App folder (root):**
- Replace `CalcProApp.swift` with the version from repository

### 3.2 Add Files in Xcode

For each file:
1. Right-click the target folder group
2. Select "Add Files to CalcPro..."
3. Browse to the source file
4. ☐ Make sure "Copy items if needed" is checked
5. ☐ Select "Create folder references" if needed
6. Click "Add"

## Step 4: Configure Build Settings

### 4.1 Select Target
- In project navigator, click `CalcPro.xcodeproj`
- Select `CalcPro` under TARGETS
- Select "Build Settings" tab

### 4.2 Set Minimum Deployment
- Search for "Minimum Deployments"
- Set to `15.0`

### 4.3 Configure Supported Platforms
- Search for "Supported Platforms"
- Value should be `iphoneos` and `ipados`

### 4.4 Swift Settings
- Swift Language Version: `Swift 5.9` or later
- Optimization Level (Debug): `-Onone`
- Optimization Level (Release): `-O`

## Step 5: Configure App Icon & Assets

### 5.1 App Icon
- In Xcode, select `Assets.xcassets`
- Select "AppIcon"
- Drag your 1024x1024 icon to the "App Store" slot
- Xcode will auto-generate other sizes

### 5.2 Colors (Optional)
For custom colors, you can add a ColorSet to Assets, but the current code uses system colors.

## Step 6: Configure Info.plist

### 6.1 Open Info.plist
- Select `Info.plist` in project navigator
- Click "Information Property List" to expand

### 6.2 Verify Key Settings
| Key | Value |
|-----|-------|
| CFBundleDisplayName | CalcPro |
| CFBundleExecutable | CalcPro |
| CFBundleIdentifier | com.yourcompany.calcpro |
| CFBundleVersion | 1.0.0 |
| CFBundleShortVersionString | 1.0.0 |
| NSMinimumOSVersion | 15.0 |

## Step 7: Test Build

### 7.1 Select Simulator
- Top of Xcode window: Select "iPhone 15" or simulator of choice
- Or connect a physical device

### 7.2 Build Project
- Cmd + B to build
- Fix any errors that appear

### 7.3 Run App
- Cmd + R to run
- App should launch with basic calculator

## Step 8: Add Unit Tests

### 8.1 Copy Test File
- Copy `CalculatorEngineTests.swift` from repository
- Right-click `CalcProTests` folder
- "Add Files to CalcPro..."
- Select the test file

### 8.2 Run Tests
- Cmd + U to run all tests
- All tests should pass (60+ assertions)

## Step 9: Code Signing (For Device Testing)

### 9.1 Configure Signing
- Select project: `CalcPro.xcodeproj`
- Select target: `CalcPro`
- "Signing & Capabilities" tab
- Team: Select your Apple Developer team
- Bundle Identifier: Should auto-populate

### 9.2 Connect Device (Optional)
- Plug in iPhone or iPad
- Xcode will register the device
- Select device from scheme dropdown
- Cmd + R to build and run on device

## Step 10: Build for Release

### 10.1 Archive App
- Generic iOS Device or real device selected
- Product > Archive
- Organizer window appears

### 10.2 Distribute
- Select your archive
- "Distribute App"
- Choose "App Store Connect"
- Follow prompts to upload

## Troubleshooting

### Build Errors

**"Cannot find type 'CalculatorViewModel'"**
- Make sure all files are added to the project target
- Select file in navigator > File Inspector > Target Membership (check CalcPro)

**"Module not found"**
- Clean build: Cmd + Shift + K
- Rebuild: Cmd + B

**"Code signing error"**
- Project settings > Signing & Capabilities
- Select a valid Team
- Or use Xcode's automatic signing

### Runtime Issues

**"App crashes on launch"**
- Check Console (Cmd + Shift + C)
- Look for error messages
- Verify all files are properly copied

**"Views not showing"**
- Make sure `CalcProApp.swift` is the entry point
- Check that `CalculatorView` is exported properly

**"History not saving"**
- UserDefaults should work automatically
- Check device has storage space
- Clear app data and try again (simulator: Erase)

## Performance Verification

### Check Build Time
- Cmd + Shift + K (clean)
- Cmd + B (build)
- Note the time (should be <30 seconds for first build)

### Check App Launch
- Stop app: Cmd + .
- Run again: Cmd + R
- Watch for "Running CalcPro" in console

### Profile App
- Product > Profile (Cmd + I)
- Instruments window opens
- Check CPU, Memory, Energy usage
- All should be low

## Next Steps

1. **Customize Colors** (Optional)
   - Create custom colors in Assets
   - Update CalculatorButton.swift to use custom colors

2. **Add Custom Fonts** (Phase 2)
   - Add .ttf files to project
   - Register in Info.plist
   - Use in views

3. **Create Marketing Assets**
   - Screenshots for App Store
   - App preview video
   - Privacy policy

4. **Prepare for App Store**
   - Create App Store Connect account
   - Set up bundle identifier
   - Create app record
   - Prepare metadata

## Resources

- [Apple SwiftUI Documentation](https://developer.apple.com/documentation/swiftui)
- [iOS App Development Guide](https://developer.apple.com/ios/)
- [App Store Connect Help](https://help.apple.com/app-store-connect/)
- [Xcode Documentation](https://developer.apple.com/documentation/xcode)

## Support

If you get stuck:
1. Check the README.md
2. Review CALCPRO_MULTI_COUNTRY_STRATEGY.md for multi-country setup
3. Check Xcode's issue navigator (Cmd + 5)
4. Build settings warnings tab for configuration issues

---

**You're all set! Your CalcPro project is ready to develop.** 🚀

Next: Make sure all tests pass, then start building Phase 1 features!
