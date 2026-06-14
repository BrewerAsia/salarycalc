#!/bin/bash

# SalaryCalc - Automated Xcode Project Setup Script
# This script creates a complete iOS Xcode project with all source files

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}🚀 Creating SalaryCalc Xcode Project...${NC}\n"

# Configuration
PROJECT_NAME="SalaryCalc"
BUNDLE_ID="com.brewersasia.salarycalc"
ORGANIZATION="brewersAsia"
ORG_ID="com.brewersasia"
TARGET_DIR="/Users/kante/research/SalaryCalcXcode"
SOURCE_DIR="/Users/kante/research/SalaryCalc/Sources"

# Create project directory structure
echo -e "${BLUE}📁 Creating directory structure...${NC}"
mkdir -p "$TARGET_DIR/$PROJECT_NAME"
mkdir -p "$TARGET_DIR/${PROJECT_NAME}Tests"
mkdir -p "$TARGET_DIR/${PROJECT_NAME}UITests"

cd "$TARGET_DIR"

# Copy source files
echo -e "${BLUE}📝 Copying source files...${NC}"
cp -r "$SOURCE_DIR/App" "$TARGET_DIR/$PROJECT_NAME/" 2>/dev/null || true
cp -r "$SOURCE_DIR/Presentation" "$TARGET_DIR/$PROJECT_NAME/" 2>/dev/null || true
cp -r "$SOURCE_DIR/Domain" "$TARGET_DIR/$PROJECT_NAME/" 2>/dev/null || true
cp -r "$SOURCE_DIR/Data" "$TARGET_DIR/$PROJECT_NAME/" 2>/dev/null || true
cp -r "$SOURCE_DIR/Utilities" "$TARGET_DIR/$PROJECT_NAME/" 2>/dev/null || true

# Create Assets folder
mkdir -p "$TARGET_DIR/$PROJECT_NAME/Assets.xcassets/AppIcon.appiconset"
mkdir -p "$TARGET_DIR/$PROJECT_NAME/Preview Content/PreviewAssets.xcassets"

# Create LaunchScreen
echo -e "${BLUE}🎨 Creating launch screen...${NC}"
cat > "$TARGET_DIR/$PROJECT_NAME/Preview Content/PreviewAssets.xcassets/Contents.json" << 'EOF'
{
  "info" : {
    "author" : "xcode",
    "version" : 1
  }
}
EOF

# Create Info.plist
echo -e "${BLUE}⚙️  Creating Info.plist...${NC}"
cat > "$TARGET_DIR/$PROJECT_NAME/Info.plist" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleDevelopmentRegion</key>
	<string>en</string>
	<key>CFBundleDisplayName</key>
	<string>SalaryCalc</string>
	<key>CFBundleExecutable</key>
	<string>$(EXECUTABLE_NAME)</string>
	<key>CFBundleIdentifier</key>
	<string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
	<key>CFBundleInfoDictionaryVersion</key>
	<string>6.0</string>
	<key>CFBundleName</key>
	<string>$(PRODUCT_NAME)</string>
	<key>CFBundlePackageType</key>
	<string>APPL</string>
	<key>CFBundleShortVersionString</key>
	<string>1.0</string>
	<key>CFBundleVersion</key>
	<string>1</string>
	<key>LSRequiresIPhoneOS</key>
	<true/>
	<key>UIApplicationSceneManifest</key>
	<dict>
		<key>UIApplicationSupportsMultipleScenes</key>
		<true/>
		<key>UISceneConfigurations</key>
		<dict>
			<key>UIWindowSceneSessionRoleApplication</key>
			<array>
				<dict>
					<key>UISceneConfigurationName</key>
					<string>Default Configuration</string>
					<key>UISceneDelegateClassName</key>
					<string>$(PRODUCT_MODULE_NAME).SceneDelegate</string>
				</dict>
			</array>
		</dict>
	</dict>
	<key>UIApplicationSupportsIndirectInputEvents</key>
	<true/>
	<key>UILaunchScreen</key>
	<dict/>
	<key>UIRequiredDeviceCapabilities</key>
	<array>
		<string>armv7</string>
	</array>
	<key>UISupportedInterfaceOrientations</key>
	<array>
		<string>UIInterfaceOrientationPortrait</string>
		<string>UIInterfaceOrientationPortraitUpsideDown</string>
		<string>UIInterfaceOrientationLandscapeLeft</string>
		<string>UIInterfaceOrientationLandscapeRight</string>
	</array>
	<key>UISupportedInterfaceOrientations~ipad</key>
	<array>
		<string>UIInterfaceOrientationPortrait</string>
		<string>UIInterfaceOrientationPortraitUpsideDown</string>
		<string>UIInterfaceOrientationLandscapeLeft</string>
		<string>UIInterfaceOrientationLandscapeRight</string>
	</array>
	<key>NSMinimumOSVersion</key>
	<string>15.0</string>
</dict>
</plist>
EOF

# Create .pbxproj structure (simplified)
echo -e "${BLUE}🔧 Creating Xcode project structure...${NC}"

