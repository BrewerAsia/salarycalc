.PHONY: help build clean run test archive submit

# SalaryCalc Makefile - Build Automation

PROJECT_NAME = SalaryCalc
SCHEME = SalaryCalc
CONFIGURATION = Debug
DEVICE_SIMULATOR = "iPhone 15"
BUILD_PATH = ./build

# Colors for output
GREEN = \033[0;32m
BLUE = \033[0;34m
RED = \033[0;31m
NC = \033[0m # No Color

help:
	@echo "$(BLUE)SalaryCalc Build Commands$(NC)"
	@echo ""
	@echo "$(GREEN)Development:$(NC)"
	@echo "  make build          - Build project for simulator"
	@echo "  make run            - Build and run on simulator"
	@echo "  make test           - Run all unit tests"
	@echo "  make clean          - Clean build folder"
	@echo ""
	@echo "$(GREEN)App Store:$(NC)"
	@echo "  make build-release  - Build for App Store (release)"
	@echo "  make archive        - Create App Store archive"
	@echo "  make validate       - Validate archive"
	@echo "  make upload         - Upload to App Store Connect"
	@echo ""
	@echo "$(GREEN)Utilities:$(NC)"
	@echo "  make device-list    - List available simulators"
	@echo "  make erase-sim      - Erase simulator data"
	@echo "  make open-xcode     - Open Xcode project"
	@echo ""

# ===== Development Targets =====

build:
	@echo "$(BLUE)🏗️  Building $(PROJECT_NAME) for simulator...$(NC)"
	xcodebuild \
		-scheme $(SCHEME) \
		-configuration $(CONFIGURATION) \
		-destination 'platform=iOS Simulator,name=$(DEVICE_SIMULATOR)' \
		-derivedDataPath $(BUILD_PATH) \
		build 2>&1 | tail -20
	@echo "$(GREEN)✅ Build complete!$(NC)"

run: build
	@echo "$(BLUE)🚀 Running $(PROJECT_NAME) on simulator...$(NC)"
	xcrun simctl launch booted com.brewersasia.salarycalc || \
	xcodebuild \
		-scheme $(SCHEME) \
		-configuration $(CONFIGURATION) \
		-destination 'platform=iOS Simulator,name=$(DEVICE_SIMULATOR)' \
		-derivedDataPath $(BUILD_PATH) \
		-xunit

test:
	@echo "$(BLUE)🧪 Running tests...$(NC)"
	xcodebuild \
		-scheme $(SCHEME) \
		-configuration $(CONFIGURATION) \
		-destination 'platform=iOS Simulator,name=$(DEVICE_SIMULATOR)' \
		-derivedDataPath $(BUILD_PATH) \
		test 2>&1 | tail -50
	@echo "$(GREEN)✅ Tests complete!$(NC)"

clean:
	@echo "$(BLUE)🧹 Cleaning build folder...$(NC)"
	rm -rf $(BUILD_PATH)
	xcodebuild -scheme $(SCHEME) -configuration $(CONFIGURATION) clean
	@echo "$(GREEN)✅ Clean complete!$(NC)"

# ===== App Store Targets =====

build-release:
	@echo "$(BLUE)🏗️  Building $(PROJECT_NAME) for App Store (Release)...$(NC)"
	xcodebuild \
		-scheme $(SCHEME) \
		-configuration Release \
		-destination generic/platform=iOS \
		-derivedDataPath $(BUILD_PATH) \
		build 2>&1 | tail -20
	@echo "$(GREEN)✅ Release build complete!$(NC)"

archive:
	@echo "$(BLUE)📦 Creating App Store archive...$(NC)"
	xcodebuild \
		-scheme $(SCHEME) \
		-configuration Release \
		-destination generic/platform=iOS \
		-archivePath $(BUILD_PATH)/$(PROJECT_NAME).xcarchive \
		-derivedDataPath $(BUILD_PATH) \
		archive 2>&1 | tail -20
	@echo "$(GREEN)✅ Archive created at: $(BUILD_PATH)/$(PROJECT_NAME).xcarchive$(NC)"

validate:
	@echo "$(BLUE)✔️  Validating archive...$(NC)"
	xcodebuild \
		-validateArchive \
		-archivePath $(BUILD_PATH)/$(PROJECT_NAME).xcarchive \
		-exportOptionsPlist ExportOptions.plist 2>&1 | tail -20
	@echo "$(GREEN)✅ Validation complete!$(NC)"

upload:
	@echo "$(BLUE)⬆️  Uploading to App Store Connect...$(NC)"
	@echo "Note: Manual upload required via Xcode Organizer"
	@echo "Open Xcode > Window > Organizer > Archives"
	@echo "Select your archive and click 'Distribute App'"

# ===== Utilities =====

device-list:
	@echo "$(BLUE)📱 Available simulators:$(NC)"
	xcrun simctl list devices available

erase-sim:
	@echo "$(BLUE)🗑️  Erasing simulator data...$(NC)"
	xcrun simctl erase $(DEVICE_SIMULATOR)
	@echo "$(GREEN)✅ Simulator erased!$(NC)"

open-xcode:
	@echo "$(BLUE)📂 Opening Xcode project...$(NC)"
	open $(PROJECT_NAME).xcodeproj

# ===== Info Targets =====

info:
	@echo "$(BLUE)Project Information:$(NC)"
	@echo "Project: $(PROJECT_NAME)"
	@echo "Scheme: $(SCHEME)"
	@echo "Configuration: $(CONFIGURATION)"
	@echo "Simulator: $(DEVICE_SIMULATOR)"
	@echo "Build Path: $(BUILD_PATH)"

.DEFAULT_GOAL := help
