//
//  ELTabViewController.h
//  BaseFrameWork
//
//  Created by Eleven on 2017/12/19.
//  Copyright © 2017年 Eleven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELTabViewController : UITabBarController

+ (ELTabViewController *)shareTabbar;

- (void)showBadgeOnItemIndex:(int)index;

- (void)hideBadgeOnItemIndex:(int)index;

@end
