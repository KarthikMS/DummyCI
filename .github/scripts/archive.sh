#!/bin/sh
set -eo pipefail

xcodebuild -project DummyCI.xcodeproj \
  -scheme DummyCI \
  -sdk iphoneos \
  -configuration Release \
  -archivePath $PWD/build/DummyCI.xcarchive \
  clean archive | xcpretty