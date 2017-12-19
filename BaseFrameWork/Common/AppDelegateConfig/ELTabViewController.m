//
//  ELTabViewController.m
//  BaseFrameWork
//
//  Created by Eleven on 2017/12/19.
//  Copyright © 2017年 Eleven. All rights reserved.
//

#import "ELTabViewController.h"
#import "ELHomePageViewController.h"
#import "ELFoundViewController.h"
#import "BestNewViewController.h"
#import "MineViewController.h"

@interface ELTabViewController ()<UITabBarControllerDelegate>
@property (nonatomic, strong) NSMutableArray *navControls;

@end

@implementation ELTabViewController
+ (ELTabViewController *)shareTabbar{

    static ELTabViewController *shareTabbarControl = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareTabbarControl = [[ELTabViewController alloc] init];
        shareTabbarControl.delegate = shareTabbarControl;
    });
    return shareTabbarControl;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
    // Do any additional setup after loading the view.
}
- (void)configure{
    self.navControls = [NSMutableArray array];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ELTabbar" ofType:@"plist"];
    NSDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSArray *viewControls = [dic objectForKey:@"TabbarList"];
    for (int i = 0; i < viewControls.count; i++) {
        NSDictionary *dics = [viewControls objectAtIndex:i];
        UIViewController *vc = [[NSClassFromString(dics[@"viewcontrol"]) alloc] init];
        UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:vc];
        vc.tabBarItem.title = dics[@"title"];
        vc.tabBarItem.image = [[UIImage imageNamed:dics[@"image"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:dics[@"SelectedImage"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self.navControls addObject:navc];
    }
    self.viewControllers = self.navControls;
}

#pragma mark -- UITabbarControlDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{

}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    return YES;
}

- (void)showBadgeOnItemIndex:(int)index{

    UIView *badgeView = [[UIView alloc] init];

    badgeView.tag = 888 + index;

    badgeView.layer.cornerRadius = 5;

    badgeView.backgroundColor = [UIColor redColor];

    CGRect tabFrame = self.tabBar.frame;

    float percentX = (index + 0.6) / self.navControls.count;

    CGFloat x = ceilf(percentX * tabFrame.size.width);

    CGFloat y = ceilf(0.1 * tabFrame.size.height);

    badgeView.frame = CGRectMake(x, y, 10, 10);

    [self.tabBar addSubview:badgeView];

}

- (void)hideBadgeOnItemIndex:(int)index{
    [self removeBadgeOnItemIndex:index];
}

- (void)removeBadgeOnItemIndex:(int)index{
    for (UIView *subView in self.tabBar.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
