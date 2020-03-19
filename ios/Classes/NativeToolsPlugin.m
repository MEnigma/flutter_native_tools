#import "NativeToolsPlugin.h"
#if __has_include(<native_tools/native_tools-Swift.h>)
#import <native_tools/native_tools-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816

#endif
#import "MScreen.h"
@implementation NativeToolsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    [MScreen registerWithRegistrar:registrar];
}
@end
