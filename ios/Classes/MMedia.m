//
//  MMedia.m
//  native_tools
//
//  Created by Apple on 2020/3/19.
//

#import "MMedia.h"
#import "ResponseResult.h"
#import "MImageTools.h"
@implementation MMedia
+(void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar{
    FlutterMethodChannel *method = [FlutterMethodChannel methodChannelWithName:@"mark.tools.media"
                                                               binaryMessenger:registrar.messenger];
    
    [registrar addMethodCallDelegate:[self new] channel:method];
}


-(void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result{
    if ([call.method isEqualToString:@"_transformMovToMp4"]) {
        [self _transformMovToMp4:call result:result];
    }else if([call.method isEqualToString:@"_imageCompress"]){
        [self _imageCompress:call result:result];
    }else{
        result(FlutterMethodNotImplemented);
    }
}

/// 转换mov --> mp4
-(void)_transformMovToMp4:(FlutterMethodCall *)call result:(FlutterResult)result{
    NSString *movPath = [call.arguments objectForKey:@"movPath"];
    NSString *savePath = [call.arguments objectForKey:@"savePath"];
    MMediaResponse* response = MMediaResponse.new;
    if (!movPath) {
        response.succeed =false;
        response.reason = @"文件不存在";
        response.code = MMovToMp4ResCodeFailed;
        result(response.mj_JSONObject);
        return;
    }
    response.filePath = movPath;
    
    NSURL *mp4Url = nil;
    if (!savePath || savePath.length == 0) {
        NSString *mp4Path = [NSString stringWithFormat:@"%d%d.mp4", (int)[[NSDate date] timeIntervalSince1970], arc4random() % 100000];
        
        mp4Url = [NSURL fileURLWithPath:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0]
                                         stringByAppendingPathComponent:mp4Path]];
    }else{
        mp4Url = [NSURL fileURLWithPath:savePath];
    }
    
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:movPath] options:nil];
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    if ([compatiblePresets containsObject:AVAssetExportPresetHighestQuality]) {
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]initWithAsset:avAsset
                                                                              presetName:AVAssetExportPresetHighestQuality];
        
        exportSession.outputURL = mp4Url;
        exportSession.shouldOptimizeForNetworkUse = YES;
        exportSession.outputFileType = AVFileTypeMPEG4;
        dispatch_semaphore_t wait = dispatch_semaphore_create(0l);
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            switch ([exportSession status]) {
                case AVAssetExportSessionStatusFailed: {
                    NSLog(@"failed, error:%@.", exportSession.error);
                    response.succeed = false;
                    response.reason = [NSString stringWithFormat:@"%@",exportSession.error];
                    response.code = MMovToMp4ResCodeFailed;
                } break;
                case AVAssetExportSessionStatusCancelled: {
                    NSLog(@"cancelled.");
                    response.succeed = false;
                    response.savePath = mp4Url.absoluteString;
                    response.code = MMovToMp4ResCodeFailed;
                } break;
                case AVAssetExportSessionStatusCompleted: {
                    NSLog(@"completed.");
                    response.succeed = true;
                    response.code = MMovToMp4ResCodeSucceed;
                } break;
                default: {
                    NSLog(@"others.");
                    response.succeed = false;
                    response.code = MMovToMp4ResCodeFailed;
                } break;
            }
            result(response.mj_JSONObject);
            dispatch_semaphore_signal(wait);
        }];
        long timeout = dispatch_semaphore_wait(wait, DISPATCH_TIME_FOREVER);
        if (timeout) {
            NSLog(@"timeout.");
            response.succeed = false;
            response.code = MMovToMp4ResCodeTimeout;
            response.reason = @"超时";
            result(response.mj_JSONObject);
        }
        if (wait) {
            //dispatch_release(wait);
            wait = nil;
        }
    }
    
    
}

/// 图片压缩
-(void)_imageCompress:(FlutterMethodCall *)call result:(FlutterResult)result{
    NSString *filePath = [call.arguments objectForKey:@"path"];
    NSUInteger *maxSize = [[call.arguments objectForKey:@"maxSize"] unsignedIntegerValue];
    MMediaResponse *res = MMediaResponse.new;
    NSString *outputPath = [MImageTools compressImageForPath:filePath toByte:maxSize];
    res.filePath = filePath;
    if (!outputPath) {
        res.succeed = false;
        res.reason = @"未导出文件到缓存目录";
    }else{
        res.succeed = true;
        res.savePath = outputPath;
    }
    result(res.mj_JSONObject);
}
@end
