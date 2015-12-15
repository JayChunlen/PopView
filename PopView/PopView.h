//
//  PopView.h
//  PopView
//
//  Created by chunlen on 15/12/15.
//  Copyright © 2015年 BDhub. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PopViewDelegate <NSObject>

// item点击代理方法
- (void)didSelectedIndex:(NSInteger)index;

@end


@interface PopView : UIView

@property(nonatomic, weak) id<PopViewDelegate> delegate;

/**
 *中心点
 */
@property (nonatomic, assign) CGPoint centerPoint;

/**
 *可点击item数组
 */
@property (nonatomic, strong) NSArray * items;


- (void)showInView:(UIView *)view;
@end
