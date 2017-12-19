//
//  NSDictionary+SFNetworkingMethods.h
//  BaseFrameWork
//
//  Created by Eleven on 2017/12/11.
//  Copyright © 2017年 Eleven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SFNetworkingMethods)

- (NSString *)SF_urlParamsStringSignature:(BOOL)isForSignature;
- (NSString *)SF_jsonString;
- (NSArray *)SF_transformedUrlParamsArraySignature:(BOOL)isForSignature;

@end
