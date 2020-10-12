#!/bin/sh
set -eo pipefail

xcodebuild -project DummyCI.xcodeproj \
  -scheme DummyCI \
  -destination platform=iOS\ Simulator,OS=13.7,name=iPhone\ 11 \
  clean test | xcpretty