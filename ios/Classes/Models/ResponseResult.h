//
//  ResponseResult.h
//  native_tools
//
//  Created by Apple on 2020/3/19.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MMovToMp4ResCode) {
  MMovToMp4ResCodeFailed,
  MMovToMp4ResCodeSucceed,
  MMovToMp4ResCodeTimeout,
};


@interface ResponseResult : NSObject
+(NSDictionary *)succeed;
+(NSDictionary *)succeedWithMessage:(NSString *)message;
+(NSDictionary *)errorWithoutMessage;
+(NSDictionary *)errmsgWithError:(NSString* )errmsg;

/// init function
-(instancetype)initWithOkey:(BOOL)isOkey message:(NSString *)message;

/// isokey
@property (assign) BOOL isOkey;

/// message for error or succeed
@property (strong, nonatomic) NSString *message;

-(NSDictionary *)toMap;



@end



@interface MMediaResponse : NSObject

@property (nonatomic, assign) bool succeed;
@property (nonatomic, copy) NSString * reason;
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSDictionary * result;

@property (nonatomic, copy) NSString * savePath;
@property (nonatomic, copy) NSString * filePath;
@property (nonatomic, strong) NSArray * selectedFiles;
@property (nonatomic, strong) NSArray * saveFiles;
@end

@interface MFileResponse : MMediaResponse

@end
NS_ASSUME_NONNULL_END
