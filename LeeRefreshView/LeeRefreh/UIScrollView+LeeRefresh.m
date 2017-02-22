//
//  UIScrollView+LeeRefresh.m
//  LeeRefreshView
//
//  Created by mac on 17/2/21.
//  Copyright © 2017年 https://github.com/Unrealplace     如有问题可以联系：939428468. All rights reserved.
//

#import "UIScrollView+LeeRefresh.h"
#import "LeeRefreshHeader.h"
#import "LeeRefreshFooter.h"
#import <objc/runtime.h>
@implementation UIScrollView (LeeRefresh)

-(void)setLee_header:(LeeRefreshHeader *)lee_header{
    
    objc_setAssociatedObject(self, @selector(lee_header), lee_header, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(LeeRefreshHeader*)lee_header{

    return  objc_getAssociatedObject(self, @selector(lee_header));

}

-(void)setLee_footer:(LeeRefreshFooter *)lee_footer{

    objc_setAssociatedObject(self, @selector(lee_footer), lee_footer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}
-(LeeRefreshFooter*)lee_footer{

    return  objc_getAssociatedObject(self, @selector(lee_footer));

}
-(void)addRefreshHeaderWithAutoFresh:(BOOL)start WithTarget:(id)target andAction:(SEL)action{

    LeeRefreshHeader *refreshHeader = [LeeRefreshHeader refreshView];
    refreshHeader.LeeTarget = target;
    refreshHeader.LeeAction = action;
    self.lee_header = refreshHeader;
    [self insertSubview:refreshHeader atIndex:0];
    start?[self headerRefreshing]:nil;
    
}
-(void)addRefreshFooterWithAutoFresh:(BOOL)start WithTarget:(id)target andAction:(SEL)action{
    
    LeeRefreshFooter *refreshFooter = [LeeRefreshFooter refreshView];
    refreshFooter.LeeTarget = target;
    refreshFooter.LeeAction = action;
    self.lee_footer = refreshFooter;
    [self insertSubview:refreshFooter atIndex:0];
    start?[self footerEndRefreshing]:nil;
    
}

/**
 开始刷新
 */
-(void)headerRefreshing{
    
    self.lee_header.isManuallyRefreshing = YES;
}

/**
 结束刷新
 */
-(void)headerEndRefreshing{
    
    [self.lee_header endRefreshing];
    [self.lee_header.animationView stopAnimation];
    
}

-(void)footerRefreshing{

}
-(void)footerEndRefreshing{

    [self.lee_footer.footerView footerAnimationStop];
    [self.lee_footer endRefreshing];
    
}

@end
