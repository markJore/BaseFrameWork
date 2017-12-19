//
//  NetworkCachedObject.h
//  BaseFrameWork
//
//  Created by Eleven on 2017/12/11.
//  Copyright © 2017年 Eleven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkCachedObject : NSObject

@property (nonatomic, copy, readonly) NSData *content;
@property (nonatomic, copy, readonly) NSDate *lastUpdateTime;

@property (nonatomic, assign, readonly) BOOL isOutdated;
@property (nonatomic, assign, readonly) BOOL isEmpty;

- (instancetype)initWithContent:(NSData *)content;
- (void)updateContent:(NSData *)content;

@end
