//
//  CAShapeLayer+LeeRefresh.m
//  LeeRefreshDemo
//
//  Created by LiYang on 17/2/8.
//  Copyright © 2017年 LiYang. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "CAShapeLayer+LeeRefresh.h"

const CGFloat LeeRefreshRadius = 5.0;

@implementation CAShapeLayer (LeeRefresh)

+(CAShapeLayer *)layerWithPoint:(CGPoint)center color:(CGColorRef)color{
    
    CAShapeLayer * layer = [CAShapeLayer layer];
    //通过二倍的关系设置出来矩形layer 并画出来圆形的 layer 效果
    layer.frame = CGRectMake(center.x - LeeRefreshRadius, center.y - LeeRefreshRadius, LeeRefreshRadius * 2, LeeRefreshRadius * 2);
    layer.fillColor = color;
    layer.path = [self pointPath];
    layer.hidden = YES;
    return layer;
}


+ (CGPathRef)pointPath {
    return [UIBezierPath bezierPathWithArcCenter:CGPointMake(LeeRefreshRadius, LeeRefreshRadius) radius:LeeRefreshRadius startAngle:0 endAngle:M_PI * 2 clockwise:YES].CGPath;
    
}

@end
