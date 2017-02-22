//
//  LeeRefreshFooter.m
//  LeeRefreshView
//
//  Created by mac on 17/2/21.
//  Copyright © 2017年 https://github.com/Unrealplace     如有问题可以联系：939428468. All rights reserved.
//

#import "LeeRefreshFooter.h"
#import "UIView+LeeRefresh.h"

@interface LeeRefreshFooter(){
    CGFloat _originalScrollViewContentHeight;
}
@property (nonatomic,strong)LeeFooterAnimationView * footerView;

@end
@implementation LeeRefreshFooter
-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor lightGrayColor];
        self.footerView      = [[LeeFooterAnimationView alloc] init];
        [self addSubview:self.footerView];
        
    }
    return self;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    _originalScrollViewContentHeight = self.scrollView.contentSize.height;
    self.center = CGPointMake(self.scrollView.lee_width * 0.5, self.scrollView.contentSize.height + self.lee_height * 0.5); // + self.scrollView.contentInset.bottom
    self.footerView.center  = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0 );
    
    self.hidden = [self shouldHide];
}

- (void)didMoveToSuperview{
    
    [super didMoveToSuperview];
    self.scrollViewEdgeInsets = UIEdgeInsetsMake(0, 0, self.lee_height, 0);
}

- (BOOL)shouldHide{
    return (self.scrollView.bounds.size.height > self.lee_y);
}
// 监听拖动变化
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if (![keyPath isEqualToString:LeeRefreshViewObservingkeyPath] || self.refreshState == LeeRefreshViewStateRefreshing) return;
    CGFloat y = [change[@"new"] CGPointValue].y;
    CGFloat criticalY = self.scrollView.contentSize.height - self.scrollView.lee_height + self.lee_height + self.scrollView.contentInset.bottom;
    // 如果scrollView内容有增减，重新调整refreshFooter位置
    if (self.scrollView.contentSize.height != _originalScrollViewContentHeight) {
        [self layoutSubviews];
    }
    // 只有在 y>0 以及 scrollview的高度不为0 时才判断
    if ((y <= 0) || (self.scrollView.bounds.size.height == 0)) return;
    // 触发SDRefreshViewStateRefreshing状态
    if (y <= criticalY && (self.refreshState == LeeRefreshViewStateWillRefresh) && !self.scrollView.isDragging) {
        [self.footerView footerAnimationStart];

        [self setRefreshState:LeeRefreshViewStateRefreshing];
        return;
    }
    // 触发SDRefreshViewStateWillRefresh状态
    if (y > criticalY && (self.refreshState == LeeRefreshViewStateNormal)) {
        //如果上拉加载隐藏了 在往上拉就切换状态了
        if (self.hidden) return;
        [self setRefreshState:LeeRefreshViewStateWillRefresh];
        return;
    }
    //触发LeeRefreshViewStateNormal状态
    if (y <= criticalY && self.scrollView.isDragging && (LeeRefreshViewStateNormal != self.refreshState)) {
        [self setRefreshState:LeeRefreshViewStateNormal];
    }

}

@end
