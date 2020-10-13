#!/bin/sh
set -eo pipefail

xcodebuild -project DummyCI.xcodeproj \
  -scheme DummyCI \
  -destination $DESTINATION \
  clean test | xcpretty