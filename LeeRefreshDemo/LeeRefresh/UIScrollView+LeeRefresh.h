//
//  UIScrollView+LeeRefresh.h
//  LeeRefreshDemo
//
//  Created by LiYang on 17/2/5.
//  Copyright © 2017年 LiYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LeeRefreshFooter;
@class LeeRefreshHeader;

@interface UIScrollView (LeeRefresh)

@property (nonatomic,strong,readonly)LeeRefreshHeader * header;

@property (nonatomic,strong,readonly)LeeRefreshFooter * footer;

/**
 添加刷新的头尾部
 
 @param start 自动刷新功能
 */
-(void)addRefreshFooterWithAutoFresh:(BOOL)start WithTarget:(id)target andAction:(SEL)action;

-(void)addRefreshHeaderWithAutoFresh:(BOOL)start WithTarget:(id)target andAction:(SEL)action;

/**
 开始结束刷新
 */
-(void)startRefreshing;
-(void)endRefreshing;




@end
