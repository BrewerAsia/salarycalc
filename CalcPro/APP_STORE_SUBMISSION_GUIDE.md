# CalcPro - Complete App Store Submission Guide

This guide walks you through creating an Xcode project, building, and submitting CalcPro to the Apple App Store.

**Total Time Required:** 2-3 hours (first time)

---

## 📋 Prerequisites Checklist

Before starting, you need:

- [ ] macOS 13.0 or later
- [ ] Xcode 15.0 or later (free from Mac App Store)
- [ ] Apple Developer Account ($99/year) - [developer.apple.com](https://developer.apple.com)
- [ ] iPhone 6s or later (physical device) OR Xcode simulator
- [ ] Internet connection
- [ ] 30 GB free disk space (for Xcode)

**If you don't have an Apple Developer account:**
1. Go to [developer.apple.com](https://developer.apple.com)
2. Click "Account"
3. Create Apple ID or sign in
4. Enroll in Apple Developer Program ($99/year)
5. Wait 24-48 hours for approval

---

## 🏗️ PART 1: Create Xcode Project (15 minutes)

### Step 1: Open Xcode

```bash
# Launch Xcode (you can also just open it from Applications)
open /Applications/Xcode.app
```

### Step 2: Create New Project

1. **Xcode menu** → File → New → Project
2. Select **iOS**
3. Select **App** template
4. Click **Next**

### Step 3: Configure Project

Fill in these exact values:

| Field | Value |
|-------|-------|
| Product Name | `CalcPro` |
| Team | Your Apple Developer Team (or "None" for now) |
| Organization Identifier | `com.yourcompany` (replace with your domain) |
| Bundle Identifier | `com.yourcompany.calcpro` |
| Interface | **SwiftUI** |
| Life Cycle | **SwiftUI App** |
| Language | **Swift** |
| ☑ Include Tests | Check this |
| ☐ Use Core Data | **Uncheck** |

**Example Bundle ID:** `com.photobucket.calcpro` or `com.yourname.calcpro`

Click **Next** and choose where to save (use `/Users/kante/research/`)

### Step 4: Verify Project Structure

After creation, your Xcode project should show:

```
CalcPro
├── CalcPro (main folder)
│   ├── CalcProApp.swift
│   ├── ContentView.swift (DELETE THIS)
│   ├── Assets.xcassets
│   └── Preview Content
├── CalcProTests
├── CalcProUITests
└── CalcPro.xcodeproj
```

### Step 5: Clean Up Default Files

1. In Xcode left panel, right-click `ContentView.swift`
2. Delete → **Remove Reference**
3. Keep `CalcProApp.swift` (we'll update it)

---

## 📂 PART 2: Add Source Files (10 minutes)

### Copy Swift Files Into Xcode Project

**From:** `/Users/kante/research/CalcPro/Sources/`
**To:** Your Xcode project's `CalcPro` folder

#### Option A: Drag & Drop (Easiest)

1. **Open Finder:** `/Users/kante/research/CalcPro/Sources/`
2. **In Xcode:** Left panel, click the `CalcPro` folder
3. **Drag these folders** from Finder into Xcode:
   - `Utilities/` → Drag into project
   - `Domain/` → Drag into project
   - `Data/` → Drag into project
   - `Presentation/` → Drag into project
   - `App/` → Drag into project

4. When dialog appears:
   - ☑ Copy items if needed
   - ☑ Create groups
   - Select "CalcPro" target
   - Click **Finish**

#### Option B: Manual File Addition (If drag-drop fails)

1. In Xcode: Right-click `CalcPro` folder
2. Select **Add Files to "CalcPro"...**
3. Navigate to `/Users/kante/research/CalcPro/Sources/`
4. Select multiple Swift files (Cmd+click)
5. ☑ Copy items if needed
6. Click **Add**

### Update App Entry Point

1. **Delete default content** from `CalcProApp.swift`
2. **Replace with:**

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

### Verify File Structure in Xcode

You should see in the left panel:

```
CalcPro
├── Utilities
│   └── CalculatorEngine.swift
├── Domain
│   └── Models
│       └── Calculation.swift
├── Data
│   └── Repositories
│       └── CalculationRepository.swift
├── Presentation
│   ├── Views
│   │   └── CalculatorView.swift
│   ├── ViewModels
│   │   └── CalculatorViewModel.swift
│   └── Components
│       ├── CalculatorButton.swift
│       └── CalculatorDisplay.swift
└── CalcProApp.swift
```

### Add Test Files

1. Right-click `CalcProTests` in Xcode
2. Select **Add Files to "CalcProTests"...**
3. Navigate to `/Users/kante/research/CalcPro/Tests/`
4. Select `CalculatorEngineTests.swift`
5. ☑ Copy items if needed
6. Click **Add**

---

## 🔧 PART 3: Configure Project Settings (10 minutes)

### Step 1: Select Project

In Xcode left panel, click `CalcPro.xcodeproj`

### Step 2: Select Target

Click `CalcPro` under TARGETS

### Step 3: Set Deployment Target

Click **Build Settings** tab

Search for: `Minimum Deployments`

Set value to: **15.0**

### Step 4: Configure Code Signing

Click **Signing & Capabilities** tab

1. **Team:** Select your Apple Developer Team
   - If you don't see it, click "Add an Account..."
   - Sign in with your Apple ID
   - Select your team from the dropdown

2. **Bundle Identifier:** Should auto-fill as `com.yourcompany.calcpro`
   - If it shows error, you'll fix this in App Store Connect

3. **Automatically manage signing:** Should be checked ✓

### Step 5: Set App Version

Click **General** tab (or Info tab)

1. Find **Version** → Set to `1.0.0`
2. Find **Build** → Set to `1`

### Step 6: Configure Capabilities (Optional but Recommended)

Click **Signing & Capabilities** tab

Click **+ Capability** button

Add:
- **Background Modes** (optional)
- **App Intents** (optional for future)

---

## 🏗️ PART 4: Build & Test (15 minutes)

### Step 1: Select Simulator or Device

**Top of Xcode window** → Scheme selector

- Choose **iPhone 15** (or any simulator)
- Or connect real iPhone and select it

### Step 2: Build Project

```
Cmd + B    (or Product > Build)
```

**Wait for build to complete.** You should see:
```
Build complete!
```

If you see errors:
- Check XCODE_SETUP_GUIDE.md > Troubleshooting
- Verify all Swift files are in project

### Step 3: Run App

```
Cmd + R    (or Product > Run)
```

**App should launch** showing:
- CalcPro header
- Calculator display showing "0"
- Number pad (0-9)
- Operation buttons (+, −, ×, ÷)

### Step 4: Run Tests

```
Cmd + U    (or Product > Test)
```

**All 60+ tests should pass:**
```
Test Suite 'CalculatorEngineTests' passed at ...
```

### Step 5: Test on Real Device (Optional but Recommended)

1. Connect iPhone via USB
2. In Xcode, select your device from scheme dropdown
3. Cmd + R to build and run
4. App installs on your iPhone
5. Test calculator works

---

## 📱 PART 5: Create App Store Assets (20 minutes)

### 1. Create App Icon

**You need:** 1024 × 1024 PNG image

**Options:**
- Design in Figma (free: figma.com)
- Use Canva (free: canva.com)
- Use AI: "Create a professional calculator app icon"

**Upload to Xcode:**

1. Right-click your created icon
2. Select `Copy`
3. In Xcode, select `Assets.xcassets`
4. Select `AppIcon`
5. Drag your icon to the "App Store" box
6. Xcode auto-generates all sizes ✓

### 2. Create Screenshots (iPhone)

**You need:** 2 screenshots (1170 × 2532 pixels)

**How to capture:**
1. Run app in iPhone simulator or device
2. Take screenshots showing:
   - Screenshot 1: Basic calculator with number pad
   - Screenshot 2: Calculation result and history

**On Simulator:** Cmd + S (saves to Desktop)

**On Device:** Hold Side button + Volume Up

### 3. Create Screenshots (iPad)

**You need:** 2 screenshots (2048 × 2732 pixels)

Run app on iPad simulator:
1. Xcode scheme selector → iPad Pro (12.9-inch)
2. Cmd + R
3. Cmd + S to screenshot

---

## 🌐 PART 6: Set Up App Store Connect (15 minutes)

### Step 1: Create App Record

1. Go to [appstoreconnect.apple.com](https://appstoreconnect.apple.com)
2. Sign in with your Apple ID
3. Click **Apps** (left sidebar)
4. Click **+ New App** button

### Step 2: Fill in App Information

| Field | Value |
|-------|-------|
| Platforms | ☑ iOS |
| Name | CalcPro |
| Primary Language | English |
| Bundle ID | com.yourcompany.calcpro |
| SKU | calcpro-app |
| User Access | Full Access |

Click **Create**

### Step 3: Fill in App Details

Click **App Information** in left sidebar

#### General Information
- **App Name:** CalcPro
- **Subtitle:** Professional Business Calculator
- **Category:** Utilities
- **Secondary Category:** Productivity
- **Content Rights:** ☑ Yes
- **Advertising ID:** ☐ No

#### Pricing & Availability
- **Pricing Tier:** Free
- **Availability:** All territories (all countries)
- **App Availability Date:** Today (or future date)

### Step 4: Set Up Pricing & Availability

Click **Pricing and Availability**

- Set **Price Tier** to **Free**
- Keep **Available in all territories** selected
- Click **Save**

### Step 5: Create App Store Listing

Click **App Privacy** first (IMPORTANT)

**Privacy Policy:**
- [ ] Go to Google Docs
- [ ] Create new document
- [ ] Copy content from `/Users/kante/research/CalcPro/PRIVACY_POLICY.md`
- [ ] File > Share > Get link (Anyone with link)
- [ ] Paste URL here

**Data & Privacy:**
- App does not collect data: **YES**
- Category: **Not applicable (no data collected)**
- Click **Save**

### Step 6: Create Full Listing

Click **App Listings**

**App Subtitle:** "Professional Business Calculator"

**Description:**
```
CalcPro: The reliable calculator for business professionals.

Fast, accurate calculations without distractions. Perfect for:
• Small business owners
• Accountants & bookkeepers
• Sales professionals
• Contractors & freelancers
• Anyone who needs reliable math

FEATURES:
✓ Basic arithmetic operations
✓ Calculation history
✓ User-friendly interface
✓ Dark & light mode support
✓ Full iPad support
✓ Works offline - no internet required

PRIVACY FIRST:
Your calculations stay on your device. No tracking, no data collection, no accounts needed.
```

**Keywords:**
`calculator, business calculator, math, finance, accounting, invoice, tax`

**Support URL:** `https://yourwebsite.com/support` (or leave blank for now)

**Marketing URL:** (leave blank)

**Review Notes:**
```
CalcPro is a offline calculator app for iOS 15+. No special testing required. The app works completely offline and doesn't require any accounts or permissions.
```

**Screenshots & Preview Video:**

1. Click **Screenshots** section
2. Select **iPhone (6.5-inch)**
3. Upload your 2 iPhone screenshots
4. Add captions (optional):
   - Screenshot 1: "Fast & Easy Calculations"
   - Screenshot 2: "Track Your Calculation History"
5. Click **iPad (12.9-inch)**
6. Upload iPad screenshots

**App Preview Video:** (Optional - skip for now)

### Step 7: Set Age Rating

Click **App Privacy** > **Rating**

Fill questionnaire:
- Frequent/Intense Cartoon Violence: **No**
- Frequent/Intense Violence: **No**
- Simulated Gambling: **No**
- Mature/Suggestive Themes: **No**
- Frequent/Intense Adult Content: **No**

**Result:** Rating **4+** ✓

---

## 🔨 PART 7: Build for App Store (20 minutes)

### Step 1: Clean Build

In Xcode:
```
Cmd + Shift + K    (Clean Build Folder)
```

Wait for completion.

### Step 2: Archive App

1. **Select:** Generic iOS Device (Xcode scheme dropdown)
2. **Menu:** Product > Archive
3. Wait 1-2 minutes for build...
4. **Organizer window** opens
5. Select your archive
6. Click **Validate App**
7. Select your **Team**
8. Click **Validate**

**Fix any errors before proceeding**

### Step 3: Upload to App Store

Same window, with archive selected:

1. Click **Distribute App**
2. Select **App Store Connect**
3. Click **Next**
4. Select **Upload** (not export)
5. Click **Next**
6. Select your **Team**
7. Click **Next**
8. Check **Re-sign with provisioning profile**
9. Click **Next**
10. Click **Upload**

**Wait 2-5 minutes...**

You should see:
```
Upload Successful!
```

---

## ✅ PART 8: Complete App Store Information (5 minutes)

Go back to [appstoreconnect.apple.com](https://appstoreconnect.apple.com)

### Step 1: Verify Build Uploaded

Click **App Store** > **Builds**

You should see your build listed with status **Processing** or **Ready for Distribution**

**Wait 5-10 minutes** for processing to complete.

### Step 2: Set Build for Submission

Click **Build** section

**For Internal Testing:** Select your build, click **Add**
**For External Testing:** Select your build, click **Add**
**For Release:** We'll do this after approval

### Step 3: Final Review

Click **App Store** (not "TestFlight")

Review all sections are complete:
- [ ] App Name: CalcPro
- [ ] Subtitle: Professional Business Calculator
- [ ] Description: Complete
- [ ] Keywords: Added
- [ ] Screenshots: Uploaded (both sizes)
- [ ] Rating: 4+
- [ ] Privacy Policy: Added
- [ ] Bundle ID: Correct
- [ ] Version: 1.0.0
- [ ] Build: Selected and ready

---

## 🚀 PART 9: Submit for Review (5 minutes)

### Step 1: Prepare Submission

In App Store Connect, click **Prepare for Submission**

Review the following are complete:
- [ ] Pricing: Free
- [ ] Availability: All territories
- [ ] Build: Selected
- [ ] App Categories: Set
- [ ] Screenshots: Uploaded
- [ ] App Rating: 4+

### Step 2: Submit for Review

Click **Submit for Review** button

A dialog appears:
- **Advertising ID:** No (ours doesn't use ads)
- **Age-Restricted Content:** No
- **Content Rights:** Yes, I own all content
- **Export Compliance:** No (it's a calculator)
- **Notes:** Leave empty (or add "Offline calculator app for iOS 15+")

Click **Submit**

### Step 3: Confirm Submission

You should see:
```
Status: Waiting for Review
Submission Date: [Today's Date]
Expected Review Time: 24-48 hours
```

**Congratulations! Your app is submitted!** 🎉

---

## 📊 PART 10: Monitor Approval (24-48 hours)

### Check Status Regularly

**In App Store Connect:**
1. Click **App Store** > **App Information**
2. Check **Status**

### Possible Statuses

| Status | What It Means |
|--------|---------------|
| **Waiting for Review** | In queue, will be reviewed soon |
| **In Review** | Apple is testing your app |
| **Pending Contract** | You need to accept terms (click Accept) |
| **Ready for Sale** | Approved! Will go live automatically |
| **Rejected** | See feedback, fix issues, resubmit |

### If Rejected

1. **Read Apple's feedback** (email + App Store Connect)
2. **Fix the issues** in Xcode
3. **Increment build number:** Info tab > Build: 2
4. **Archive & upload** again (follow Part 7)
5. **Resubmit** (follow Part 9)

### Common Rejections

- **Crashes on launch:** Ensure tests pass (Cmd + U)
- **Missing privacy policy:** Add public URL
- **Test account needed:** Our app doesn't need one ✓
- **Incomplete metadata:** Verify all fields filled

---

## 🎉 PART 11: Post-Approval (After Approval)

### App Goes Live

Once approved, your app will be available on:
- 🇺🇸 Apple App Store (USA)
- 🌍 All regions you specified
- 📱 Searchable on all iPhones & iPads

### After Launch

1. **Monitor Reviews** - Respond to feedback
2. **Check Crash Logs** - Fix any issues immediately
3. **Plan Phase 2** - Localization, business calculators
4. **Track Analytics** - See download trends

### Create Version 1.0.1 (Bug Fixes)

If users report bugs:

1. **Fix the bug** in Xcode
2. **Increment build:** Info > Build: 2
3. **Archive** and upload
4. **Submit new version** to App Store

---

## 🆘 Troubleshooting

### "Code Signing Error"
- **Solution:** Xcode > Preferences > Accounts > Add Apple ID
- Select team in Signing & Capabilities tab

### "Build Failed"
- **Solution:** Cmd + Shift + K (clean), then Cmd + B (rebuild)
- Check that all Swift files are in the project

### "Cannot validate - Symbol Issue"
- **Solution:** Check "Re-sign with provisioning profile" during upload

### "Waiting for Review for weeks"
- **Note:** This is normal, Apple prioritizes by day
- Can't expedite unless critical security issue

### "App Rejected"
- **Solution:** Read Apple's feedback carefully
- Fix the specific issue
- Increment build number
- Resubmit

---

## 📚 Reference Links

- **App Store Connect:** https://appstoreconnect.apple.com
- **Apple Developer:** https://developer.apple.com
- **App Store Guidelines:** https://developer.apple.com/app-store/review/guidelines/
- **Swift Documentation:** https://developer.apple.com/documentation/swift

---

## ✨ Summary

You've now:

1. ✅ Created an Xcode project
2. ✅ Added all source files
3. ✅ Configured project settings
4. ✅ Created app store assets
5. ✅ Set up App Store Connect
6. ✅ Built and uploaded to App Store
7. ✅ Submitted for review

**Expected timeline:**
- Creation: 2 hours
- App Store review: 24-48 hours
- **Live on App Store:** 24-72 hours from submission

---

**Next Steps After Launch:**

1. **Phase 2:** Implement business calculators
2. **Localization:** Add 8 languages
3. **Global Expansion:** Launch in 25+ markets
4. **Premium Features:** Add optional paid features

See `/Users/kante/research/CALCPRO_MULTI_COUNTRY_STRATEGY.md` for Phase 2+ plans.

---

**🚀 Your app will soon be available to millions of iOS users!**

**Questions?** Refer to XCODE_SETUP_GUIDE.md or CLAUDE.md for development questions.

---

**Good luck with your submission!** 🎉
