#!/bin/bash

set -xe

PROJECT=xxxxx.xcodeproj
SCHEME=xxxxx
TARGET=xxxxx
CONFIGURATION=Release
OBFUSCATION_SDK=iphonesimulator
SDK=iphoneos

rm -rf headers headers.obf build build.obf

if ! which ios-class-guard; then
	brew install ios-class-guard
fi

if ! which xcpretty; then
	gem install xcpretty
fi

if ! which class-dump; then
	brew install class-dump
fi

# Build project to fetch symbols
xcodebuild \
	-project "$PROJECT" \
	-scheme "$SCHEME" \
	-configuration "$CONFIGURATION" \
	-sdk "$OBFUSCATION_SDK" \
	clean build \
	OBJROOT=build/ \
	SYMROOT=build/ |\
	xcpretty -c

SYMBOLS_FILE="$PWD/symbols.h"

find . -name '*-Prefix.pch' -exec sed -i .bak '1i\
'"#import \"$SYMBOLS_FILE\"
" "{}" \;

class-dump -H -o headers build/$CONFIGURATION-$OBFUSCATION_SDK/$TARGET.app/$TARGET

DEVELOPER_DIR="$(xcode-select -p)"

SDK_DIR="$DEVELOPER_DIR/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk"
[[ ! -e "$SDK_DIR" ]] && SDK_DIR="$DEVELOPER_DIR/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator8.1.sdk"
[[ ! -e "$SDK_DIR" ]] && SDK_DIR="$DEVELOPER_DIR/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator8.0.sdk"
[[ ! -e "$SDK_DIR" ]] && SDK_DIR="$DEVELOPER_DIR/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator7.1.sdk"
[[ ! -e "$SDK_DIR" ]] && SDK_DIR="$DEVELOPER_DIR/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator7.0.sdk"
[[ ! -d "$SDK_DIR" ]] && echo "$SDK_DIR doesn't exist" && exit 1

echo "Using $SDK_DIR..."

# Obfuscate project
ios-class-guard \
	--sdk-root "$SDK_DIR" \
	-i 'machine*' \
	-i 'AL*' \
	-i 'MDApp*' \
	-i '*Flurry*' \
	-i '*TestFlight*' \
	-O symbols.h \
	build/$CONFIGURATION-$OBFUSCATION_SDK/$TARGET.app/$TARGET

# Build project to fetch symbols
xctool \
	-project "$PROJECT" \
	-scheme "$SCHEME" \
	-configuration "$CONFIGURATION" \
	-sdk "$SDK" \
	clean build \
	OBJROOT=build.obf/ \
	SYMROOT=build.obf/ |\
	xcpretty -c

class-dump -H -o headers.obf build.obf/$CONFIGURATION-$SDK/$TARGET.app/$TARGET
