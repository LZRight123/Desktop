CLASS_GUARD_OPTS_SDK="--sdk-root /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk"

CLASS_GUARD_OPTS="-i IgnoredSymbol -F !ExcludedClass"

SYMBOLS_FILE="$PWD/symbols.h"

Input_file="asmuserlogin"

cd 
/usr/local/bin/ios-class-guard \
    $CLASS_GUARD_OPTS_SDK \
    $CLASS_GUARD_OPTS \
    ${Input_file}\
    -O "$SYMBOLS_FILE" \
