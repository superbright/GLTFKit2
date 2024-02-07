#!/bin/sh

# set -x # Debug
set -e # Exit on error

moduleName="GLTFKit2"

outputDirectory="$(pwd)/$moduleName.xcframework"

archiveDirectoryName="archives"
archiveDirectory="$(pwd)/$archiveDirectoryName"
rm -rf $archiveDirectory
rm -rf $outputDirectory

xcodebuild archive -scheme $moduleName -archivePath "$archiveDirectory/iOS/$moduleName" \
                   -destination "generic/platform=iOS" SKIP_INSTALL=NO  BUILD_LIBRARY_FOR_DISTRIBUTION=YES
xcodebuild archive -scheme $moduleName -archivePath "$archiveDirectory/iOS_Simulator/$moduleName" \
                   -destination "generic/platform=iOS Simulator" SKIP_INSTALL=NO  BUILD_LIBRARY_FOR_DISTRIBUTION=YES
xcodebuild archive -scheme $moduleName -archivePath "$archiveDirectory/macOS/$moduleName" \
                   -destination "generic/platform=macOS" SKIP_INSTALL=NO  BUILD_LIBRARY_FOR_DISTRIBUTION=YES
xcodebuild archive -scheme $moduleName -archivePath "$archiveDirectory/macOS_Catalyst/$moduleName" \
                   -destination "generic/platform=macOS,variant=Mac Catalyst" SKIP_INSTALL=NO  BUILD_LIBRARY_FOR_DISTRIBUTION=YES
xcodebuild archive -scheme $moduleName -archivePath "$archiveDirectory/visionOS/$moduleName" \
                   -destination "generic/platform=visionOS" SKIP_INSTALL=NO  BUILD_LIBRARY_FOR_DISTRIBUTION=YES
xcodebuild archive -scheme $moduleName -archivePath "$archiveDirectory/visionOS_Simulator/$moduleName" \
                   -destination "generic/platform=visionOS Simulator" SKIP_INSTALL=NO  BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild -create-xcframework \
    -archive "$archiveDirectory/iOS/$moduleName.xcarchive" -framework $moduleName.framework \
    -archive "$archiveDirectory/iOS_Simulator/$moduleName.xcarchive" -framework $moduleName.framework \
    -archive "$archiveDirectory/macOS/$moduleName.xcarchive" -framework $moduleName.framework \
    -archive "$archiveDirectory/macOS_Catalyst/$moduleName.xcarchive" -framework $moduleName.framework \
    -archive "$archiveDirectory/visionOS/$moduleName.xcarchive" -framework $moduleName.framework \
    -archive "$archiveDirectory/visionOS_Simulator/$moduleName.xcarchive" -framework $moduleName.framework \
    -output $outputDirectory

rm -rf $archiveDirectory

zip -r $moduleName.xcframework.zip $moduleName.xcframework

swift package compute-checksum $moduleName.xcframework.zip
