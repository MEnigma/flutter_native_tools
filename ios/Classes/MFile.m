//
//  MFile.m
//  native_tools
//
//  Created by Apple on 2020/4/9.
//

#import "MFile.h"
#import "MFileTools.h"
#import "ResponseResult.h"

@implementation MFile

+(void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar{
    FlutterMethodChannel *methodChannel = [FlutterMethodChannel methodChannelWithName:@"mark.tools.file" binaryMessenger:registrar.messenger];
    [registrar addMethodCallDelegate:[self new] channel:methodChannel];
}

-(void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result{
    if ([call.method isEqualToString:@"_copyFile"]) {
        [self _copyFile:call result:result];
    }else{
        result(FlutterMethodNotImplemented);
    }
}

/// 转存文件
-(void)_copyFile:(FlutterMethodCall *)call result:(FlutterResult)result{
    NSString *filePath = [call.arguments objectForKey:@"filePath"];
    NSString *savePath = [call.arguments objectForKey:@"savePath"];
    MFileOptionStatus res = [MFileTools copyFile:filePath toPath:savePath];
    MFileResponse *response = MFileResponse.new;
    response.succeed = res == MFileOptionStatusSucceed;
    response.code = res;
    response.savePath = savePath.copy;
    response.filePath = filePath.copy;
    switch (res) {
        case MFileOptionStatusSucceed:response.reason = @"复制成功";break;
        case MFileOptionStatusNoInputFile: response.reason = @"原文件不存在";break;
        case MFileOptionStatusFailure: response.reason=@"文件复制(保存)失败";break;
        case MFileOptionStatusNotWritable:response.reason = @"目标文件夹没有读写权限";break;
        default:break;
    }
    result(response.mj_JSONObject);
}


@end
