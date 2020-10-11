set -eo pipefail

PROFILE_NAME="ca97b3a8-94d4-466e-837c-5029c83aea58.mobileprovision"

gpg --quiet --batch --yes --decrypt --passphrase="$PROFILE_DECRYPTION_KEY" --output ./.github/secrets/${PROFILE_NAME} ./.github/secrets/${PROFILE_NAME}.gpg
gpg --quiet --batch --yes --decrypt --passphrase="$CERTIFICATE_DECRYPTION_KEY" --output ./.github/secrets/Certificates.p12 ./.github/secrets/Certificates.p12.gpg

mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles

cp ./.github/secrets/${PROFILE_NAME} ~/Library/MobileDevice/Provisioning\ Profiles/${PROFILE_NAME}


security create-keychain -p "" build.keychain
security import ./.github/secrets/Certificates.p12 -t agg -k ~/Library/Keychains/build.keychain -P "" -A

security list-keychains -s ~/Library/Keychains/build.keychain
security default-keychain -s ~/Library/Keychains/build.keychain
security unlock-keychain -p "" ~/Library/Keychains/build.keychain

security set-key-partition-list -S apple-tool:,apple: -s -k "" ~/Library/Keychains/build.keychain