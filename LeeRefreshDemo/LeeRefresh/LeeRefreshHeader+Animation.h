//
//  LeeRefreshHeader+Animation.h
//  LeeRefreshDemo
//
//  Created by mac on 17/2/20.
//  Copyright © 2017年 LiYang. All rights reserved.
//

#import "LeeRefreshHeader.h"

@interface LeeRefreshHeader (Animation)
- (void)addTranslationAniToLayer:(CALayer *)layer xValue:(CGFloat)x yValue:(CGFloat)y;

- (void)addRotationAniToLayer:(CALayer *)layer;
@end
