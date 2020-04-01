//
//  ResponseResult.m
//  native_tools
//
//  Created by Apple on 2020/3/19.
//

#import "ResponseResult.h"

@implementation ResponseResult
+(NSDictionary *)succeed{
    return [ResponseResult succeedWithMessage:@""];
}
+(NSDictionary *)succeedWithMessage:(NSString *)message{
    return [ResponseResult.new initWithOkey:true message:message].toMap;
}
+(NSDictionary *)errorWithoutMessage{
    return [ResponseResult errmsgWithError:@""];
}
+(NSDictionary *)errmsgWithError:(NSString* )errmsg{
    return [ResponseResult.alloc initWithOkey:false message:errmsg].toMap;
    
}

-(instancetype)initWithOkey:(BOOL)isOkey message:(NSString *)message{
    if(self = [super init]){
        self.isOkey = isOkey;
        self.message = message;
    }
    return self;
}
-(NSDictionary *)toMap{
    NSDictionary *result = @{@"isOkey":[NSNumber numberWithBool:_message],@"message":_message==nil?@"":_message};
    return result;
}
@end
