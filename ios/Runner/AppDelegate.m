#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"

@import Firebase;

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [FIRApp configure];
     [GeneratedPluginRegistrant registerWithRegistry:self];
    return YES;
}

@end
