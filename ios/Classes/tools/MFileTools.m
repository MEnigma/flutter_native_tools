//
//  MFileTools.m
//  native_tools
//
//  Created by Apple on 2020/4/9.
//

#import "MFileTools.h"

@implementation MFileTools
+(MFileOptionStatus)copyFile:(NSString *)inputFile toPath:(NSString *)savePath{
    if (![NSFileManager.defaultManager fileExistsAtPath:inputFile]) {
        return MFileOptionStatusNoInputFile;
    }
    if (![NSFileManager.defaultManager fileExistsAtPath:savePath]) {
        NSString *saveFileName = [[savePath componentsSeparatedByString:@"/"] lastObject];
        if (!saveFileName) {
            return MFileOptionStatusSavePathError;
        }
        NSString *saveFileDir = [savePath stringByReplacingOccurrencesOfString:saveFileName withString:@""];
        NSError *err;
        [NSFileManager.defaultManager createDirectoryAtPath:saveFileDir withIntermediateDirectories:true attributes:NULL error:&err];
        NSLog(@"--- 创建文件夹 [%@] %@ ---",err?err.description : @"成功",saveFileDir);
    }
    NSData *data = [NSData dataWithContentsOfFile:inputFile];
    if (!data) {
        return MFileOptionStatusNoInputFile;
    }
//    if(![NSFileManager.defaultManager isWritableFileAtPath:savePath]){
//        return MFileOptionStatusNotWritable;
//    }
    
    if([NSFileManager.defaultManager createFileAtPath:savePath contents:data attributes:nil]){
        return MFileOptionStatusSucceed;
    }else{
        return MFileOptionStatusFailure;
    };
}
@end
