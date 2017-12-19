//
//  BottomView.h
//  BaseFrameWork
//
//  Created by Eleven on 2017/12/18.
//  Copyright © 2017年 Eleven. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClickCurrentOprationDelegate

- (void)clickItemIndex:(NSInteger)index;

@end

@interface BottomView : UIView

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, assign) id<ClickCurrentOprationDelegate> delegate;

@end
