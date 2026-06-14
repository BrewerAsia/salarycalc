# CalcPro - Complete App Submission Workflow

**This document provides the complete step-by-step workflow for submitting CalcPro to the Apple App Store.**

---

## 🎯 Overview

```
Step 1: Prepare        (30 min)    → Gather all requirements
Step 2: Create Xcode   (15 min)    → Create iOS project
Step 3: Add Code       (10 min)    → Add source files
Step 4: Configure      (10 min)    → Set build settings
Step 5: Create Assets  (20 min)    → Icon, screenshots, metadata
Step 6: App Store      (15 min)    → Set up app record
Step 7: Build & Upload (20 min)    → Archive and upload
Step 8: Submit         (5 min)     → Submit for review
Step 9: Monitor        (24-48h)    → Wait for approval
Step 10: Launch        (5 min)     → App goes live
```

**Total Time: 2-3 hours + 24-48 hours for Apple review**

---

## 📋 STEP 1: PREPARE YOUR ENVIRONMENT (30 minutes)

### 1.1 Verify Prerequisites

**Check you have:**
- [ ] macOS 13.0 or later (Apple menu > About This Mac)
- [ ] Xcode 15.0+ (download from Mac App Store, ~12GB)
- [ ] Apple Developer Account ($99/year)
- [ ] 30GB free disk space

### 1.2 Organize Your Files

**Location:** `/Users/kante/research/CalcPro/`

Verify these exist:
```bash
# Run in Terminal:
ls -la /Users/kante/research/CalcPro/Sources/
ls -la /Users/kante/research/CalcPro/Tests/
ls -la /Users/kante/research/CalcPro/PRIVACY_POLICY.md
```

Should show:
- ✅ Sources/ (Utilities/, Domain/, Data/, Presentation/, App/)
- ✅ Tests/ (CalculatorEngineTests.swift)
- ✅ PRIVACY_POLICY.md
- ✅ README.md
- ✅ CLAUDE.md

### 1.3 Create Marketing Materials

**You'll need:**
- [ ] App icon (1024 × 1024 PNG) - use Figma or Canva
- [ ] 2 iPhone screenshots (1170 × 2532 PNG each)
- [ ] 2 iPad screenshots (2048 × 2732 PNG each)
- [ ] App description (copy from template)
- [ ] Keywords: "calculator, business, math, finance, accounting"

