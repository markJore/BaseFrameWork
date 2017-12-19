//
//  NetworkCaches.m
//  BaseFrameWork
//
//  Created by Eleven on 2017/12/11.
//  Copyright © 2017年 Eleven. All rights reserved.
//

#import "NetworkCaches.h"
#import "NSDictionary+SFNetworkingMethods.h"
#import "NetWorkConfiguration.h"

@interface  NetworkCaches()

@property (nonatomic, strong) NSCache *cache;

@end

@implementation NetworkCaches
#pragma mark -- getter and setter
#pragma mark -- life cyccle
+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static NetworkCaches *shareInstance;
    dispatch_once(&onceToken, ^{
        shareInstance = [[NetworkCaches alloc] init];
    });
    return shareInstance;
}

- (NSData *)fetchCachedDataWithKey:(NSString *)key{
    NetworkCachedObject *cachedObject = [self.cache objectForKey:key];
    if (cachedObject.isOutdated || cachedObject.isEmpty) {
        return nil;
    }else{
        return cachedObject.content;
    }
}

- (NSData *)fetchCachedDataWithMethodName:(NSString *)methodName requestParams:(NSDictionary *)requestParams{
    return [self fetchCachedDataWithKey:[self keyWithMethodName:methodName requestParams:requestParams]];
}

- (void)saveCacheWithData:(NSData *)cachedData key:(NSString *)key{
    NetworkCachedObject *cacheObject = [self.cache objectForKey:key];
    if (cacheObject == nil) {
        cacheObject = [[NetworkCachedObject alloc] init];
    }
    [cacheObject updateContent:cachedData];
    [self.cache setObject:cacheObject forKey:key];
}

- (void)saveCacheWithData:(NSData *)cachedData methodName:(NSString *)methodName requestParams:(NSDictionary *)requestParams{
    [self saveCacheWithData:cachedData key:[self keyWithMethodName:methodName requestParams:requestParams]];
}

- (void)deleteCacheWithKey:(NSString *)key{
    [self.cache removeObjectForKey:key];
}

- (void)deleteCacheWithMethodName:(NSString *)methodName requestParams:(NSDictionary *)requestParams{
    [self deleteCacheWithKey:[self keyWithMethodName:methodName requestParams:requestParams]];
}

- (void)clean{
    [self.cache removeAllObjects];
}

- (NSString *)keyWithMethodName:(NSString *)methodName requestParams:(NSDictionary *)requestParams{
    return [NSString stringWithFormat:@"%@%@", methodName, [requestParams SF_urlParamsStringSignature:NO]];
}

@end
