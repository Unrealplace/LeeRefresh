//
//  LeeRefreshHeader.h
//  LeeRefreshDemo
//
//  Created by mac on 17/2/20.
//  Copyright © 2017年 LiYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeeRefreshHeader : UIView

/**
 添加目标
 */
@property (nonatomic,weak)id target;

/**
 添加方法
 */
@property (nonatomic,assign)SEL action;

/**
 添加偏移量
 */
@property (nonatomic, assign) CGFloat progress;

/**
 头部开始和结束刷新动画
 */
-(void)startRefreshing;
-(void)endRefreshing;


@end
