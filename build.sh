LIB=libyuv.a
STATICLIBS=`pwd`/universal
STATICLIBSTHIN=$STATICLIBS/thin
SDK=`xcrun --sdk iphoneos --show-sdk-version`

mkdir -p $STATICLIBSTHIN

xcodebuild -sdk iphoneos$SDK
xcodebuild -sdk iphonesimulator$SDK

lipo build/Release-iphoneos/$LIB -thin arm64 -output $STATICLIBSTHIN/libyuv_arm64.a
lipo build/Release-iphoneos/$LIB -thin armv7 -output $STATICLIBSTHIN/libyuv_armv7.a
lipo build/Release-iphoneos/$LIB -thin armv7s -output $STATICLIBSTHIN/libyuv_armv7s.a
lipo build/Release-iphonesimulator/$LIB -thin x86_64 -output $STATICLIBSTHIN/libyuv_x86_64.a
lipo build/Release-iphonesimulator/$LIB -thin i386 -output $STATICLIBSTHIN/libyuv_i386.a
lipo -create build/Release-iphoneos/$LIB $STATICLIBSTHIN/libyuv_x86_64.a $STATICLIBSTHIN/libyuv_i386.a -output $STATICLIBS/$LIB

rm -rf build

lipo -info $STATICLIBS/$LIB
