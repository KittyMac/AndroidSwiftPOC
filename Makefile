# Set variables below
APPLE_SDK := /Volumes/EXTERNAL/AndroidSwift/XcodeDefault.xctoolchain
NDK := /Volumes/EXTERNAL/AndroidSwift/crystax-ndk-10.3.1
HOST_SYSTEM := darwin-x86

SRC_FILES := $(addprefix jni/, ArbiterBridge.c Arbiter.swift)

# Everything below this you shouldn't have to change

SWIFTC := $(APPLE_SDK)/usr/bin/swiftc
NDK_SYSROOT := $(NDK)/platforms/android-13/arch-arm
NDK_TOOLCHAIN := $(NDK)/toolchains/arm-linux-androideabi-4.9/prebuilt/$(HOST_SYSTEM)
LLC := $(NDK)/toolchains/llvm-3.7/prebuilt/$(HOST_SYSTEM)/bin/llc
LLCFLAGS := -mtriple=armv7-none-linux-androideabi -filetype=obj
CC := $(NDK_TOOLCHAIN)/bin/arm-linux-androideabi-gcc --sysroot=$(NDK_SYSROOT)
LD := $(NDK_TOOLCHAIN)/bin/arm-linux-androideabi-ld
LDFLAGS := -shared -L$(NDK_SYSROOT)/usr/lib -lc

OBJECTS := $(addsuffix .o,$(basename $(SRC_FILES)))
LL_IRS := $(patsubst %.swift,%.ll, $(filter %.swift,$(SRC_FILES)))

libs/armeabi-v7a/libarbiter.so: $(OBJECTS)
	@echo "LD      $@"
	@$(LD) $^ $(LDFLAGS) -o $@

.PHONY: clean
clean:
	rm -f $(OBJECTS) $(LL_IRS) libs/armeabi-v7a/libarbiter.so

%.o: %.c
	@echo "CC      $@"
	@$(CC) $(SFLAGS) $(CFLAGS) -c $< -o $@

%.ll: %.swift
	@echo "SWIFTC  $@"
	$(SWIFTC) -parse-as-library -target armv7-apple-ios9.0 -emit-ir $< | sed '/source_filename/d' > $@

%.o: %.ll
	@echo "LLC     $@"
	@$(LLC) $(LLCFLAGS) -relocation-model=pic $<

debug: libs/armeabi-v7a/libarbiter.so
	ant debug
	
install: 
	ant debug install
