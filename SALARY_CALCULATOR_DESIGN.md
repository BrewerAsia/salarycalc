# SalaryCalc - Multi-Country Salary Calculator App Design

**A professional salary calculator app for calculating gross-to-net salary across 50+ countries.**

---

## 📊 App Overview

### **App Name: SalaryCalc**
- **Tagline:** "Know Your Real Salary Worldwide"
- **Subtitle:** "Gross to Net Calculator for 50+ Countries"

### **Target Users:**
- Remote workers earning in different countries
- Expats managing income across borders
- HR professionals calculating employee salaries
- Job seekers understanding actual take-home pay
- Freelancers in international markets

### **Core Problem We Solve:**
When you earn $100,000 gross salary, what's your actual take-home pay after taxes, insurance, and deductions? **It varies drastically by country.** SalaryCalc instantly shows the real number.

---

## 🎯 Key Features

### **Phase 1 (MVP) - Launch**

**Core Calculator:**
- Gross salary input (any currency)
- Automatic net salary calculation
- Tax breakdown by component
- Take-home amount clearly displayed

**Supported Calculations:**
- Income tax
- Social security contributions
- Health insurance deductions
- Pension contributions
- Other standard deductions

**Multi-Country Support (Initial):**
- 🇺🇸 United States (Federal + State options)
- 🇬🇧 United Kingdom
- 🇨🇦 Canada
- 🇦🇺 Australia
- 🇩🇪 Germany
- 🇫🇷 France
- 🇮🇳 India
- 🇨🇭 Switzerland

**User Experience:**
- Simple input: Gross salary amount
- Select: Country & state/province
- Select: Employment type (Full-time, Freelance, etc.)
- Instant: Net salary calculation + breakdown
- Dark/Light mode
- iPad optimized
- Works offline (tax rates built-in)

---

### **Phase 2 - Enhanced Features**

**Advanced Calculations:**
- Salary vs. hourly rate converter
- Annual vs. monthly vs. weekly breakdown
- Bonus calculations
- Stock option valuations
- Currency conversion (live rates)
- Salary comparison between countries

**More Countries:**
- Add 20+ more countries (50+ total)
- Regional variations (US states, etc.)
- Support for EU countries

**Salary Planning:**
- What gross salary do I need to take home $X?
- Salary comparison: Country A vs Country B
- Retirement savings impact
- Loan/mortgage affordability calculator

**Localization:**
- 12+ languages
- Regional currency support
- Localized tax terminology

---

### **Phase 3+ - Future Features**

- Cloud sync (optional, end-to-end encrypted)
- Salary history tracking
- Career earnings projections
- Tax optimization strategies
- API for businesses
- Professional reports/PDFs
- Premium insights (benchmarking, etc.)

---

## 💡 Why This App?

### **Market Opportunity:**
- **2 billion remote workers** globally
- **High demand** for salary calculation tools
- **Recurring use** (monthly/annual salary reviews)
- **International audience** (works everywhere)
- **Monetization potential** (premium features)

### **Competitive Advantage:**
- Accurate multi-country tax data
- Beautifully simple UX
- Privacy-first (offline calculations)
- No account required
- Free for basic use

---

## 🎨 UI/UX Design

### **Main Screen Layout:**

```
┌─────────────────────────────────┐
│    SalaryCalc                   │
│  Know Your Real Salary          │
├─────────────────────────────────┤
│                                 │
│  🌍 Select Country:  [USA ▼]    │
│  📍 State/Province:  [CA ▼]     │
│  💼 Employment Type: [Full-time]│
│                                 │
│  Gross Annual Salary:           │
│  ┌───────────────────────────┐  │
│  │ $100,000                  │  │
│  └───────────────────────────┘  │
│                                 │
├─────────────────────────────────┤
│                                 │
│  💰 NET TAKE-HOME               │
│  ────────────────────────────── │
│  Monthly:    $5,250             │
│  Weekly:     $1,215             │
│  Yearly:     $63,000            │
│                                 │
├─────────────────────────────────┤
│  Tax Breakdown:                 │
│  ├─ Federal Tax:    $18,200     │
│  ├─ FICA (Social):  $7,650      │
│  ├─ Health Ins:     $3,500      │
│  ├─ Pension:        $2,000      │
│  ├─ State Tax:      $2,150      │
│  └─ Other:          $3,500      │
│                                 │
│  [Copy] [Share] [Save]          │
│                                 │
└─────────────────────────────────┘
```