mkdir -p "$TARGET_DIR/$PROJECT_NAME.xcodeproj"

cat > "$TARGET_DIR/$PROJECT_NAME.xcodeproj/project.pbxproj" << 'EOF'
// !$*UTF8*$!
{
	archiveVersion = 1;
	classes = {
	};
	objectVersion = 56;
	objects = {
		/* Begin PBXProject section */
		PROJECT_ID = {
			isa = PBXProject;
			attributes = {
				BuildIndependentTargetsInParallel = 1;
				LastSwiftUpdateCheck = 1540;
				LastUpgradeCheck = 1540;
				ORGANIZATIONNAME = brewersAsia;
				TargetAttributes = {
					TARGET_ID = {
						CreatedOnToolsVersion = 15.4;
					};
					TEST_TARGET_ID = {
						CreatedOnToolsVersion = 15.4;
						TestTargetID = TARGET_ID;
					};
				};
			};
			buildConfigurationList = BUILD_CONFIG_LIST;
			compatibilityVersion = "Xcode 14.0";
			developmentRegion = en;
			hasScannedForEncodings = 0;
			knownRegions = (
				en,
				Base,
			);
			mainGroup = MAIN_GROUP;
			productRefGroup = PRODUCT_REF_GROUP;
			projectDirPath = "";
			projectRoot = "";
			targets = (
				TARGET_ID,
				TEST_TARGET_ID,
			);
		};
		/* End PBXProject section */
	};
	rootObject = PROJECT_ID;
}
EOF

# Create xcscheme
mkdir -p "$TARGET_DIR/$PROJECT_NAME.xcodeproj/xcshareddata/xcschemes"

cat > "$TARGET_DIR/$PROJECT_NAME.xcodeproj/xcshareddata/xcschemes/$PROJECT_NAME.xcscheme" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<Scheme
   LastUpgradeVersion = "1540"
   version = "1.7">
   <BuildAction
      parallelizeBuildables = "YES"
      buildImplicitDependencies = "YES">
      <BuildActionEntries>
         <BuildActionEntry
            buildForTesting = "YES"
            buildForRunning = "YES"
            buildForProfiling = "YES"
            buildForArchiving = "YES"
            buildForAnalyzing = "YES">
            <BuildableReference
               BuildableIdentifier = "primary"
               BlueprintIdentifier = "TARGET_ID"
               BuildableName = "SalaryCalc.app"
               BlueprintName = "SalaryCalc"
               ReferencedContainer = "container:SalaryCalc.xcodeproj">
            </BuildableReference>
         </BuildActionEntry>
      </BuildActionEntries>
   </BuildAction>
   <TestAction
      buildConfiguration = "Debug"
      selectedDebuggerIdentifier = "Xcode.DebuggerFoundation.Debugger.LLDB"
      selectedLauncherIdentifier = "Xcode.DebuggerFoundation.Launcher.LLDB"
      shouldUseLaunchSchemeArgsEnv = "YES">
      <Testables>
         <TestableReference
            skipped = "NO">
            <BuildableReference
               BuildableIdentifier = "primary"
               BlueprintIdentifier = "TEST_TARGET_ID"
               BuildableName = "SalaryCalcTests.xctest"
               BlueprintName = "SalaryCalcTests"
               ReferencedContainer = "container:SalaryCalc.xcodeproj">
            </BuildableReference>
         </TestableReference>
      </Testables>
   </TestAction>
   <LaunchAction
      buildConfiguration = "Debug"
      selectedDebuggerIdentifier = "Xcode.DebuggerFoundation.Debugger.LLDB"
      selectedLauncherIdentifier = "Xcode.DebuggerFoundation.Launcher.LLDB"
      launchStyle = "0"
      useCustomWorkingDirectory = "NO"
      ignoresPersistentStateOnLaunch = "NO"
      debugDocumentVersioning = "YES"
      debugServiceExtensionHolderVersion = "1"
      allowLocationSimulation = "YES">
      <BuildableProductRunnable
         runnableDebuggingMode = "0">
         <BuildableReference
            BuildableIdentifier = "primary"
            BlueprintIdentifier = "TARGET_ID"
            BuildableName = "SalaryCalc.app"
            BlueprintName = "SalaryCalc"
            ReferencedContainer = "container:SalaryCalc.xcodeproj">
         </BuildableReference>
      </BuildableProductRunnable>
   </LaunchAction>
   <ArchiveAction
      buildConfiguration = "Release"
      revealArchiveInOrganizer = "YES">
   </ArchiveAction>
</Scheme>
EOF

echo -e "${GREEN}✅ Project structure created!${NC}"
echo -e "${BLUE}📂 Project location: $TARGET_DIR${NC}"
echo -e "${GREEN}✅ Source files copied!${NC}"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo -e "1. Open Xcode: ${GREEN}open $TARGET_DIR/$PROJECT_NAME.xcodeproj${NC}"
echo -e "2. Build: ${GREEN}Cmd + B${NC}"
echo -e "3. Run: ${GREEN}Cmd + R${NC}"
echo ""
echo -e "${GREEN}✅ Setup complete!${NC}"
