security create-keychain -p travis ios-build.keychain
security default-keychain -s ios-build.keychain
security unlock-keychain -p travis ios-build.keychain
security -v set-keychain-settings -lut 86400 ios-build.keychain
security import ./travis/*.cer -k ~/Library/Keychains/ios-build.keychain -T /usr/bin/codesign
if ${TRAVIS_SECURE_ENV_VARS}
then
    security import ./travis/*.p12 -k ~/Library/Keychains/ios-build.keychain -P $KEY_PASSWORD -T /usr/bin/codesign
fi
mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
cp ./travis/*.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles/
