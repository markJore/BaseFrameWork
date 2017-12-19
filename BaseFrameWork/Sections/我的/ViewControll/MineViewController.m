//
//  MineViewController.m
//  BaseFrameWork
//
//  Created by Eleven on 2017/12/18.
//  Copyright © 2017年 Eleven. All rights reserved.
//

#import "MineViewController.h"
#import "BottomView.h"
#import "MoveImageView.h"
@interface MineViewController ()<ClickCurrentOprationDelegate>

@property (nonatomic, strong) MoveImageView *moveImageView;
@property (nonatomic, assign) BOOL flag;

@end

@implementation MineViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _flag = NO;
    [self setUpView];
    // Do any additional setup after loading the view.
}

- (void)setUpView{
    BottomView *boView = [[BottomView alloc] initWithFrame:CGRectMake(0, UISCREEN_HEIGH - 100, UISCREEN_WIDTH, 100)];
    boView.delegate = self;
    boView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:boView];

    _moveImageView = [[MoveImageView alloc] initWithFrame:CGRectMake(UISCREEN_WIDTH/2 - 60, 200, 120, 116)];
    _moveImageView.image = [UIImage imageNamed:@"MyWife"];
    [self.view addSubview:_moveImageView];

}

- (void)clickItemIndex:(NSInteger)index{
    switch (index) {
        case 0:{

        }
            break;
        case 1:{
            CGFloat scale = _flag ? 1.0 : -1.0;
            [UIView animateWithDuration:0.5 animations:^{
                _moveImageView.transform = CGAffineTransformMakeScale(scale, 1.0);
            }];
            _flag = !_flag;
        }
            break;
        case 2:{

        }
            break;
        case 3:{

        }
            break;
        case 4:{

        }
            break;
        case 5:{

        }
            break;
        default:{

        }
            break;
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
