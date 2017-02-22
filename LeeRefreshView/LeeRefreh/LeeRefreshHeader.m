//
//  LeeRefreshHeader.m
//  LeeRefreshView
//
//  Created by mac on 17/2/21.
//  Copyright © 2017年 https://github.com/Unrealplace     如有问题可以联系：939428468. All rights reserved.
//

#import "LeeRefreshHeader.h"
#import "UIView+LeeRefresh.h"


@interface LeeRefreshHeader(){

    BOOL _hasLayoutedForManuallyRefreshing;

}
@property (nonatomic,strong)UIButton * animationBtn;
@property (nonatomic,strong)LeeHeaderAnimationView * animationView;

@end
@implementation LeeRefreshHeader

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        self.animationView = [[LeeHeaderAnimationView alloc] initWithFrame:CGRectMake(0, 0, 55, 55)];
        [self addSubview:self.animationView];
    }
    return self;
    
}

- (CGFloat)yOfCenterPoint{
    
    return - (self.lee_height * 0.5);
}

- (void)didMoveToSuperview{
    
    [super didMoveToSuperview];
    self.scrollViewEdgeInsets = UIEdgeInsetsMake(self.lee_height, 0, 0, 0);
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.center = CGPointMake(self.scrollView.lee_width * 0.5, [self yOfCenterPoint]);
    
    self.animationView.frame = CGRectMake(0, 0, 55, 55);
    self.animationView.center = CGPointMake(self.lee_width / 2.0, self.lee_height / 2.0);

    // 手动刷新
    if (self.isManuallyRefreshing &&!_hasLayoutedForManuallyRefreshing ) {
        // 模拟下拉操作
        CGPoint temp = self.scrollView.contentOffset;
        temp.y -= self.lee_height * 2;
        self.scrollView.contentOffset = temp; // 触发准备刷新
        temp.y += self.lee_height;
        self.scrollView.contentOffset = temp; // 触发刷新
        _hasLayoutedForManuallyRefreshing = YES;
    }
    
}
//监听拖动变化
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if (![keyPath isEqualToString:LeeRefreshViewObservingkeyPath] || self.refreshState == LeeRefreshViewStateRefreshing) return;
    CGFloat y = [change[@"new"] CGPointValue].y;
    CGFloat criticalY = -self.lee_height - self.scrollView.contentInset.top;
    
    if (y == 0 && self.refreshState == LeeRefreshViewStateRefreshing) {
        [self.animationView stopAnimation];
        return;
    }
    // 只有在 y<=0 以及 scrollview的高度不为0 时才判断
    if ((y > 0) || (self.scrollView.bounds.size.height == 0)) return;
    // 触发LeeRefreshViewStateRefreshing状态
    if (y <= criticalY && (self.refreshState == LeeRefreshViewStateWillRefresh) && !self.scrollView.isDragging) {
        [self setRefreshState:LeeRefreshViewStateRefreshing];
        [self.animationView startAnimation];
        
        return;
    }
    // 触发LeeRefreshViewStateWillRefresh状态 当拖动达到 －55 后继续拖动就会进入刷新
    if (y < criticalY && (self.refreshState == LeeRefreshViewStateNormal)) {
        [self setRefreshState:LeeRefreshViewStateWillRefresh];
        return;
    }
    //触发LeeRefreshViewStateNormal状态
    if (y > criticalY && self.scrollView.isDragging && (LeeRefreshViewStateNormal != self.refreshState)) {
        [self setRefreshState:LeeRefreshViewStateNormal];
        return;
    }

}




@end
