//
//  UIScrollView+LeeRefresh.h
//  LeeRefreshView
//
//  Created by mac on 17/2/21.
//  Copyright © 2017年 https://github.com/Unrealplace     如有问题可以联系：939428468. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LeeRefreshHeader;
@class LeeRefreshFooter;
@interface UIScrollView (LeeRefresh)
@property (nonatomic,strong)LeeRefreshHeader * lee_header;
@property (nonatomic,strong)LeeRefreshFooter * lee_footer;
/**
 添加刷新的头尾部
 
 @param start 自动刷新功能
 */
-(void)addRefreshFooterWithAutoFresh:(BOOL)start WithTarget:(id)target andAction:(SEL)action;

-(void)addRefreshHeaderWithAutoFresh:(BOOL)start WithTarget:(id)target andAction:(SEL)action;

/**
 开始结束刷新
 */
-(void)headerRefreshing;
-(void)headerEndRefreshing;

-(void)footerRefreshing;
-(void)footerEndRefreshing;
@end
