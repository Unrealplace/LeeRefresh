//
//  LeeRefreshView.m
//  LeeRefreshView
//
//  Created by mac on 17/2/21.
//  Copyright © 2017年 https://github.com/Unrealplace     如有问题可以联系：939428468. All rights reserved.
//

#import "LeeRefreshView.h"

const CGFloat LeeRefreshViewDefaultHeight = 55.0f;

@interface LeeRefreshView(){

    BOOL _hasSetOriginalInsets;

}
@end
@implementation LeeRefreshView

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

+ (instancetype)refreshView{
    
    return [[self alloc] init];
}

/**
 视图出现方法

 @param newSuperview scrollivew
 */
- (void)willMoveToSuperview:(UIView *)newSuperview{
    
    [super willMoveToSuperview:newSuperview];
    if (!newSuperview) {
        [self.superview removeObserver:self forKeyPath:LeeRefreshViewObservingkeyPath];
    }else{
        self.scrollView = (UIScrollView *)newSuperview;
        [self.scrollView addObserver:self forKeyPath:LeeRefreshViewObservingkeyPath options:NSKeyValueObservingOptionNew context:nil];
    }
    
}
- (void)didMoveToSuperview{
    
    [super didMoveToSuperview];
    self.bounds = CGRectMake(0, 0, self.scrollView.frame.size.width, LeeRefreshViewDefaultHeight);
    
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
}

- (void)addTarget:(id)target refreshAction:(SEL)action{
    
    _LeeTarget = target;
    _LeeAction = action;
}

// 获得在scrollView的contentInset原来基础上增加一定值之后的新contentInset
- (UIEdgeInsets)syntheticalEdgeInsetsWithEdgeInsets:(UIEdgeInsets)edgeInsets{
    
    return UIEdgeInsetsMake(_originalEdgeInsets.top + edgeInsets.top, _originalEdgeInsets.left + edgeInsets.left, _originalEdgeInsets.bottom + edgeInsets.bottom, _originalEdgeInsets.right + edgeInsets.right);
}

// 根据状态进行刷新操作
- (void)setRefreshState:(LeeRefreshViewState)refreshState{
    
    _refreshState = refreshState;
    switch (refreshState) {
        case LeeRefreshViewStateRefreshing:{
            if (!_hasSetOriginalInsets) {
                _originalEdgeInsets = self.scrollView.contentInset;
                _hasSetOriginalInsets = YES;
            }
            _scrollView.contentInset = [self syntheticalEdgeInsetsWithEdgeInsets:self.scrollViewEdgeInsets];
            LeeRefreshMsgSend(LeeRefreshMsgTarget(self.LeeTarget), self.LeeAction, self);
        }
            break;
            
        case LeeRefreshViewStateWillRefresh:{

            NSLog(@"将要刷新......");
           
        }
            break;
            
        case LeeRefreshViewStateNormal:{
        
            NSLog(@"重置刷新......");
        }
            break;
        default:
            break;
    }
}
- (void)endRefreshing{
    
    [UIView animateWithDuration:0.4 animations:^{
        _scrollView.contentInset = _originalEdgeInsets;
        
    } completion:^(BOOL finished) {
        [self setRefreshState:LeeRefreshViewStateNormal];
        if (self.isManuallyRefreshing) {
            self.isManuallyRefreshing = NO;
        }
    }];
    
}
// 保留！
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
}

-(void)setIsManuallyRefreshing:(BOOL)isManuallyRefreshing{

    _isManuallyRefreshing = isManuallyRefreshing;
    if (_isManuallyRefreshing) {
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }
    
}

@end
