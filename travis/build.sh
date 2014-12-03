#!/bin/bash

# Set up default arguments for xctool
echo "[" > .xctool-args
if [ -n "$XC_PROJECT" ]; then echo '"-project", "'"$XC_PROJECT"'",' >> .xctool-args; fi
if [ -n "$XC_WORKSPACE" ]; then echo '"-workspace", "'"$XC_WORKSPACE"'",' >> .xctool-args; fi
echo '"-scheme", "'"$XC_SCHEME"'"' >> .xctool-args
echo "]" >> .xctool-args

# Unsigned build, suitable only for testing in the simulator.
xctool -sdk "iphonesimulator$SDK_VERSION" CONFIGURATION_BUILD_DIR='~/build/' test
if [ "$?" -ne 0 ]; then
    exit 1
fi
