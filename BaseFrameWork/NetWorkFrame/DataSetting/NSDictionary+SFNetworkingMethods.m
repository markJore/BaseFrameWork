//
//  NSDictionary+SFNetworkingMethods.m
//  BaseFrameWork
//
//  Created by Eleven on 2017/12/11.
//  Copyright © 2017年 Eleven. All rights reserved.
//

#import "NSDictionary+SFNetworkingMethods.h"
#import "NSArray+SFNetworkingMethods.h"
@implementation NSDictionary (SFNetworkingMethods)

/** 字符串前面是没有问号的, 如果用于POST, 那就不用加问号, 如果用于GET, 就要加个问号 */
- (NSString *)SF_urlParamsStringSignature:(BOOL)isForSignature{
    NSArray *sortedArray = [self SF_transformedUrlParamsArraySignature:isForSignature];
    return [sortedArray SF_paramsString];
}
/** 字典变json*/
- (NSString *)SF_jsonString{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:NULL];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
/*** 转义参数*/
- (NSArray *)SF_transformedUrlParamsArraySignature:(BOOL)isForSignature{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (![obj isKindOfClass:[NSString class]]) {
            obj = [NSString stringWithFormat:@"%@", obj];
        }
        if (!isForSignature) {
            obj = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)obj, NULL, (CFStringRef)@"!*'();:@&;=+$,/?%#[]", kCFStringEncodingUTF8));
        }
        [result addObject:[NSString stringWithFormat:@"%@=%@", key, obj]];
    }];
    NSArray *sortedResult = [result sortedArrayUsingSelector:@selector(compare:)];
    return sortedResult;
}

@end

