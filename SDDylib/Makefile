# clang \
# -arch arm64 \
# -dynamiclib \
# -isysroot \
# /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk \
# dylib.m
# -o output.dylib

CC = clang
ARCH = arm64
SYSROOT = /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk
FRAMEWORK = -framework Foundation
VERSION = -compatibility_version 1 -current_version 1
TARGET = target.dylib
SOURCE = target.m

dylib: $(SOURCE)
	$(CC) -dynamiclib -arch $(ARCH) -isysroot $(SYSROOT) $(FRAMEWORK) $(SOURCE) -o $(TARGET) $(VERSION)

.PHONY: clean
clean:
	rm $(TARGET)