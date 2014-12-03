#!/bin/bash

if [[ "$TESTFLIGHT_API_TOKEN" == "FIXME" ]] \
    || [[ "$TESTFLIGHT_TEAM_TOKEN" == "FIXME" ]] \
    || [[ "$ITUNES_CONNECT_ACCOUNT" == "FIXME" ]] \
    || [[ "$ITUNES_CONNECT_PASSWORD" == "FIXME" ]]; then
    echo "Go back and re-read the instructions."
    exit 1
fi

if [[ "$TRAVIS_PULL_REQUEST" != "false" ]]; then
    echo "This is a pull request. No deployment will be done."
    exit 0
fi

# Make the (signed) build and IPA.
echo "========== Using shenzhen to make an IPA... =========="
if [ -n "$XC_WORKSPACE" ]; then
    bundle exec ipa build \
        --workspace "$XC_WORKSPACE" \
        --scheme "$XC_SCHEME" \
        --configuration "$XC_CONFIGURATION" \
        --sdk "iphoneos$SDK_VERSION"
else
    bundle exec ipa build \
        --project "$XC_PROJECT" \
        --scheme "$XC_SCHEME" \
        --configuration "$XC_CONFIGURATION" \
        --sdk "iphoneos$SDK_VERSION"
fi
if [ "$?" -ne 0 ]; then
    exit 1
fi

# If the environment has the TestFlight credentials needed, then try to upload to TestFlight.
if [ -n "$TESTFLIGHT_API_TOKEN" ] && [ -n "$TESTFLIGHT_TEAM_TOKEN" ]; then
    echo "========== Using shenzhen to upload the IPA to TestFlight... =========="
    bundle exec ipa distribute:testflight \
        --notes "This version was automatically uploaded by the continuous integration server."
    if [ "$?" -ne 0 ]; then
        echo
        echo "error: Failed to upload to TestFlight."
        exit 1
    fi
    echo
    echo "TestFlight upload finished!"
fi

# If the environment has the iTunes Connect credentials needed, then try to upload to iTunes Connect.
if [ -n "$ITUNES_CONNECT_ACCOUNT" ] && [ -n "$ITUNES_CONNECT_PASSWORD" ]; then
    echo "========== Using shenzhen to upload the IPA to iTunes Connect... =========="
    bundle exec ipa distribute:itunesconnect \
        --apple-id "$ITUNES_CONNECT_APPLE_ID" \
        --upload
    if [ "$?" -ne 0 ]; then
        echo
        echo "error: Failed to upload to iTunes Connect"
        exit 1
    fi
    echo
    echo "iTunes Connect upload finished!"
fi
