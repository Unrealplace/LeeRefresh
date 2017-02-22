//
//  LeeRefreshLoadView.h
//  demoView
//
//  Created by mac on 17/2/10.
//  Copyright © 2017年 Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeeRefreshLoadView : UIView
/**
 设置线的宽度
 */
@property (nonatomic) CGFloat lineWidth;
/**
 设置不加载动画时候视图隐藏
 */
@property (nonatomic) BOOL hidesWhenStopped;

@property (nonatomic, strong) CAMediaTimingFunction *timingFunction;
/**
 判断是否在刷新状态
 */
@property (nonatomic, readonly) BOOL isAnimating;
/**
 设置动画一圈的时间 ，默认是1.5秒
 */
@property (nonatomic, readwrite) NSTimeInterval duration;
/**
 快捷的启动或停止动画
 
 @param animate bool 变量
 */
- (void)setAnimating:(BOOL)animate;
/**
 开始动画
 */
- (void)startAnimating;
/**
 停止动画
 */
- (void)stopAnimating;
@end
