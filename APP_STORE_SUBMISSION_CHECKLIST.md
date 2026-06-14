# CalcPro - App Store Submission Checklist

**Use this checklist to track your progress through the submission process.**

**Total Time Estimate:** 2-3 hours

---

## ✅ Pre-Submission Preparation

### Account Setup
- [ ] Apple Developer Account created ($99/year)
- [ ] Xcode installed (Version 15.0+)
- [ ] Apple ID signed into Xcode
- [ ] Developer Team visible in Xcode

### Project Creation
- [ ] Xcode project created
- [ ] Project named "CalcPro"
- [ ] Bundle ID: `com.yourcompany.calcpro`
- [ ] Minimum deployment: iOS 15.0
- [ ] SwiftUI selected as interface

### Source Files Integration
- [ ] All Swift files copied from Sources/ folder
- [ ] File structure organized in Xcode:
  - [ ] App/
  - [ ] Presentation/Views/
  - [ ] Presentation/ViewModels/
  - [ ] Presentation/Components/
  - [ ] Domain/Models/
  - [ ] Data/Repositories/
  - [ ] Utilities/
- [ ] CalcProApp.swift updated with CalculatorView
- [ ] ContentView.swift deleted
- [ ] Tests copied to CalcProTests folder

### Build Configuration
- [ ] Signing & Capabilities: Team selected
- [ ] Bundle Identifier matches App Store Connect
- [ ] Version number set: 1.0.0
- [ ] Build number set: 1
- [ ] Deployment target: iOS 15.0

---

## 🧪 Testing & Verification

### Functionality Testing
- [ ] App builds successfully (Cmd + B)
- [ ] App runs on simulator (Cmd + R)
- [ ] All tests pass (Cmd + U)
- [ ] Basic math works (2+2=4)
- [ ] Calculation history saves
- [ ] Clear button resets
- [ ] Decimal calculations work
- [ ] Division by zero handled
- [ ] Settings save and load
- [ ] Dark mode works
- [ ] Light mode works

### Device Testing
- [ ] App runs on iPhone simulator
- [ ] App runs on iPad simulator
- [ ] App runs on physical iPhone (if available)
- [ ] Portrait orientation works
- [ ] Landscape orientation works
- [ ] iPad landscape optimized

### Accessibility Testing
- [ ] VoiceOver enabled (Settings > Accessibility)
- [ ] All buttons have labels
- [ ] Display is readable with VoiceOver
- [ ] Text scaling works (100-200% sizes)
- [ ] Color contrast verified (4.5:1 for text)
- [ ] No flashing content

### Performance Testing
- [ ] App launch time: < 2 seconds
- [ ] Calculation response: < 100ms
- [ ] No crashes observed
- [ ] Memory usage reasonable
- [ ] No battery drain issues

---

## 📱 Create Marketing Assets

### App Icon
- [ ] Icon created (1024 × 1024 PNG)
- [ ] Icon design is professional
- [ ] Icon uploaded to Xcode (Assets.xcassets > AppIcon)

### Screenshots - iPhone
- [ ] Screenshot 1 taken (1170 × 2532)
- [ ] Screenshot 2 taken (1170 × 2532)
- [ ] Both screenshots show app clearly
- [ ] Text is readable
- [ ] Files saved as PNG

### Screenshots - iPad
- [ ] Screenshot 1 taken (2048 × 2732)
- [ ] Screenshot 2 taken (2048 × 2732)
- [ ] Both screenshots optimized for iPad
- [ ] Landscape layout shown

### App Store Metadata
- [ ] App Name: "CalcPro"
- [ ] Subtitle: "Professional Business Calculator"
- [ ] Category: "Utilities"
- [ ] Description written (see template below)
- [ ] Keywords created (calculator, business, math, finance, accounting)
- [ ] Support URL: (public website or leave blank)
- [ ] Privacy Policy: Created and public (see PRIVACY_POLICY.md)

---

## 🌐 App Store Connect Setup

### Create App Record
- [ ] Log in to appstoreconnect.apple.com
- [ ] New App created
- [ ] App Name: "CalcPro"
- [ ] Bundle ID: `com.yourcompany.calcpro`
- [ ] Primary Language: English

