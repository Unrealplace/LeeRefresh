//
//  LeeRefreshHeader.m
//  LeeRefreshDemo
//
//  Created by LiYang on 17/2/5.
//  Copyright © 2017年 LiYang. All rights reserved.
//

#import "LeeRefreshHeader.h"
#import "UIScrollView+LeeRefresh.h"
#import "CAShapeLayer+LeeRefresh.h"
#import "LeeRefreshHeader+Animation.h"
#import "UIView+LeeRefresh.h"
#import  <objc/message.h>

#define     topPointColor       [UIColor colorWithRed:90 / 255.0 green:200 / 255.0 blue:200 / 255.0 alpha:1.0].CGColor
#define     leftPointColor      [UIColor colorWithRed:250 / 255.0 green:85 / 255.0 blue:78 / 255.0 alpha:1.0].CGColor
#define     bottomPointColor    [UIColor colorWithRed:92 / 255.0 green:201 / 255.0 blue:105 / 255.0 alpha:1.0].CGColor
#define     rightPointColor     [UIColor colorWithRed:253 / 255.0 green:175 / 255.0 blue:75 / 255.0 alpha:1.0].CGColor

#define LeeRefreshMsgSend(...) ((void (*)(void *, SEL, UIView *))objc_msgSend)(__VA_ARGS__)
#define LeeRefreshMsgTarget(target) (__bridge void *)(target)

const CGFloat LeeRefreshHeight      = 35.0;
const CGFloat LeeRefreshPointRadius = 5.0;
const CGFloat LeeRefreshPullLen     = 55.0;

@interface LeeRefreshHeader()

@property (nonatomic, weak) UIScrollView * scrollView;
@property (nonatomic, assign) BOOL animating;

/**
 刷新的四个点点
 */
@property (nonatomic, strong) CAShapeLayer * TopPointLayer;
@property (nonatomic, strong) CAShapeLayer * BottomPointLayer;
@property (nonatomic, strong) CAShapeLayer * LeftPointLayer;
@property (nonatomic, strong) CAShapeLayer * rightPointLayer;
@property (nonatomic, strong) CAShapeLayer * lineLayer;

@end
@implementation LeeRefreshHeader

-(instancetype)init{
    
    if (self = [super initWithFrame:CGRectMake(0, 0, LeeRefreshHeight, LeeRefreshHeight)]) {
        [self initTheLayers];
    }
    
    return self;
    
}

/**
 初始化
 */
-(void)initTheLayers{
    
    // 计算小正方形的中点 以及 小圆点的 大小 5.0
    CGFloat centerLine = LeeRefreshHeight / 2;
    CGFloat radius     = LeeRefreshPointRadius;
    
    
    //顶部的点点坐标
    CGPoint topPoint   = CGPointMake(centerLine, radius);
    self.TopPointLayer = [CAShapeLayer layerWithPoint:topPoint color:topPointColor];
    self.TopPointLayer.hidden  = NO;
    self.TopPointLayer.opacity = 0.f;
    [self.layer addSublayer:self.TopPointLayer];
    
    //左边点点的坐标
    CGPoint leftPoint   = CGPointMake(radius, centerLine);
    self.LeftPointLayer = [CAShapeLayer layerWithPoint:leftPoint color:leftPointColor];
    [self.layer addSublayer:self.LeftPointLayer];
    
    //底部点点的坐标
    CGPoint bottomPoint   = CGPointMake(centerLine, LeeRefreshHeight - radius);
    self.BottomPointLayer = [CAShapeLayer layerWithPoint:bottomPoint color:bottomPointColor];
    [self.layer addSublayer:self.BottomPointLayer];
    
    
    //右侧点点的坐标
    CGPoint rightPoint   = CGPointMake(LeeRefreshHeight - radius, centerLine);
    self.rightPointLayer = [CAShapeLayer layerWithPoint:rightPoint color:rightPointColor];
    [self.layer addSublayer:self.rightPointLayer];
    
    //
    self.lineLayer = [CAShapeLayer layer];
    //刚好是小点点的直径大小
    self.lineLayer.lineWidth   = LeeRefreshPointRadius * 2;
    self.lineLayer.lineCap     = kCALineCapRound;
    self.lineLayer.lineJoin    = kCALineJoinRound;
    self.lineLayer.fillColor   = topPointColor;
    self.lineLayer.strokeColor = topPointColor;
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:topPoint];
    [path addLineToPoint:leftPoint];
    [path moveToPoint:leftPoint];
    [path addLineToPoint:bottomPoint];
    [path moveToPoint:bottomPoint];
    [path addLineToPoint:rightPoint];
    [path moveToPoint:rightPoint];
    [path addLineToPoint:topPoint];
    self.lineLayer.path = path.CGPath;
    self.lineLayer.strokeStart = 0.f;
    self.lineLayer.strokeEnd = 0.f;
    [self.layer insertSublayer:self.lineLayer above:self.TopPointLayer];
    
}

/**
 开始刷新动画
 */
-(void)startRefreshing{
    
    if ([self.target respondsToSelector:self.action]) {
        LeeRefreshMsgSend(LeeRefreshMsgTarget(self.target), self.action, self);
        [self startAni];
        
    }
}

/**
 结束刷新动画
 */
-(void)endRefreshing{
    
    [self stopAni];
    
}

