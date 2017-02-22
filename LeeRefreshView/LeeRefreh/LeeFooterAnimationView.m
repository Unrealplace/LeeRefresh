//
//  LeeFooterAnimationView.m
//  LeeRefreshView
//
//  Created by LiYang on 17/2/22.
//  Copyright © 2017年 https://github.com/Unrealplace     如有问题可以联系：939428468. All rights reserved.
//

#import "LeeFooterAnimationView.h"
#import "LeeRefreshLoadView.h"
#import "UILabel+LabelWithSize.h"

@interface LeeFooterAnimationView()

@property (nonatomic,strong)LeeRefreshLoadView * footerLoadView;
@property (nonatomic,strong)UILabel            * footerLabel;

@end
@implementation LeeFooterAnimationView

-(instancetype)init{

    if (self = [super init]) {
        [self setupView];
    }
    return self;
}

-(void)setupView{

    self.footerLoadView = [[LeeRefreshLoadView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    self.footerLabel    =  [UILabel new];
    [self addSubview:self.footerLoadView];
    [self addSubview:self.footerLabel];
    self.footerLabel.text = @"正在加载更多...";
    [self.footerLabel sizeToFit];
    self.footerLabel.textColor = [UIColor purpleColor];
    self.hidden = YES;

}

-(void)layoutSubviews{

    [super layoutSubviews];

    self.footerLoadView.frame = CGRectMake(0, 0, 40, 40);
    self.footerLabel.frame = CGRectMake(CGRectGetMaxX(self.footerLoadView.frame)+15, 0, self.footerLabel.bounds.size.width, self.footerLabel.bounds.size.height);
    self.footerLabel.center = CGPointMake(self.footerLabel.center.x, self.footerLoadView.center.y);
    self.bounds = CGRectMake(0, 0, self.footerLoadView.bounds.size.width + self.footerLabel.bounds.size.width , self.footerLoadView.bounds.size.height);
    
}

-(void)footerAnimationStart{
    self.hidden = NO;
    [self.footerLoadView startAnimating];
}
-(void)footerAnimationStop{
    self.hidden = YES;
    [self.footerLoadView stopAnimating];
    
}


@end