### Set Pricing & Availability
- [ ] Price Tier: **Free**
- [ ] Availability: **All Territories**
- [ ] Release Date: Today (or future date)

### Privacy & Age Rating
- [ ] Privacy Policy URL: Entered (public URL)
- [ ] Age Rating: **4+**
- [ ] Questionnaire completed (no adult content)

### App Listing
- [ ] Subtitle entered: "Professional Business Calculator"
- [ ] Description entered (see template)
- [ ] Keywords entered
- [ ] Support URL entered (optional)
- [ ] Screenshots uploaded (iPhone):
  - [ ] 1170 × 2532 screenshot 1
  - [ ] 1170 × 2532 screenshot 2
- [ ] Screenshots uploaded (iPad):
  - [ ] 2048 × 2732 screenshot 1
  - [ ] 2048 × 2732 screenshot 2
- [ ] Version notes entered: "Initial release"

### Rights & Claims
- [ ] Content Rights: ☑ Yes
- [ ] Advertising ID: ☑ No
- [ ] Apple TV Description: (leave blank)

---

## 🏗️ Build for App Store

### Final Code Check
- [ ] No hardcoded URLs
- [ ] No debug logging
- [ ] No test credentials
- [ ] No commented-out code (unless necessary)
- [ ] Code follows MVVM pattern
- [ ] Accessibility labels on all interactive elements

### Build Archive
- [ ] Clean build folder (Cmd + Shift + K)
- [ ] Select "Generic iOS Device" in scheme
- [ ] Build succeeds (Cmd + B)
- [ ] Archive succeeds (Product > Archive)
- [ ] Archive validates without errors

### Upload to App Store Connect
- [ ] Organizer window open
- [ ] Archive selected
- [ ] Distribute App > App Store Connect selected
- [ ] Upload selected (not Export)
- [ ] Team selected correctly
- [ ] Re-sign with provisioning profile: ✓ Checked
- [ ] Upload completes successfully
- [ ] See "Upload Successful" message

### Verify Build in App Store Connect
- [ ] Build appears in Builds section
- [ ] Status shows "Processing" then "Ready"
- [ ] Build number is correct (1)
- [ ] Version number is correct (1.0.0)

---

## 📋 Pre-Submission Review

### Final Checklist
- [ ] App Name is correct: "CalcPro"
- [ ] Bundle ID is correct: "com.yourcompany.calcpro"
- [ ] Version 1.0.0, Build 1
- [ ] Category: Utilities
- [ ] Description is complete and professional
- [ ] Keywords entered (calculator, business, math, finance, accounting)
- [ ] Screenshots uploaded and clear
- [ ] App Icon uploaded and professional
- [ ] Privacy Policy URL is public and accessible
- [ ] Age Rating: 4+
- [ ] Build uploaded and ready
- [ ] No rejected statuses or warnings

### Review Requirements (Apple)
- [ ] App functions as described
- [ ] No crashes on launch
- [ ] No missing permissions needed
- [ ] Privacy policy accessible
- [ ] Age-appropriate content
- [ ] No misleading content
- [ ] Works offline (as advertised)
- [ ] No accounts required

---

## 🚀 Submit for Review

### Submission
- [ ] Click "Prepare for Submission"
- [ ] Review all fields one final time
- [ ] Advertising ID: ☑ No
- [ ] Age Restricted: ☑ No
- [ ] Content Rights: ☑ Yes
- [ ] Export Compliance: ☑ No
- [ ] Notes: (optional) "Offline calculator app for iOS 15+"
- [ ] Click "Submit for Review"
- [ ] Confirm submission

### Track Status
- [ ] Check App Store Connect daily
- [ ] Monitor for rejection emails
- [ ] Expected review time: 24-48 hours
- [ ] Status appears: "Waiting for Review"
- [ ] Status changes to: "In Review" (next day)
- [ ] Status changes to: "Ready for Sale" (approved!) ✓

---

## ✅ Post-Approval Actions

### When Approved
- [ ] App shows "Ready for Sale" status
- [ ] App appears on App Store
- [ ] Searchable by name "CalcPro"
- [ ] Downloadable from all regions
- [ ] Verify app can be downloaded on test device

