//
//  LeeRefreshView.h
//  LeeRefreshView
//
//  Created by mac on 17/2/21.
//  Copyright © 2017年 https://github.com/Unrealplace     如有问题可以联系：939428468. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/message.h>

typedef enum {
    LeeRefreshViewStateWillRefresh,
    LeeRefreshViewStateRefreshing,
    LeeRefreshViewStateNormal
} LeeRefreshViewState;

#define LeeRefreshViewObservingkeyPath @"contentOffset"
#define LeeRefreshMsgSend(...) ((void (*)(void *, SEL, UIView *))objc_msgSend)(__VA_ARGS__)
#define LeeRefreshMsgTarget(target) (__bridge void *)(target)

@interface LeeRefreshView : UIView

//添加 target 和 事件
@property (nonatomic, weak)   id  LeeTarget;
@property (nonatomic, assign) SEL LeeAction;
@property (nonatomic, weak) UIScrollView * scrollView;
@property (nonatomic, assign) LeeRefreshViewState refreshState;
// 记录原始contentEdgeInsets
@property (nonatomic, assign) UIEdgeInsets originalEdgeInsets;
// 子类自定义位置使用
@property (nonatomic, assign) UIEdgeInsets scrollViewEdgeInsets;
// 手动刷新
@property (nonatomic, assign) BOOL isManuallyRefreshing;

+ (instancetype)refreshView;
// 添加事件 和 target
- (void)addTarget:(id)target refreshAction:(SEL)action;
- (void)endRefreshing;

- (UIEdgeInsets)syntheticalEdgeInsetsWithEdgeInsets:(UIEdgeInsets)edgeInsets;




@end
