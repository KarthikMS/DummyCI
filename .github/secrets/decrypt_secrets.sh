#!/bin/sh
set -eo pipefail

PROFILE_NAME="Dummy_Wildcard_iOS_Distribution_Profile.mobileprovision"

# Decrypting files
gpg --verbose --batch --yes --decrypt --passphrase="$PROFILE_DECRYPTION_KEY" --output ./.github/secrets/${PROFILE_NAME} ./.github/secrets/${PROFILE_NAME}.gpg
gpg --verbose --batch --yes --decrypt --passphrase="$CERTIFICATE_DECRYPTION_KEY" --output ./.github/secrets/Certificates.p12 ./.github/secrets/Certificates.p12.gpg
echo "Finished decryption"


# Moving Profile to destination
mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
cp ./.github/secrets/${PROFILE_NAME} ~/Library/MobileDevice/Provisioning\ Profiles/${PROFILE_NAME}
echo "Moved profile"


# Adding certificate to keychain
KEYCHAIN=~/Library/Keychains/build.keychain
PASS_PHRASE="some"

security create-keychain -p $PASS_PHRASE build.keychain
security import ./.github/secrets/Certificates.p12 -t agg -k $KEYCHAIN -P $P12_PASSPHRASE -A
          
security list-keychains -s $KEYCHAIN
security default-keychain -s $KEYCHAIN
security unlock-keychain -p $PASS_PHRASE $KEYCHAIN
security set-key-partition-list -S apple-tool:,apple: -s -k $PASS_PHRASE $KEYCHAIN