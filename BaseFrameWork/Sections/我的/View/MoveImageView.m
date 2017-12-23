//
//  MoveImageView.m
//  BaseFrameWork
//
//  Created by Eleven on 2017/12/19.
//  Copyright © 2017年 Eleven. All rights reserved.
//

#import "MoveImageView.h"

@implementation MoveImageView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        // 轻拍选中
        UITapGestureRecognizer *tapAct = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tapAct];
        // 移动
        UIPanGestureRecognizer *panAct = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        [self addGestureRecognizer:panAct];
        // 旋转
        UIRotationGestureRecognizer *rotaAct = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotaAction:)];
        [self addGestureRecognizer:rotaAct];
        // 缩放
        UIPinchGestureRecognizer *pinchAct = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)];
        [self addGestureRecognizer:pinchAct];
    }
    return self;
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    UIImageView *view = (UIImageView *)tap.view;
    CGRect frame = [view convertRect:view.bounds toView:view.superview];
    [self removeFromSuperview];
    [self.delegate panGestureEndFrame:frame];
    [self.delegate tapGestureBeginAction:frame];
}

- (void)panAction:(UIPanGestureRecognizer *)pan{
    UIImageView *view = (UIImageView *)pan.view;
    if (pan.state == UIGestureRecognizerStateBegan || pan.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [pan translationInView:view.superview];
        [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
        [pan setTranslation:CGPointZero inView:view.superview];
    }else if (pan.state == UIGestureRecognizerStateEnded){
        CGRect frame = [view convertRect:view.bounds toView:view.superview];
        [self.delegate panGestureEndFrame:frame];
    }
}

- (void)rotaAction:(UIRotationGestureRecognizer *)rota{
    UIImageView *view = (UIImageView *)rota.view;
    if (rota.state == UIGestureRecognizerStateBegan || rota.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformRotate(view.transform, rota.rotation);
        [rota setRotation:0];
    }
}

- (void)pinchAction:(UIPinchGestureRecognizer *)pin{
    UIImageView *view = (UIImageView *)pin.view;
    if (pin.state == UIGestureRecognizerStateBegan || pin.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformScale(view.transform, pin.scale, pin.scale);
        pin.scale = 1;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
