//
//  MImageTools.h
//  native_tools
//
//  Created by Apple on 2020/4/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MImageTools : NSObject
+(NSString *)compressImageForPath:(NSString *)filePath toByte:(NSUInteger)maxLength;
+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength;

@end

NS_ASSUME_NONNULL_END
