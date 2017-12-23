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
@interface MineViewController ()<ClickCurrentOprationDelegate, MoveViewsDelegate>

@property (nonatomic, strong) MoveImageView *moveImageView;
@property (nonatomic, strong) UIImageView *lucencyview;
@property (nonatomic, assign) NSInteger MoveViewTag;
@property (nonatomic, assign) CGRect rect;
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
    _MoveViewTag = 100;
    [self setUpView];
    // Do any additional setup after loading the view.
}

- (void)setUpView{
    BottomView *boView = [[BottomView alloc] initWithFrame:CGRectMake(0, UISCREEN_HEIGH - 100, UISCREEN_WIDTH, 100)];
    boView.delegate = self;
    boView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:boView];

    _moveImageView = [[MoveImageView alloc] initWithFrame:CGRectMake(UISCREEN_WIDTH/2 - 60, 200, 120, 116)];
    _rect = _moveImageView.frame;
    _moveImageView.tag = _MoveViewTag;
    _moveImageView.image = [UIImage imageNamed:@"MyWife"];
    _moveImageView.delegate = self;
    [self.view addSubview:_moveImageView];


}

#pragma  mark --- 创建浮层试图
- (void)creatSupernatantView{
    _lucencyview = [[UIImageView alloc] initWithFrame:self.view.frame];
    _lucencyview.backgroundColor = [UIColor redColor];
    _lucencyview.alpha = 0.4;
    _lucencyview.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeLucenyFromSuperView:)];
    [_lucencyview addGestureRecognizer:tapAction];
    [self.view addSubview:_lucencyview];
    NSLog(@"tianafa ");
}

- (void)creatNewMoveView{
    MoveImageView *newMoveView = [[MoveImageView alloc] initWithFrame:_rect];
    newMoveView.tag = _MoveViewTag;
    newMoveView.image = [UIImage imageNamed:@"MyWife"];
    newMoveView.delegate = self;
    [self.view addSubview:newMoveView];
}

- (void)tapGestureBeginAction:(CGRect)frame{
    _rect = frame;
    [self creatSupernatantView];
    [self creatNewMoveView];
}

-(void)panGestureEndFrame:(CGRect)frame{
    _rect = frame;
}

- (void)removeLucenyFromSuperView:(UITapGestureRecognizer *)tapAct{
    [_lucencyview removeFromSuperview];
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
            _MoveViewTag ++;
            MoveImageView *moveViews = [[MoveImageView alloc] initWithFrame:CGRectMake(_rect.origin.x + 5, _rect.origin.y + 5, _rect.size.width, _rect.size.height)];
            _rect = moveViews.frame;
            moveViews.tag = _MoveViewTag;
            moveViews.image = [UIImage imageNamed:@"MyWife"];
            moveViews.delegate = self;
            [self.view addSubview:moveViews];
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
