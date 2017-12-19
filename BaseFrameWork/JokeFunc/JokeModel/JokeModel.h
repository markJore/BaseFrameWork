//
//  JokeModel.h
//  BaseFrameWork
//
//  Created by Eleven on 2017/12/16.
//  Copyright © 2017年 Eleven. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JokeListModel, Result;

@interface JokeListModel: NSObject

@property (nonatomic, strong) NSArray<Result*> *data;

@end

@interface Result: NSObject

@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) UInt64 *unixtime;
@property (nonatomic, strong) NSDate *updatetime;

@end

@interface JokeModel : NSObject

@property (nonatomic, assign) NSInteger *error_code;
@property (nonatomic, copy) NSString *reason;
@property (nonatomic, strong) JokeListModel *result;

@end
