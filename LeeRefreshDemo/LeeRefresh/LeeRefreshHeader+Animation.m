//
//  LeeRefreshHeader+Animation.m
//  LeeRefreshDemo
//
//  Created by mac on 17/2/20.
//  Copyright © 2017年 LiYang. All rights reserved.
//

#import "LeeRefreshHeader+Animation.h"

@implementation LeeRefreshHeader (Animation)

- (void)addTranslationAniToLayer:(CALayer *)layer xValue:(CGFloat)x yValue:(CGFloat)y {
    
    CAKeyframeAnimation * translationKeyframeAni = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    translationKeyframeAni.duration    = 1.0;
    translationKeyframeAni.repeatCount = HUGE;
    translationKeyframeAni.removedOnCompletion = NO;
    translationKeyframeAni.fillMode    = kCAFillModeForwards;
    translationKeyframeAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    NSValue * fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 0.f)];
    NSValue * toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(x, y, 0.f)];
    translationKeyframeAni.values = @[fromValue, toValue, fromValue, toValue, fromValue];
    [layer addAnimation:translationKeyframeAni forKey:@"translationKeyframeAni"];
}


- (void)addRotationAniToLayer:(CALayer *)layer {
    
    CABasicAnimation * rotationAni = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAni.fromValue = @(0);
    rotationAni.toValue = @(M_PI * 2);
    rotationAni.duration = 1.0;
    rotationAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotationAni.repeatCount = HUGE;
    rotationAni.fillMode = kCAFillModeForwards;
    rotationAni.removedOnCompletion = NO;
    [layer addAnimation:rotationAni forKey:@"rotationAni"];
}



@end
