//
//  NetworkCachedObject.m
//  BaseFrameWork
//
//  Created by Eleven on 2017/12/11.
//  Copyright © 2017年 Eleven. All rights reserved.
//

#import "NetworkCachedObject.h"
#import "NetWorkConfiguration.h"

@interface NetworkCachedObject()

@property (nonatomic, copy, readwrite) NSData *content;
@property (nonatomic, copy, readwrite) NSDate *lastUpdateTime;

@end

@implementation NetworkCachedObject

#pragma mark -- getters and setters
- (BOOL)isEmpty{
    return self.content == nil;
}

- (BOOL)isOutdated {
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.lastUpdateTime];
    return timeInterval > KSFCacheOutdateTimeSeconds;
}

- (void)setContent:(NSData *)content{
    _content = [content copy];
    self.lastUpdateTime = [NSDate dateWithTimeIntervalSinceNow:0];
}

#pragma mark -- life cycle
- (instancetype)initWithContent:(NSData *)content{
    self = [super init];
    if (self) {
        self.content = content;
    }
    return self;
}
#pragma mark -- public method
- (void)updateContent:(NSData *)content{
    self.content = content;
}



@end
