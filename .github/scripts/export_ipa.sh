#!/bin/sh
set -eo pipefail

xcodebuild -archivePath $PWD/build/DummyCI.xcarchive \
  -exportOptionsPlist ExportOptions.plist \
  -exportPath $PWD/build \
  -allowProvisioningUpdates \
  -exportArchive | xcpretty
