//
//  MFileTools.h
//  native_tools
//
//  Created by Apple on 2020/4/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MFileOptionStatus){
    MFileOptionStatusSucceed,
    MFileOptionStatusFailure,
    MFileOptionStatusNoInputFile,
    MFileOptionStatusNotWritable,
    MFileOptionStatusSavePathError,
};

@interface MFileTools : NSObject

/// 复制文件
+(MFileOptionStatus)copyFile:(NSString *)inputFile toPath:(NSString *)savePath;

@end

NS_ASSUME_NONNULL_END
