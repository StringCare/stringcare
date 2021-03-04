#import "StringcarePlugin.h"
#if __has_include(<stringcare/stringcare-Swift.h>)
#import <stringcare/stringcare-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "stringcare-Swift.h"
#endif

@implementation StringcarePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftStringcarePlugin registerWithRegistrar:registrar];
}
@end
