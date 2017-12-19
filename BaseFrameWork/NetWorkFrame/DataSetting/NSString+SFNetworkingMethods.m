//
//  NSString+SFNetworkingMethods.m
//  BaseFrameWork
//
//  Created by Eleven on 2017/12/11.
//  Copyright © 2017年 Eleven. All rights reserved.
//

#import "NSString+SFNetworkingMethods.h"
#include <CommonCrypto/CommonDigest.h>


@implementation NSString (SFNetworkingMethods)

- (NSString *)SF_md5{
    NSData *inputData = [self dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char outputData[CC_MD5_DIGEST_LENGTH];
    CC_MD5([inputData bytes], (unsigned int)[inputData length], outputData);

    NSMutableString *hashStr = [NSMutableString string];
    int i = 0;
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; ++i)
        [hashStr appendFormat:@"%02x",outputData[i]];
    return hashStr;
}

@end