### **Design Principles:**
- **Clarity First:** Users know their salary in 3 seconds
- **Honesty:** Show all deductions transparently
- **Simplicity:** 3-4 inputs, instant calculation
- **Beauty:** Professional, clean, modern design
- **Accessibility:** Large text, high contrast, VoiceOver

### **Color Scheme:**
- **Primary:** Deep Blue (#003D7A) - Trust, professional
- **Accent:** Green (#34C759) - Money, positive
- **Warning:** Red (#FF3B30) - High tax rates
- **Neutral:** Grays for secondary info

---

## 🏗️ Technical Architecture

### **Tech Stack:**

**Frontend:**
- SwiftUI (iOS/iPadOS)
- MVVM + Clean Architecture
- Dark mode support
- iPad optimization

**Backend (Optional, Phase 2+):**
- Cloud API for premium features
- Tax rate updates (monthly)
- Currency conversion service

**Data:**
- Local storage: Tax rates, user calculations
- Offline-first: App works without internet
- No user tracking or data collection

**Tax Data:**
- Hard-coded tax rates (built into app)
- Updated quarterly with new versions
- Accurate for 50+ countries

---

## 📱 Platform Strategy

### **Phase 1 Launch:**
- **Platform:** iOS only (iPhone + iPad)
- **Minimum:** iOS 15.0
- **Markets:** English-speaking countries first
  - USA, UK, Canada, Australia, Ireland

### **Phase 2 Expansion:**
- **Add:** Android version
- **Add:** Web version (progressive web app)
- **Localization:** 12+ languages
- **Markets:** 50+ countries globally

---

## 💰 Monetization Strategy

### **Phase 1 (MVP):**
- **Free:** Basic salary calculator (8 countries)
- **No ads, no tracking**
- **Goal:** Build user base

### **Phase 2 (Premium):**
- **Free Tier:** Basic salary calculation (limited countries)
- **Premium Tier:** $3.99/month or $29.99/year
  - Unlimited countries (50+)
  - Advanced features (comparisons, planning)
  - Currency conversion
  - Salary history tracking
  - Professional reports

### **Alternative Revenue:**
- B2B: API for HR software companies
- White-label version for corporations
- Enterprise license for large companies

---

## 🌍 Country Support - Phase 1

### **Supported Countries (Initial 8):**

#### **🇺🇸 United States**
- Federal income tax
- FICA (Social Security + Medicare)
- State income tax (select state)
- Health insurance deductions
- 401(k) contributions
- Standard or itemized deductions

#### **🇬🇧 United Kingdom**
- Income tax (progressive rates)
- National Insurance Contributions
- Student loan repayment (optional)
- Pension contributions
- Council tax (estimated)

#### **🇨🇦 Canada**
- Federal income tax
- Provincial income tax
- CPP (Canada Pension Plan)
- EI (Employment Insurance)
- Health tax (Quebec)

#### **🇦🇺 Australia**
- Income tax (progressive)
- Medicare levy
- Superannuation contributions
- HELP loan repayments
- Tax offsets and rebates

#### **🇩🇪 Germany**
- Income tax (Einkommensteuer)
- Solidarity surcharge
- Church tax (optional)
- Social insurance contributions
- Pension insurance

#### **🇫🇷 France**
- Income tax (impôt sur le revenu)
- Social contributions
- General social contribution (CSG)
- Social debt repayment contribution (CRDS)

#### **🇮🇳 India**
- Income tax (slab-based)
- Health and education cess
- Provident fund contributions
- Deductions under Section 80

#### **🇨🇭 Switzerland**
- Federal income tax
- Cantonal income tax
- AHV/AVS (Social security)
- Occupational pension
- Unemployment insurance

---

## 🧮 Calculation Logic

### **Basic Formula:**

```
Gross Salary
├─ Income Tax                    → Net after tax
├─ Social Security Contributions → Net after social
├─ Health Insurance             → Net after health
├─ Pension Contributions        → Net after pension
├─ Other Deductions            → Net after other
└─ Final Take-Home Pay         ✓
```

### **Example (USA, California, $100,000):**

```
Gross Salary:           $100,000
─────────────────────────────────
Federal Income Tax:     -$18,200  (18.2%)
FICA (Social/Medicare): -$7,650   (7.65%)
California State Tax:   -$2,150   (2.15%)
Health Insurance:       -$3,500   (3.5%)
Pension (401k):         -$5,000   (5%)
─────────────────────────────────
NET TAKE-HOME:          $63,500
─────────────────────────────────

Monthly:  $5,291
Weekly:   $1,221
Daily:    $244
```

---

## 👥 User Personas

### **Persona 1: Remote Worker**
- Name: Sarah
- Age: 28
- Background: Software engineer working for US company, living in Spain
- Problem: Doesn't know what her actual take-home is after Spanish taxes
- Goal: Understand real income to plan budgets
- Usage: 2-3 times per month (salary reviews, job offers)

### **Persona 2: Job Seeker**
- Name: James
- Age: 35
- Background: Considering job offers in different countries
- Problem: Can't compare offers accurately (different tax systems)
- Goal: Compare real salaries across countries
- Usage: 5-10 times (comparing offers)

### **Persona 3: Freelancer**
- Name: Maria
- Age: 32
- Background: Freelancer working for clients in multiple countries
- Problem: Complex tax situation, needs to understand net income
- Goal: Calculate actual earnings after taxes for budgeting
- Usage: Monthly (invoicing and planning)

### **Persona 4: HR Manager**
- Name: David
- Age: 45
- Background: HR manager at multinational company
- Problem: Needs to calculate net salaries for employees in different countries
- Goal: Understand compensation cost and take-home
- Usage: Daily (employee offers, salary reviews)

---

## 📈 Development Roadmap

### **Phase 1 (MVP) - Weeks 1-10**
- **Timeline:** 2-3 months
- **Team:** 2-3 developers
- **Deliverables:**
  - Calculator engine (accurate tax calculations)
  - UI with 8 countries
  - Dark/Light modes
  - iPad support
  - Accessibility (VoiceOver)
  - Full test coverage
  - Privacy policy
  - App Store submission

### **Phase 2 - Weeks 11-24**
- **Timeline:** 3-4 months
- **Features:**
  - 30+ more countries (50 total)
  - Advanced features (comparisons, planning)
  - Localization (8 languages)
  - Android version
  - Premium tier
  - Web version

### **Phase 3+ - Months 6+**
- **Timeline:** Ongoing
- **Features:**
  - 100+ countries
  - Business API
  - Advanced analytics
  - Global expansion
  - Premium features

---

## 📊 Success Metrics

### **Phase 1 Launch Goals:**
- 5,000+ downloads in first month
- 4.5+ star rating
- 30%+ 7-day retention
- 0 crashes
- <100ms calculation time

### **Phase 2 Goals:**
- 100,000+ downloads
- 50+ countries supported
- Premium conversion: 10-15%
- Global presence in 30+ markets

### **Phase 3+ Goals:**
- 1,000,000+ downloads
- Top salary app worldwide
- $100k+ monthly revenue (premium + API)
- 100+ countries supported

---

## 🎯 Launch Strategy

### **Target Launch Markets (Phase 1):**
1. 🇺🇸 United States (largest market)
2. 🇬🇧 United Kingdom
3. 🇨🇦 Canada
4. 🇦🇺 Australia
5. 🇮🇳 India (growing market)

**Timeline:** Launch simultaneously across 5 markets

### **Marketing Strategy:**
- Remote work communities (Reddit, LinkedIn)
- Expat groups and forums
- HR and finance blogs
- Twitter/X for tech/remote workers
- Product Hunt launch
- Free press coverage

---

## 🔐 Privacy & Security

### **Core Principles:**
- ✅ **No data collection:** All calculations happen locally
- ✅ **No tracking:** No analytics or user tracking
- ✅ **No accounts:** No login required
- ✅ **No ads:** Clean, professional experience
- ✅ **Offline:** Works completely offline
- ✅ **Transparent:** Open about what we calculate

### **Data Storage:**
- Tax rates stored locally (built into app)
- User can save calculations locally
- Optional cloud sync (Phase 2) is encrypted end-to-end
- Zero data sent to servers during calculations

---

## 💡 Competitive Advantages

| Feature | SalaryCalc | Competitors |
|---------|-----------|-------------|
| Countries | 50+ | 10-20 |
| Accuracy | High (built-in rates) | Medium |
| Privacy | Offline first | Cloud-based |
| Price | Free/Premium | Free with ads |
| UX | Beautiful, simple | Complex |
| Updates | Built-in (app update) | Monthly API |
| Offline | ✓ Full | ✗ Online only |

---

## 📱 UI Examples

### **Country Selection:**
```
🌍 Select Country

🇺🇸 United States      → [>]
🇬🇧 United Kingdom     → [>]
🇨🇦 Canada             → [>]
🇦🇺 Australia          → [>]
🇩🇪 Germany            → [>]
🇫🇷 France             → [>]
🇮🇳 India              → [>]
🇨🇭 Switzerland        → [>]

Search: [_____________]
```

### **Results Screen:**
```
┌─────────────────────────┐
│ USA (California)        │
│ Full-time Employee      │
├─────────────────────────┤
│ GROSS: $100,000         │
│ NET:   $63,500          │
├─────────────────────────┤
│ 📊 Breakdown            │
│ Federal Tax:    $18.2K  │
│ FICA:           $7.65K  │
│ State Tax:      $2.15K  │
│ Health:         $3.5K   │
│ Pension:        $5.0K   │
├─────────────────────────┤
│ [Share] [Copy] [Save]   │
└─────────────────────────┘
```

---

## 🚀 Getting Started

### **Week 1: Design & Planning**
- Define all tax calculations for 8 countries
- Create detailed UX mockups
- Set up git repository
- Plan architecture

### **Week 2-3: Core Engine**
- Build calculation engine
- Implement tax logic for each country
- 100% test coverage
- Verify accuracy

### **Week 4-5: UI Development**
- SwiftUI interface
- Country selection
- Results display
- Settings & preferences

### **Week 6-7: Polish & Testing**
- Dark mode
- iPad optimization
- Accessibility (VoiceOver)
- Performance optimization

### **Week 8-9: Prepare Submission**
- Create app icon & screenshots
- Write App Store listing
- Privacy policy
- Final QA

### **Week 10: Submit!**
- Build for App Store
- Upload
- Submit for review
- 24-48 hours: Approval
- Launch! 🎉

---

## 📋 App Store Listing Template

### **App Name:** SalaryCalc
### **Subtitle:** Know Your Real Salary

### **Description:**

```
SalaryCalc: The Salary Calculator for the World

Calculate your actual take-home salary instantly.
No surprises. No hidden taxes. Just the real number.

PERFECT FOR:
✓ Remote workers earning in different countries
✓ Job seekers comparing international offers
✓ Expats managing income across borders
✓ HR professionals calculating net salaries
✓ Freelancers understanding real income

SUPPORTED COUNTRIES:
✓ United States (all states)
✓ United Kingdom
✓ Canada (all provinces)
✓ Australia
✓ Germany
✓ France
✓ India
✓ Switzerland
+ 40+ more coming soon!

WHAT YOU GET:
• Instant gross-to-net calculation
• Detailed tax breakdown
• Support for multiple employment types
• Dark & light modes
• Works completely offline
• No ads, no tracking, no accounts needed

PRIVACY FIRST:
Your salary data never leaves your device. All
calculations happen locally. We don't collect,
track, or sell your data.

ACCURATE:
Built with official tax rates for each country.
Updated quarterly as tax laws change.

KEY FEATURES:
💰 Gross-to-Net Calculator
📊 Tax Breakdown by Component
🌍 Multi-Country Support
💼 Employment Type Selection
📱 Beautiful, Simple Design
🔒 100% Private & Offline

SalaryCalc: Know your real salary worldwide.
```

### **Keywords:**
salary calculator, income calculator, tax calculator, take-home pay, gross to net, remote work, expat salary, salary comparison, tax calculator worldwide

### **Category:** Finance / Productivity

---

## 🎁 Phase 1 Deliverables Summary

✅ iOS app (iPhone + iPad)
✅ 8 countries with accurate tax calculations
✅ Beautiful, accessible UI
✅ Dark/Light mode support
✅ 100+ unit tests
✅ Privacy policy
✅ App Store listing
✅ Marketing assets
✅ Ready to launch worldwide

---

## 🚀 Ready to Build?

This is your complete blueprint for **SalaryCalc** - a professional salary calculator app with massive potential.

**Next Steps:**
1. Review this design
2. Approve the concept
3. Start development (Phase 1)
4. Launch in 10 weeks!

---

**Designed for:** brewersAsia
**Created:** 2026-06-14
**Status:** Ready for Development
**Target Launch:** Phase 1 MVP in 10 weeks

Let's build something that helps millions of people worldwide! 🚀✨