**Don't have these yet?**
- Icon: Create in [Canva.com](https://canva.com) (search "calculator icon")
- Screenshots: Skip for now, create after testing
- Description: Already prepared in PRIVACY_POLICY.md

### 1.4 Prepare Apple Developer Account

```bash
# Open browser and go to:
https://developer.apple.com/account/

# If you don't have an account:
# 1. Click "Sign Up"
# 2. Create Apple ID (or use existing)
# 3. Enroll in Apple Developer Program ($99/year)
# 4. Wait 24-48 hours for approval
# 5. Come back here when approved
```

If approved, you should see:
- Certificate signing request option
- Provisioning profiles
- Team name visible

---

## 🏗️ STEP 2: CREATE XCODE PROJECT (15 minutes)

### 2.1 Launch Xcode

```bash
# Option A: From Applications
open /Applications/Xcode.app

# Option B: From Terminal
xcode-select --install
```

Wait for Xcode to fully load (1-2 minutes)

### 2.2 Create New Project

```
Xcode Menu > File > New > Project
```

Or keyboard shortcut: `Cmd + Shift + N`

### 2.3 Select iOS App

1. Click **iOS** (left sidebar)
2. Select **App** template
3. Click **Next**

### 2.4 Configure Project

Fill in these exact values:

```
Product Name:           CalcPro
Team:                   Your Apple Developer Team (or None)
Organization Identifier: com.yourcompany
Bundle Identifier:      com.yourcompany.calcpro
Interface:              SwiftUI
Life Cycle:             SwiftUI App
Language:               Swift
Include Tests:          ✓ Checked
Use Core Data:          ☐ Unchecked
```

**Example:**
- Organization: `com.yourcompany`
- Bundle ID becomes: `com.yourcompany.calcpro`

Click **Next**

### 2.5 Choose Save Location

```
Save to: /Users/kante/research/
Create folder: CalcProXcode (or preferred name)
```

Click **Create**

### 2.6 Verify Project Created

Xcode shows your new project:

```
CalcPro Project Navigator (left sidebar):
├── CalcProApp.swift
├── ContentView.swift
├── Assets.xcassets
├── Preview Content/
├── CalcProTests/
└── CalcProUITests/
```

**Next:** Delete `ContentView.swift` (we don't need it)

---

## 📂 STEP 3: ADD SOURCE FILES (10 minutes)

### 3.1 Copy Swift Files

**From:** `/Users/kante/research/CalcPro/Sources/`
**To:** Your new Xcode project

**Easiest method - Drag and Drop:**

1. **Open Finder:** Navigate to `/Users/kante/research/CalcPro/Sources/`
2. **In Xcode:** Left panel, click the project folder "CalcPro"
3. **Drag these folders** from Finder to Xcode:
   - `Utilities/`
   - `Domain/`
   - `Data/`
   - `Presentation/`
   - `App/`

4. **When dialog appears:**
   - ☑ Copy items if needed
   - ☑ Create groups
   - Select target: "CalcPro"
   - Click **Finish**

### 3.2 Update CalcProApp.swift

1. In Xcode, click `CalcProApp.swift` in left panel
2. **Delete all content**
3. **Replace with:**

```swift
import SwiftUI

@main
struct CalcProApp: App {
    var body: some Scene {
        WindowGroup {
            CalculatorView()
        }
    }
}
```

4. Press `Cmd + S` to save

### 3.3 Delete ContentView.swift

1. Right-click `ContentView.swift` in Xcode
2. Select **Delete**
3. Choose **Remove Reference** (not Delete File)

### 3.4 Add Test File

1. Right-click `CalcProTests` in left panel
2. Select **Add Files to "CalcProTests"...**
3. Navigate to `/Users/kante/research/CalcPro/Tests/`
4. Select `CalculatorEngineTests.swift`
5. ☑ Copy items if needed
6. Click **Add**

### 3.5 Verify Structure in Xcode

Left panel should show:

```
CalcPro/
├── Utilities/
│   └── CalculatorEngine.swift
├── Domain/
│   └── Models/
│       └── Calculation.swift
├── Data/
│   └── Repositories/
│       └── CalculationRepository.swift
├── Presentation/
│   ├── Views/
│   ├── ViewModels/
│   └── Components/
├── CalcProApp.swift
├── Assets.xcassets
└── Preview Content/

CalcProTests/
└── CalculatorEngineTests.swift
```

---

## 🔧 STEP 4: CONFIGURE PROJECT (10 minutes)

### 4.1 Select Project

In Xcode left panel, click `CalcPro.xcodeproj` (blue file icon)

### 4.2 Select Target

Click `CalcPro` under **TARGETS** section

### 4.3 Set Deployment Target

1. Click **Build Settings** tab
2. Search for: `Minimum Deployments`
3. Set value to: **15.0**

### 4.4 Configure Code Signing

1. Click **Signing & Capabilities** tab
2. **Team dropdown:** Select your Apple Developer Team
   - If missing: Click **Add an Account**
   - Sign in with your Apple ID
   - Select team
3. **Bundle Identifier:** Should auto-populate `com.yourcompany.calcpro`
4. **Automatically manage signing:** ✓ Checked

### 4.5 Set Version Numbers

1. Click **General** tab (or **Info** tab)
2. **Version:** Set to `1.0.0`
3. **Build:** Set to `1`

### 4.6 Build & Test

```bash
# Build the project
Cmd + B

# Run app in simulator
Cmd + R

# Run all tests
Cmd + U
```

**Expected results:**
- Build succeeds ✓
- App launches and shows calculator ✓
- All 60+ tests pass ✓

---

## 📱 STEP 5: CREATE APP STORE ASSETS (20 minutes)

### 5.1 Create App Icon

**Size needed:** 1024 × 1024 pixels (PNG)

**Quick options:**
1. **Figma** (free): figma.com
2. **Canva** (free): canva.com
3. **AI Generator:** "Create professional calculator app icon"

**Save as:** `AppIcon-1024.png`

### 5.2 Upload Icon to Xcode

1. In Xcode, left panel: click `Assets.xcassets`
2. Click **AppIcon** in center panel
3. Drag your `AppIcon-1024.png` to the **App Store** box (1024×1024)
4. Xcode automatically generates all other sizes ✓

### 5.3 Create Screenshots

**For iPhone (1170 × 2532 pixels):**

1. Xcode simulator: Select **iPhone 15**
2. `Cmd + R` to run app
3. `Cmd + S` to take screenshot
4. Save as `iPhone-Screenshot-1.png`
5. Take another screenshot showing different state
6. Save as `iPhone-Screenshot-2.png`

**For iPad (2048 × 2732 pixels):**

1. Xcode simulator: Select **iPad Pro (12.9-inch)**
2. `Cmd + R` to run app
3. `Cmd + S` to take screenshot (x2)
4. Save as `iPad-Screenshot-1.png` and `iPad-Screenshot-2.png`

### 5.4 Write App Description

Create text file with description:

```
CalcPro: Professional Business Calculator

Fast, accurate calculations without distractions.

Perfect for:
• Small business owners
• Accountants & bookkeepers
• Sales professionals
• Contractors & freelancers

FEATURES:
✓ Basic arithmetic operations
✓ Calculation history
✓ User-friendly interface
✓ Dark & light mode
✓ Full iPad support
✓ Works offline

PRIVACY FIRST:
Your calculations stay on your device. No data collection, no tracking.
```

Save as: `AppDescription.txt`

---

## 🌐 STEP 6: APP STORE CONNECT SETUP (15 minutes)

### 6.1 Log In to App Store Connect

```
https://appstoreconnect.apple.com

Sign in with your Apple Developer Account
```

### 6.2 Create New App

1. Click **Apps** (left sidebar)
2. Click **+ New App** button
3. Fill in:
   - **Platforms:** ☑ iOS
   - **Name:** CalcPro
   - **Bundle ID:** com.yourcompany.calcpro
   - **Primary Language:** English
   - **SKU:** calcpro-app (any unique ID)
   - **User Access:** Full Access
4. Click **Create**

### 6.3 Set Pricing & Availability

1. Click **Pricing and Availability**
2. **Price Tier:** Free
3. **Availability:** All Territories (all countries)
4. Click **Save**

### 6.4 Create App Listing

1. Click **App Information**
2. **App Name:** CalcPro
3. **Subtitle:** Professional Business Calculator
4. **Category:** Utilities
5. **Secondary Category:** Productivity
6. Click **Save**

### 6.5 Add Privacy Policy

1. Click **App Privacy**
2. **Privacy Policy URL:**
   - Copy `/Users/kante/research/CalcPro/PRIVACY_POLICY.md` content
   - Create public document (Google Docs, Notion, website)
   - Get shareable link
   - Paste URL here
3. **Age Rating:** 4+
4. Click **Save**

### 6.6 Upload App Listing

1. Click **App Listings**
2. **Subtitle:** Professional Business Calculator
3. **Description:** Paste from AppDescription.txt
4. **Keywords:** calculator, business, math, finance, accounting
5. **Screenshots (iPhone 6.5-inch):**
   - Upload `iPhone-Screenshot-1.png`
   - Upload `iPhone-Screenshot-2.png`
6. **Screenshots (iPad 12.9-inch):**
   - Upload `iPad-Screenshot-1.png`
   - Upload `iPad-Screenshot-2.png`
7. Click **Save**

### 6.7 Set Age Rating

1. Click **Age & Rating**
2. Complete questionnaire:
   - Cartoons/Violence: No
   - Violence: No
   - Adult content: No
   - All others: No
3. Result: **4+** ✓
4. Click **Save**

---

## 🏗️ STEP 7: BUILD & UPLOAD (20 minutes)

### 7.1 Clean and Build

In Xcode:

```
Cmd + Shift + K    (Clean Build Folder)
Cmd + B            (Build)

Wait for: "Build complete!"
```

### 7.2 Select Generic Device

Xcode top menu, scheme selector:

```
Select: Generic iOS Device
(Not a simulator, not a specific device)
```

### 7.3 Archive App

```
Xcode > Product > Archive

Wait 1-2 minutes...
Organizer window opens
```

### 7.4 Validate Archive

In Organizer:

1. Select your archive
2. Click **Validate App**
3. Choose **Team**
4. Click **Validate**

Wait for:
```
"The app bundle signature is valid"
```

### 7.5 Upload to App Store

In Organizer:

1. Select your archive (same one)
2. Click **Distribute App**
3. Select **App Store Connect**
4. Click **Next**
5. Select **Upload** (not Export)
6. Click **Next**
7. Select your **Team**
8. Click **Next**
9. Check: **Re-sign with provisioning profile** ✓
10. Click **Next**
11. Click **Upload**

**Wait 2-5 minutes for upload...**

Expected message:
```
"Upload Successful!"
```

### 7.6 Verify Build Uploaded

Go back to App Store Connect:

1. Click **Builds** section
2. You should see your build listed
3. Status: **Processing** → **Ready for Distribution** (takes ~10 min)

---

## 📝 STEP 8: SUBMIT FOR REVIEW (5 minutes)

### 8.1 Prepare for Submission

In App Store Connect:

1. Click **Prepare for Submission**
2. Verify all sections complete:
   - [ ] App Name: CalcPro
   - [ ] Category: Utilities
   - [ ] Subtitle: Professional Business Calculator
   - [ ] Description: Entered
   - [ ] Keywords: Entered
   - [ ] Screenshots: Uploaded (both iPhone & iPad)
   - [ ] Privacy Policy: Linked
   - [ ] Age Rating: 4+
   - [ ] Build: Selected

### 8.2 Submit for Review

1. Click **Submit for Review** button
2. Dialog appears with questions:
   - **Advertising ID:** ☑ No
   - **Age-Restricted Content:** ☑ No
   - **Content Rights:** ☑ Yes, I own all rights
   - **Export Compliance:** ☑ No (it's a calculator)
   - **Notes:** Leave empty (or add "Offline calculator")
3. Click **Submit**

### 8.3 Confirm Submission

You should see:

```
Status: Waiting for Review
Submission Date: [Today]
Expected Review: 24-48 hours
```

---

## ⏳ STEP 9: MONITOR APPROVAL (24-48 hours)

### 9.1 Check Status Daily

**In App Store Connect:**

1. Go to **App Store** > **App Information**
2. Look for **Status** field
3. Possible statuses:
   - **Waiting for Review** → In queue
   - **In Review** → Being tested
   - **Ready for Sale** → Approved! ✓
   - **Rejected** → See feedback, fix, resubmit

### 9.2 If Approved ✓

Status changes to: **Ready for Sale**

Your app is now live on:
- App Store (all regions you selected)
- Searchable by name
- Downloadable on all iPhones & iPads

### 9.3 If Rejected ✗

You'll receive email with reasons:

**Common fixes:**
- **Crashes:** Run `Cmd + U` tests, fix bugs
- **Missing privacy policy:** Verify URL is public
- **Metadata issues:** Check all fields filled
- **Functionality mismatch:** App doesn't match description

**To resubmit:**
1. Fix the issue in Xcode
2. Increment build number (1 → 2)
3. Repeat Step 7 (Build & Upload)
4. Repeat Step 8 (Submit for Review)

---

## 🎉 STEP 10: LAUNCH & MONITOR (Ongoing)

### 10.1 When Approved

Congratulations! Your app is live! 🚀

**Visible:**
- [ ] On Apple App Store
- [ ] Searchable by "CalcPro"
- [ ] Downloadable on iPhone & iPad
- [ ] Available in all selected regions

### 10.2 First Week Tasks

- [ ] Monitor crash reports daily
- [ ] Respond to user reviews
- [ ] Check analytics (downloads, sessions)
- [ ] Fix critical bugs immediately (if any)
- [ ] Plan Phase 2 features

### 10.3 Create Version 1.0.1 (If Bugs Found)

If users report bugs:

1. Fix bug in Xcode
2. Increment build: `1` → `2`
3. Archive and upload (Step 7)
4. Submit new version (Step 8)
5. Apple reviews in 24-48 hours

---

## 🎯 QUICK REFERENCE

### File Locations

```
Source code:      /Users/kante/research/CalcPro/Sources/
Tests:            /Users/kante/research/CalcPro/Tests/
Privacy policy:   /Users/kante/research/CalcPro/PRIVACY_POLICY.md
Setup guide:      /Users/kante/research/CalcPro/XCODE_SETUP_GUIDE.md
Submission guide: /Users/kante/research/CalcPro/APP_STORE_SUBMISSION_GUIDE.md
```

### Important URLs

```
Xcode:                  https://developer.apple.com/xcode/
App Store Connect:      https://appstoreconnect.apple.com
Apple Developer:        https://developer.apple.com
App Store Guidelines:   https://developer.apple.com/app-store/review/guidelines/
```

### Keyboard Shortcuts

```
Cmd + B     Build project
Cmd + R     Run app
Cmd + U     Run tests
Cmd + I     Profile with Instruments
Cmd + S     Save file
Cmd + Shift + K     Clean build folder
```

---

## ✅ Success Checklist

Your submission is successful when:

1. ✅ Code is committed to git
2. ✅ Xcode project created and builds
3. ✅ All tests pass (Cmd + U)
4. ✅ App runs without crashes
5. ✅ Build uploaded to App Store Connect
6. ✅ App listing complete with metadata
7. ✅ Status changes to "Ready for Sale"
8. ✅ App appears on App Store
9. ✅ App is downloadable and functional
10. ✅ Users can download and use CalcPro

---

## 🆘 Troubleshooting

| Problem | Solution |
|---------|----------|
| "Code signing error" | Xcode > Preferences > Accounts, add Apple ID |
| "Build failed" | Cmd + Shift + K (clean), then Cmd + B (rebuild) |
| "Cannot upload" | Verify Team selected, Bundle ID correct |
| "App rejected" | Read feedback, fix issue, increment build, resubmit |
| "Waiting for review" | Takes 24-48 hours, check daily |

---

## 📞 Get Help

**For setup issues:** See XCODE_SETUP_GUIDE.md
**For submission issues:** See APP_STORE_SUBMISSION_GUIDE.md
**For development questions:** See CLAUDE.md
**For Apple issues:** Visit https://developer.apple.com/help/

---

**You're all set! Your app submission process is complete.** 🎉

**Next steps:**
1. Follow this workflow step-by-step
2. Total time: 2-3 hours + 24-48 hours for review
3. After approval: Your app is live on App Store!

Good luck! 🚀
