#import "LiquidSwipeFlutterPlugin.h"
#if __has_include(<liquid_swipe_flutter/liquid_swipe_flutter-Swift.h>)
#import <liquid_swipe_flutter/liquid_swipe_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "liquid_swipe_flutter-Swift.h"
#endif

@implementation LiquidSwipeFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLiquidSwipeFlutterPlugin registerWithRegistrar:registrar];
}
@end
