//
//  MScreen.m
//  native_tools
//
//  Created by Apple on 2020/3/19.
//

#import "MScreen.h"
#import "ResponseResult.h"
@implementation MScreen

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result{
    if([call.method isEqualToString:@"keepOn"]){
        [self controlScreenOnFromCall:call result:result];
    }
}

+ (void)registerWithRegistrar:(nonnull NSObject<FlutterPluginRegistrar> *)registrar {
    FlutterMethodChannel *channel = [FlutterMethodChannel.alloc initWithName:@"mark.screen" binaryMessenger:registrar.messenger codec:[FlutterStandardMethodCodec new]];
    [registrar addMethodCallDelegate:[self new] channel:channel];
}


#pragma mark- MAIN FUNCTION
/// Controll screen able to going into sleep mode
-(void)controlScreenOnFromCall:(FlutterMethodCall *)call result:(FlutterResult)result{
    NSDictionary *param = call.arguments;
    BOOL toOn = param == nil ? false : param[@"on"];
    @try {
        [UIApplication.sharedApplication setIdleTimerDisabled:toOn];
        result(ResponseResult.succeed);
    } @catch (NSException *exception) {
        result([ResponseResult errmsgWithError:[NSString stringWithFormat:@"%@",exception]]);
    } @finally {}
}

@end
