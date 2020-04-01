//
//  ResponseResult.h
//  native_tools
//
//  Created by Apple on 2020/3/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

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

NS_ASSUME_NONNULL_END
