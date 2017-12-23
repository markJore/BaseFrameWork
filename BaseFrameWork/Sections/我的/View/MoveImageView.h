//
//  MoveImageView.h
//  BaseFrameWork
//
//  Created by Eleven on 2017/12/19.
//  Copyright © 2017年 Eleven. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MoveViewsDelegate

- (void)panGestureEndFrame:(CGRect)frame;

- (void)tapGestureBeginAction:(CGRect)frame;

@end


@interface MoveImageView : UIImageView

@property (nonatomic, assign) id<MoveViewsDelegate> delegate;


@end
