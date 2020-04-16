//
//  MImageTools.m
//  native_tools
//
//  Created by Apple on 2020/4/8.
//

#import "MImageTools.h"

@implementation MImageTools
+(NSString *)compressImageForPath:(NSString *)filePath toByte:(NSUInteger)maxLength{
    UIImage *inputImg = [UIImage imageWithContentsOfFile:filePath];
    if (!inputImg) {
        return nil;
    }
    UIImage *outputImg = [self compressImage:inputImg toByte:maxLength];
    if (!outputImg) {
        return nil;
    }
    NSData *imgData = UIImagePNGRepresentation(outputImg);
    if (!imgData) {
        imgData = UIImageJPEGRepresentation(outputImg, 0.9);
    }
    if (!imgData) {
        return nil;
    }
    NSString *orifilename = [filePath componentsSeparatedByString:@"/"].lastObject;
    NSString *suffix = orifilename ? [orifilename componentsSeparatedByString:@"."].lastObject : @"";
    NSString *date = [NSString stringWithFormat:@"%.0f",NSDate.date.timeIntervalSince1970];
    NSString *randomCode = [NSString stringWithFormat:@"%u",arc4random()%10000];
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *outputPath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@.%@",date,randomCode,suffix]];
    NSError *error;
    if([NSFileManager.defaultManager createFileAtPath:outputPath contents:imgData attributes:NULL]){
        return outputPath;
    };
    if([imgData writeToFile:outputPath options:NSDataWritingAtomic error:&error]){
        return outputPath;
    }else{
        return nil;
    };
}
+(UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength{
    // Compress by quality
       CGFloat compression = 1;
       NSData *data = UIImageJPEGRepresentation(image, compression);
       if (data.length < maxLength) return image;
       
       CGFloat max = 1;
       CGFloat min = 0;
       for (int i = 0; i < 6; ++i) {
           compression = (max + min) / 2;
           data = UIImageJPEGRepresentation(image, compression);
           if (data.length < maxLength * 0.9) {
               min = compression;
           } else if (data.length > maxLength) {
               max = compression;
           } else {
               break;
           }
       }
       UIImage *resultImage = [UIImage imageWithData:data];
       if (data.length < maxLength) return resultImage;
       
       // Compress by size
       NSUInteger lastDataLength = 0;
       while (data.length > maxLength && data.length != lastDataLength) {
           lastDataLength = data.length;
           CGFloat ratio = (CGFloat)maxLength / data.length;
           CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                    (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
           UIGraphicsBeginImageContext(size);
           [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
           resultImage = UIGraphicsGetImageFromCurrentImageContext();
           UIGraphicsEndImageContext();
           data = UIImageJPEGRepresentation(resultImage, compression);
       }
    return resultImage;
}

@end
