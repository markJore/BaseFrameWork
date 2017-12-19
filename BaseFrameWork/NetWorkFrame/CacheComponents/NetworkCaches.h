//
//  NetworkCaches.h
//  BaseFrameWork
//
//  Created by Eleven on 2017/12/11.
//  Copyright © 2017年 Eleven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkCachedObject.h"
@interface NetworkCaches : NSObject

+ (instancetype)sharedInstance;

- (NSString *)keyWithMethodName:(NSString *)methodName
                  requestParams:(NSDictionary *)requestParams;

- (NSData *)fetchCachedDataWithMethodName:(NSString *)methodName
                            requestParams:(NSDictionary *)requestParams;

- (void)saveCacheWithData:(NSData *)cachedData
               methodName:(NSString *)methodName
            requestParams:(NSDictionary *)requestParams;

- (void)deleteCacheWithMethodName:(NSString *)methodName
                    requestParams:(NSDictionary *)requestParams;

- (NSData *)fetchCachedDataWithKey:(NSString *)key;
- (void)saveCacheWithData:(NSData *)cachedData key:(NSString *)key;
- (void)deleteCacheWithKey:(NSString *)key;
- (void)clean;



@end
