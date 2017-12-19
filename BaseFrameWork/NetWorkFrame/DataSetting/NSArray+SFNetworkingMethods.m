//
//  NSArray+SFNetworkingMethods.m
//  BaseFrameWork
//
//  Created by Eleven on 2017/12/11.
//  Copyright © 2017年 Eleven. All rights reserved.
//

#import "NSArray+SFNetworkingMethods.h"

@implementation NSArray (SFNetworkingMethods)

/** 字母排序之后形成的参数字符串*/
- (NSString *)SF_paramsString{
    NSMutableString *paramString = [[NSMutableString alloc] init];
    NSArray *sortedParams = [self sortedArrayUsingSelector:@selector(compare:)];
    [sortedParams enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([paramString length] == 0) {
            [paramString appendFormat:@"%@", obj];
        }else{
            [paramString appendFormat:@"%@", obj];
        }
    }];
    return paramString;
}

/**数组变json*/
- (NSString *)SF_jsonString{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:NULL];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
