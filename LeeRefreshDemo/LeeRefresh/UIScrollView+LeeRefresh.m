//
//  UIScrollView+LeeRefresh.m
//  LeeRefreshDemo
//
//  Created by LiYang on 17/2/5.
//  Copyright © 2017年 LiYang. All rights reserved.
//

#import "UIScrollView+LeeRefresh.h"
#import "LeeRefreshFooter.h"
#import "LeeRefreshHeader.h"
#import <objc/runtime.h>


@implementation UIScrollView (LeeRefresh)

-(void)setHeader:(LeeRefreshHeader *)header{
    
    objc_setAssociatedObject(self, @selector(header), header, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(LeeRefreshHeader*)header{
    
    return objc_getAssociatedObject(self, @selector(header));
}
-(void)setFooter:(LeeRefreshFooter *)footer{
    
    objc_setAssociatedObject(self, @selector(footer), footer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(LeeRefreshFooter*)footer{
    
    return objc_getAssociatedObject(self, @selector(footer));
}


#pragma mark - Swizzle
+ (void)load {
    Method originalMethod = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    Method swizzleMethod = class_getInstanceMethod([self class], NSSelectorFromString(@"lee_dealloc"));
    method_exchangeImplementations(originalMethod, swizzleMethod);
}

- (void)lee_dealloc {
    NSLog(@"dealloc");
    self.header = nil;
    self.footer = nil;
    [self lee_dealloc];
}

/**
 添加刷新的头尾部
 
 @param start 自动刷新功能
 */
-(void)addRefreshFooterWithAutoFresh:(BOOL)start WithTarget:(id)target andAction:(SEL)action{
    
    
}
-(void)addRefreshHeaderWithAutoFresh:(BOOL)start WithTarget:(id)target andAction:(SEL)action{
    
    self.header = [[LeeRefreshHeader alloc] init];
    self.header.target = target;
    self.header.action = action;
    [self insertSubview:self.header atIndex:0];
    start ? [self startRefreshing]:nil;
    
}
/**
 开始刷新
 */
-(void)startRefreshing{
    
    self.header.progress = 55;

}

/**
 结束刷新
 */
-(void)endRefreshing{
    
    [self.header endRefreshing];
    
}
@end
