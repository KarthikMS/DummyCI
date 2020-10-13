#!/bin/sh
set -eo pipefail

xcrun altool --upload-app \
  -t ios \
  -f $PWD/build/DummyCI.ipa \
  -u "$APPLEID_USERNAME" \
  -p "$APPLEID_PASSWORD" \
  --verbose