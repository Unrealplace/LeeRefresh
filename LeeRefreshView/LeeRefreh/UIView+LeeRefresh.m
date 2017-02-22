//
//  UIView+LeeRefresh.m
//  LeeRefreshView
//
//  Created by mac on 17/2/21.
//  Copyright © 2017年 https://github.com/Unrealplace     如有问题可以联系：939428468. All rights reserved.
//

#import "UIView+LeeRefresh.h"

@implementation UIView (LeeRefresh)
- (CGFloat)lee_height
{
    return self.frame.size.height;
}

-(void)setLee_height:(CGFloat)lee_height{
    CGRect temp = self.frame;
    temp.size.height = lee_height;
    self.frame = temp;
    
}

- (CGFloat)lee_width
{
    return self.frame.size.width;
}

-(void)setLee_width:(CGFloat)lee_width{

    CGRect temp = self.frame;
    temp.size.width = lee_width;
    self.frame = temp;
}

- (CGFloat)lee_y
{
    return self.frame.origin.y;
}
-(void)setLee_y:(CGFloat)lee_y{
    CGRect temp = self.frame;
    temp.origin.y = lee_y;
    self.frame = temp;
    
}

-(CGFloat)lee_x{

    return self.frame.origin.x;
}
-(void)setLee_x:(CGFloat)lee_x{

    CGRect temp = self.frame;
    temp.origin.x = lee_x;
    self.frame = temp;
}

-(void)setLee_CenterY:(CGFloat)lee_CenterY{
    CGPoint center=self.center;
    center.y=lee_CenterY;
    self.center=center;
    
}
-(CGFloat)lee_CenterY{

    return self.center.y;
}

@end