-(void)willMoveToSuperview:(UIView *)newSuperview{
    
    [super willMoveToSuperview:newSuperview];
    if (newSuperview) {
        self.scrollView = (UIScrollView *)newSuperview;
        self.center = CGPointMake(self.scrollView.centerX, self.centerY);
        [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }else {
        [self.superview removeObserver:self forKeyPath:@"contentOffset"];
    }
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        self.progress = - self.scrollView.contentOffset.y;
    }
}

#pragma mark - Property 重要的计算
- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    //如果不是正在刷新，则渐变动画
    if (!self.animating) {
        if (progress >= LeeRefreshPullLen) {
            self.y = - (LeeRefreshPullLen - (LeeRefreshPullLen - LeeRefreshHeight) / 2.0f);
        }else {
            if (progress <= self.h) {
                self.y = - progress;
            }else {
                self.y = - (self.h + (progress - self.h) / 2.0f);
            }
        }
        [self setLineLayerStrokeWithProgress:progress];
        
    }
    //如果到达临界点，则执行刷新动画
    if (progress >= LeeRefreshPullLen && !self.animating && !self.scrollView.dragging) {
        [self startRefreshing];
    }
    
}

#pragma mark - 设置小点点的中点算法 重要的计算
- (void)setLineLayerStrokeWithProgress:(CGFloat)progress {
    float startProgress = 0.f;
    float endProgress   = 0.f;
    
    //隐藏
    if (progress < 0) {
        self.TopPointLayer.opacity = 0.f;
        [self adjustPointStateWithIndex:0];
    }
    else if (progress >= 0 && progress < (LeeRefreshPullLen - 40)) {
        self.TopPointLayer.opacity = progress / 20;
        [self adjustPointStateWithIndex:0];
    }
    else if (progress >= (LeeRefreshPullLen - 40) && progress < LeeRefreshPullLen) {
        self.TopPointLayer.opacity = 1.0;
        //大阶段 0 ~ 3
        NSInteger stage = (progress - (LeeRefreshPullLen - 40)) / 10;
        //大阶段的前半段
        CGFloat subProgress = (progress - (LeeRefreshPullLen - 40)) - (stage * 10);
        if (subProgress >= 0 && subProgress <= 5) {
            [self adjustPointStateWithIndex:stage * 2];
            startProgress = stage / 4.0;
            endProgress = stage / 4.0 + subProgress / 40.0 * 2;
        }
        //大阶段的后半段
        if (subProgress > 5 && subProgress < 10) {
            [self adjustPointStateWithIndex:stage * 2 + 1];
            startProgress = stage / 4.0 + (subProgress - 5) / 40.0 * 2;
            if (startProgress < (stage + 1) / 4.0 - 0.1) {
                startProgress = (stage + 1) / 4.0 - 0.1;
            }
            endProgress = (stage + 1) / 4.0;
        }
    }
    else {
        self.TopPointLayer.opacity = 1.0;
        [self adjustPointStateWithIndex:NSIntegerMax];
        startProgress = 1.0;
        endProgress = 1.0;
    }
    self.lineLayer.strokeStart = startProgress;
    self.lineLayer.strokeEnd = endProgress;
}

- (void)adjustPointStateWithIndex:(NSInteger)index { //index : 小阶段： 0 ~ 7
    
    self.LeftPointLayer.hidden = index > 1 ? NO : YES;
    self.BottomPointLayer.hidden = index > 3 ? NO : YES;
    self.rightPointLayer.hidden = index > 5 ? NO : YES;
    self.lineLayer.strokeColor = index > 5 ? rightPointColor : index > 3 ? bottomPointColor : index > 1 ? leftPointColor : topPointColor;
}

/**
 开始动画
 */
-(void)startAni{
    
    self.animating = YES;
    [UIView animateWithDuration:0.4 animations:^{
        UIEdgeInsets inset = self.scrollView.contentInset;
        inset.top = LeeRefreshPullLen;
        self.scrollView.contentInset = inset;
    }];
    [self addPointLayerAnimations];
    
}

/**
 结束动画
 */
-(void)stopAni{
    
    [UIView animateWithDuration:0.4 animations:^{
        UIEdgeInsets inset = self.scrollView.contentInset;
        inset.top = 0.f;
        self.scrollView.contentInset = inset;
        
    } completion:^(BOOL finished) {
        [self removeAnimations];
    }];
}

/**
 给小点点添加动画
 */
-(void)addPointLayerAnimations{
    
    //给四个小点点添加动画 以及 背景旋转 效果
    [self addTranslationAniToLayer:self.TopPointLayer xValue:0 yValue:LeeRefreshPointRadius];
    [self addTranslationAniToLayer:self.LeftPointLayer xValue:LeeRefreshPointRadius yValue:0];
    [self addTranslationAniToLayer:self.BottomPointLayer xValue:0 yValue:-LeeRefreshPointRadius];
    [self addTranslationAniToLayer:self.rightPointLayer xValue:-LeeRefreshPointRadius yValue:0];
    [self addRotationAniToLayer:self.layer];
}

/**
 动画结束时候移除所有动画
 */
-(void)removeAnimations{
    
    [self.TopPointLayer removeAllAnimations];
    [self.LeftPointLayer removeAllAnimations];
    [self.BottomPointLayer removeAllAnimations];
    [self.rightPointLayer removeAllAnimations];
    [self.layer removeAllAnimations];
    [self adjustPointStateWithIndex:0];
    self.animating = NO;
}




@end
