#!/bin/sh
set -eo pipefail

IOS_DISTRIBUTION_PROFILE_NAME="Dummy_Wildcard_iOS_Distribution_Profile.mobileprovision"
MACOS_DEVELOPMENT_PROFILE="DummyCI_Mac_Development_Profile.provisionprofile"

# Decrypting files
gpg --verbose --batch --yes --decrypt --passphrase="$PROFILE_DECRYPTION_KEY" --output ./.github/secrets/${IOS_DISTRIBUTION_PROFILE_NAME} ./.github/secrets/${IOS_DISTRIBUTION_PROFILE_NAME}.gpg
gpg --verbose --batch --yes --decrypt --passphrase="$CERTIFICATE_DECRYPTION_KEY" --output ./.github/secrets/Certificates.p12 ./.github/secrets/Certificates.p12.gpg
gpg --verbose --batch --yes --decrypt --passphrase="$CERTIFICATE_DECRYPTION_KEY" --output ./.github/secrets/${MACOS_DEVELOPMENT_PROFILE} ./.github/secrets/${MACOS_DEVELOPMENT_PROFILE}.gpg
gpg --verbose --batch --yes --decrypt --passphrase="$CERTIFICATE_DECRYPTION_KEY" --output ./.github/secrets/MacCertificates.p12 ./.github/secrets/MacCertificates.p12.gpg
echo "Finished decryption"

# Moving Profile to destination
mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
cp ./.github/secrets/${IOS_DISTRIBUTION_PROFILE_NAME} ~/Library/MobileDevice/Provisioning\ Profiles/${IOS_DISTRIBUTION_PROFILE_NAME}
cp ./.github/secrets/${MACOS_DEVELOPMENT_PROFILE} ~/Library/MobileDevice/Provisioning\ Profiles/${MACOS_DEVELOPMENT_PROFILE}
echo "Moved profile"


# Adding certificate to keychain
KEYCHAIN=~/Library/Keychains/build.keychain
PASS_PHRASE="some"

security create-keychain -p $PASS_PHRASE build.keychain
security import ./.github/secrets/Certificates.p12 -t agg -k $KEYCHAIN -P $P12_PASSPHRASE -A
security import ./.github/secrets/MacCertificates.p12 -t agg -k $KEYCHAIN -P $MAC_DEV_P12_PASSPHRASE -A
          
security list-keychains -s $KEYCHAIN
security default-keychain -s $KEYCHAIN
security unlock-keychain -p $PASS_PHRASE $KEYCHAIN
security set-key-partition-list -S apple-tool:,apple: -s -k $PASS_PHRASE $KEYCHAIN