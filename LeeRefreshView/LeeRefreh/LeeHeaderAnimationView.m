//
//  LeeHeaderAnimationView.m
//  LeeRefreshView
//
//  Created by mac on 17/2/21.
//  Copyright © 2017年 https://github.com/Unrealplace     如有问题可以联系：939428468. All rights reserved.
//

#import "LeeHeaderAnimationView.h"

const CGFloat LeeBallSize = 12;
const CGFloat LeeRotaSize = 20;

@interface LeeHeaderAnimationView()<CAAnimationDelegate>

@property (nonatomic,strong)UIView * shakeView1;
@property (nonatomic,strong)UIView * shakeView2;
@property (nonatomic,strong)UIView * shakeView3;
@property(nonatomic, strong)NSTimer * timer;

@end
@implementation LeeHeaderAnimationView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupView];
    }
    return self;
    
}
-(void)layoutSubviews{
    
    [super layoutSubviews];
    self.shakeView2.frame = CGRectMake(0, 0, LeeBallSize, LeeBallSize);
    self.shakeView2.center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
    self.shakeView1.frame = CGRectMake(0, 0, LeeBallSize, LeeBallSize);
    self.shakeView1.center = CGPointMake(self.bounds.size.width/2.0 - LeeBallSize, self.bounds.size.height/2.0);
    self.shakeView3.frame = CGRectMake(0, 0, LeeBallSize, LeeBallSize);
    self.shakeView3.center = CGPointMake(self.bounds.size.width/2.0 + LeeBallSize, self.bounds.size.height/2.0);
    
    self.shakeView1.layer.cornerRadius = self.shakeView1.bounds.size.width / 2;
    self.shakeView2.layer.cornerRadius = self.shakeView2.bounds.size.width / 2;
    self.shakeView3.layer.cornerRadius = self.shakeView3.bounds.size.width / 2;
    
}
-(void)setupView{
    
    self.shakeView1 = [UIView new];
    self.shakeView2 = [UIView new];
    self.shakeView3 = [UIView new];
    
    self.shakeView3.backgroundColor = [UIColor redColor];
    self.shakeView2.backgroundColor = [UIColor blueColor];
    self.shakeView1.backgroundColor = [UIColor greenColor];
    
    [self addSubview:self.shakeView1];
    [self addSubview:self.shakeView2];
    [self addSubview:self.shakeView3];
    
}

-(void)ballViewAddAnimations{
    
    //-----1--------
    UIBezierPath *Path_1 = [UIBezierPath bezierPath];
    [Path_1 moveToPoint:CGPointMake(self.bounds.size.width/2-LeeBallSize, self.bounds.size.height/2)];
    [Path_1 addArcWithCenter:CGPointMake(self.bounds.size.width/2,self.bounds.size.height/2) radius:LeeRotaSize startAngle:(180*M_PI)/180 endAngle:(360*M_PI)/180 clockwise:NO];
    UIBezierPath *Path_1_2 = [UIBezierPath bezierPath];
    [Path_1_2 addArcWithCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) radius:LeeRotaSize startAngle:0 endAngle:(180*M_PI)/180 clockwise:NO];
    [Path_1 appendPath:Path_1_2];
    
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = Path_1.CGPath;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.calculationMode = kCAAnimationCubic;
    animation.repeatCount = INFINITY;
    animation.duration = 1.4;
    animation.delegate = self;
    animation.autoreverses = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.shakeView1.layer addAnimation:animation forKey:@"animation"];
    //------2--------
    UIBezierPath *Path_2 = [UIBezierPath bezierPath];
    [Path_2 moveToPoint:CGPointMake(self.bounds.size.width/2+LeeBallSize, self.bounds.size.height/2)];
    [Path_2 addArcWithCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) radius:LeeRotaSize startAngle:(0*M_PI)/180 endAngle:(180*M_PI)/180 clockwise:NO];
    UIBezierPath *Path_2_2 = [UIBezierPath bezierPath];
    [Path_2_2 addArcWithCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) radius:LeeRotaSize startAngle:(180 *M_PI)/180 endAngle:(360*M_PI)/180 clockwise:NO];
    [Path_2 appendPath:Path_2_2];
    CAKeyframeAnimation *animation_2 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation_2.path = Path_2.CGPath;
    animation_2.removedOnCompletion = YES;
    animation_2.repeatCount = INFINITY;
    animation_2.duration = 1.4 ;
    animation_2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.shakeView3.layer addAnimation:animation_2 forKey:@"Rotation"];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(scaleAnimation) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
    
}

-(void)scaleAnimation{
    
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.shakeView1.transform = CGAffineTransformMakeTranslation(-5, 0);
        self.shakeView1.transform = CGAffineTransformScale(self.shakeView1.transform, 0.7, 0.7);
        self.shakeView3.transform = CGAffineTransformMakeTranslation(5, 0);
        self.shakeView3.transform = CGAffineTransformScale(self.shakeView3.transform, 0.7, 0.7);
        self.shakeView2.transform = CGAffineTransformScale(self.shakeView2.transform, 0.7, 0.7);
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseIn  | UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.shakeView1.transform = CGAffineTransformIdentity;
            self.shakeView3.transform = CGAffineTransformIdentity;
            self.shakeView2.transform = CGAffineTransformIdentity;
            
        } completion:nil];
    }];
    
}
- (void)animationDidStart:(CAAnimation *)anim{
    
}


-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
}
-(void)startAnimation{
    
    [self ballViewAddAnimations];
    
}
-(void)stopAnimation{
    
    [self.timer invalidate];
    [self.shakeView1.layer removeAllAnimations];
    [self.shakeView2.layer removeAllAnimations];
    [self.shakeView3.layer removeAllAnimations];
    
}




@end
