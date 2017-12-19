//
//  BottomView.m
//  BaseFrameWork
//
//  Created by Eleven on 2017/12/18.
//  Copyright © 2017年 Eleven. All rights reserved.
//

#import "BottomView.h"
#import "UIButton+ImageTitleSpacing.h"

@implementation BottomView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self setUpUI];
    }
    return self;
}

- (void)initData{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"BottomView" ofType:@"plist"];
    NSDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    _items = [dic objectForKey:@"items"];
}

- (void)setUpUI{
    for (int i = 0; i < _items.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * (UISCREEN_WIDTH/_items.count), 1, (UISCREEN_WIDTH/_items.count), 100);
        [button setTitle:[[_items objectAtIndex:i] objectForKey:@"title"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.tag = 100 + i;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"tbiInfirmaryNormal"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:15];
        [self addSubview:button];
    }
}

- (void)clickButton:(UIButton *)sender{
    [self.delegate clickItemIndex:(sender.tag - 100)];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
