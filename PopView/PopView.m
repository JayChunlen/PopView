//
//  PopView.m
//  PopView
//
//  Created by chunlen on 15/12/15.
//  Copyright © 2015年 BDhub. All rights reserved.
//

#import "PopView.h"

@interface PopView ()<UIGestureRecognizerDelegate>

@property (nonatomic, assign) CGFloat R;//半径

@property (nonatomic, assign) CGFloat angle;//角度
@end


@implementation PopView
{
    NSMutableArray *itemArr;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        itemArr = [NSMutableArray array];
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        self.alpha = 0;
//        _centerPoint = CGPointMake(100, 250);
        _R = 150.0f;
        _angle = 25.0f;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToHide:)];
        [self addGestureRecognizer:tap];
    }
    
    return self;
}
- (void)setCenterPoint:(CGPoint)centerPoint{
    _centerPoint = centerPoint;
//    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//    centerView.center = _centerPoint;
//    centerView.layer.cornerRadius = 20;
//    centerView.clipsToBounds = YES;
//    centerView.backgroundColor = [UIColor colorWithRed:0 green:0.5 blue:0.2 alpha:0.4];
//    
//    [self addSubview:centerView];

}
- (void)setItems:(NSArray *)items{
    _items = items;
    for (int i=0; i<_items.count; i++) {
        UIButton *button =[self getButtonWithPoint:_centerPoint atIndex:i];
        [itemArr addObject:button];
        [self addSubview:button];
    }
}

- (UIButton *)getButtonWithPoint:(CGPoint)point atIndex:(int)index{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    button.frame = CGRectMake(0, 0, 50, 50);
    button.backgroundColor = [UIColor redColor];
    button.layer.cornerRadius = 25;
    button.clipsToBounds = YES;
    if ([_items[index] isKindOfClass:[NSString class]]) {
        [button setTitle:_items[index] forState:UIControlStateNormal];
    }else{
        [button setTitle:_items[index][@"title"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:_items[index][@"image"]] forState:UIControlStateNormal];
    }
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.tag = 1000 + index;
    
    [button addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
    button.center = point;
    
    return button;
}
- (CGPoint)getCenterWithPoint:(CGPoint)point andAngle:(CGFloat)angle atIndex:(int)index{
    CGFloat x = point.x +_R *cos(angle * (3-index) * M_PI/180);
    CGFloat y = point.y -_R *sin(angle * (3-index) * M_PI/180);
    CGPoint center = CGPointMake(x, y);
    return center;
}

- (void)tapToHide:(UIGestureRecognizer *)gesture{
    [self hide];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isKindOfClass:[UIButton class]]) {
        return NO;
    }
    return YES;
}

- (void)showInView:(UIView *)view{
    [view addSubview:self];
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        for (int i = 0; i < itemArr.count; i++) {
            UIButton *btn = itemArr[i];
            CGPoint center = [self getCenterWithPoint:_centerPoint andAngle:_angle atIndex:i];
            [UIView animateWithDuration:0.2 *i delay:0.5 usingSpringWithDamping:0.5 initialSpringVelocity:0.3 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                btn.center = center;
            } completion:^(BOOL finished) {
                
            }];
        }
    }];
}

- (void)hide{
    for (int i = 0; i < itemArr.count; i++) {
        UIButton *btn = itemArr[i];
        [UIView animateWithDuration:0.1 *(i+1) animations:^{
            btn.center = _centerPoint;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                self.alpha = 0;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }];
    }
}

- (void)itemClick:(UIButton *)sender{
    NSLog(@"%ld %@",(long)sender.tag - 1000,_items[sender.tag - 1000]);
    
    if ([self.delegate respondsToSelector:@selector(didSelectedIndex:)]) {
        [self.delegate didSelectedIndex:sender.tag - 1000];
    }
    [self hide];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