### Monitor After Launch
- [ ] Check for crash reports (daily first week)
- [ ] Monitor user reviews (daily first week)
- [ ] Respond to feedback professionally
- [ ] Fix critical bugs immediately
- [ ] Plan Phase 2 enhancements

### Plan Next Steps
- [ ] Review Phase 2 features (business calculators)
- [ ] Plan localization (8 languages)
- [ ] Start marketing campaign
- [ ] Track download analytics
- [ ] Begin Phase 2 development

---

## 📝 App Store Description Template

Use this as your app description (fill in blanks):

```
CalcPro: Professional Business Calculator

Fast, accurate, reliable—the calculator business professionals trust.

Perfect for:
✓ Small business owners
✓ Accountants & bookkeepers
✓ Sales professionals
✓ Contractors & freelancers
✓ Anyone who needs reliable calculations

FEATURES:
• Basic arithmetic operations (add, subtract, multiply, divide)
• Percentage calculations
• Calculation history with timestamps
• User preferences (decimal places, currency symbol)
• Dark & light mode support
• Full iPad & landscape support
• Works completely offline—no internet required
• Full accessibility support (VoiceOver, text scaling)

PRIVACY FIRST:
Your calculations stay on your device. We don't collect data, don't track usage, and don't require accounts. Period.

Available on iPhone, iPad, and iPod touch.
Requires iOS 15.0 or later.

Version 1.0.0
```

---

## 🆘 If Rejected

### Check Feedback
- [ ] Read Apple's rejection email
- [ ] Note specific reason(s)
- [ ] Check App Store Connect for detailed feedback

### Common Rejections & Fixes

| Issue | Fix |
|-------|-----|
| Crashes on launch | Cmd + U (verify tests pass), check console for errors |
| Missing privacy policy | Add public URL to privacy policy |
| Incomplete metadata | Verify all fields filled (description, keywords, etc.) |
| Doesn't match description | Ensure app functionality matches listing |
| Guideline violation | Review rejection reason, fix, increment build number |

### Resubmit
- [ ] Fix the reported issue in Xcode
- [ ] Increment build number (1 → 2)
- [ ] Recompile and upload (Part 7 of guide)
- [ ] Resubmit for review (Part 9 of guide)
- [ ] Expected re-review: 24-48 hours

---

## 📞 Get Help

**If you get stuck:**

1. **Read:** `/Users/kante/research/CalcPro/APP_STORE_SUBMISSION_GUIDE.md`
2. **Check:** `/Users/kante/research/CalcPro/XCODE_SETUP_GUIDE.md`
3. **Review:** `/Users/kante/research/CalcPro/CLAUDE.md`
4. **Search:** App Store Connect Help (appstoreconnect.apple.com/help)
5. **Apple Docs:** https://developer.apple.com/documentation/

---

## 🎯 Success Criteria

Your submission is successful when:

1. ✅ App builds without errors
2. ✅ All tests pass (Cmd + U)
3. ✅ App runs without crashing
4. ✅ Build uploads to App Store Connect
5. ✅ Status changes from "In Review" to "Ready for Sale"
6. ✅ App appears on Apple App Store
7. ✅ App is downloadable and functional

---

## 📊 Timeline

| Step | Duration | Total Time |
|------|----------|-----------|
| Xcode Setup | 15 min | 15 min |
| Add Source Files | 10 min | 25 min |
| Configure Project | 10 min | 35 min |
| Create Assets | 20 min | 55 min |
| App Store Connect Setup | 15 min | 70 min |
| Build & Upload | 20 min | 90 min |
| Review Monitoring | 24-48 hours | 24-72 hours |

**Total: 2-3 hours of work + 24-48 hours for Apple review**

---

## 🎉 Congratulations!

Once approved, CalcPro will be live on the Apple App Store!

**Next Steps:**
- Monitor downloads and reviews
- Plan Phase 2 (business calculators, localization)
- Expand to 25+ markets globally
- Build a thriving user base

---

**Good luck with your submission!** 🚀

**Questions?** See APP_STORE_SUBMISSION_GUIDE.md for detailed instructions.
