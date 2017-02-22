//
//  LeeCommonHeader.h
//  demoView
//
//  Created by mac on 17/1/13.
//  Copyright © 2017年 Oliver. All rights reserved.
//
#import <UIKit/UIKit.h>
#include <objc/runtime.h>

#ifndef LeeCommonHeader_h
#define LeeCommonHeader_h


#pragma mark - Debug日志
#ifdef DEBUG
#    define  LeeLog(...) printf("**%s**\n",[[NSString stringWithFormat:__VA_ARGS__]UTF8String])
#    define FLog(s) NSLog(@"[%@-%@]:\n%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd),s)
#    define TLog(...) NSLog(@"[%@-%@]:\n%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd),[NSString stringWithFormat:__VA_ARGS__])
#else
#    define LeeLog(...) */
#    define FLog(...)
#    define TLog(...)
#endif


#pragma mark - 设备相关（硬件或者软件）

#define IS_IPHONE4S ([UIScreen mainScreen].bounds.size.height == 480)
#define IS_IPHONE5_5S ([UIScreen mainScreen].bounds.size.height == 568)
#define IS_IPHONE6_7 ([UIScreen mainScreen].bounds.size.height == 667)
#define IS_IPHONE6_PLUS_7_PLUS ([UIScreen mainScreen].bounds.size.height ==736)


#pragma mark- 加载资源
#define Nib(ClassName) [UINib nibWithNibName:NSStringFromClass([ClassName class]) bundle:nil]
#define ReuseIdentifier(string) NSStringFromClass([string class])
#define Xib(ClassName) [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ClassName class]) owner:nil options:nil]lastObject]

#pragma mark - 控制器弹出
#define Lee_PUSH(VC)    [self.navigationController pushViewController:VC animated:YES];
#define Lee_POPVC       [self.navigationController popViewControllerAnimated:YES];
#define Lee_POPTOROOT   [self.navigationController popToRootViewControllerAnimated:YES];


#pragma mark - Global Color

// 基础颜色
#define LeeColorClear                [UIColor clearColor]
#define LeeColorWhite                [UIColor whiteColor]
#define LeeColorBlack                [UIColor blackColor]
#define LeeColorGray                 [UIColor grayColor]
#define LeeColorGrayDarken           [UIColor grayDarkenColor]
#define LeeColorGrayLighten          [UIColor grayLightenColor]
#define LeeColorRed                  [UIColor redColor]
#define LeeColorGreen                [UIColor greenColor]
#define LeeColorBlue                 [UIColor blueColor]
#define LeeColorYellow               [UIColor yellowColor]

// UIColor相关创建器
#define LeeColorMake(r, g, b)            [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define LeeColorMakeWithRGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/1.0]
#define LeeColorFromHex(rgbValue,a)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a/1.0]


#pragma mark - global font
#define PING_FANG_SC @"PingFang SC"

#define LeeFontWith(fontfloat,namestring) [UIFont fontWithName:namestring size:fontfloat *      (IS_IPHONE6_7?1:(IS_IPHONE5_5S?0.8:(IS_IPHONE6_PLUS_7_PLUS?1.2:0.8)))]

#pragma mark - Uiimage

#define LeeImageNamed(s)  [UIImage imageNamed:s]

#pragma mark- 通知中心
#define LeeNotiCenter     [NSNotificationCenter defaultCenter]

#define LeeUserDefault    [NSUserDefaults standardUserDefaults]




#pragma mark - 视图高度
//屏幕宽度
#define LeeWidth   [UIScreen mainScreen].bounds.size.width
//屏幕高度
#define LeeHeight  [UIScreen mainScreen].bounds.size.height
//状态栏高度
#define StatusbarHeight  [UIApplication sharedApplication].statusBarFrame.size.height
//应用Frame
#define AppFrame         [UIScreen mainScreen].applicationFrame



#pragma mark - addView

#define LeeAddView(super,child)  [super addSubview:child]


 //#define LeeViewSetFrame(v,x,y,w,h)         [[v alloc]initWithFrame:CGRectMake(x, y, w, h)];

#define LeeLabelSetFrame(x,y,w,h)           [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];

#define LeeButtunSetFrame(x,y,w,h)          [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];

#define LeeViewSetFrame(x,y,w,h)            [[UIView alloc]initWithFrame:CGRectMake(x, y, w, h)];

#pragma mark 新添加的
#define ScreenScale ([[UIScreen mainScreen] scale])


#pragma mark - 方法-C对象、结构操作

//http://www.jianshu.com/p/d557b0831c6a 关于内联函数
/**
 *  基于指定的倍数，对传进来的 floatValue 进行像素取整。若指定倍数为0，则表示以当前设备的屏幕倍数为准。
 *
 *  例如传进来 “2.1”，在 2x 倍数下会返回 2.5（0.5pt 对应 1px），在 3x 倍数下会返回 2.333（0.333pt 对应 1px）。
 */
CG_INLINE float
flatfSpecificScale(float floatValue, float scale) {
    scale = scale == 0 ? ScreenScale : scale;
    CGFloat flattedValue = ceilf(floatValue * scale) / scale;
    return flattedValue;
}

/**
 *  基于当前设备的屏幕倍数，对传进来的 floatValue 进行像素取整。
 *
 *  注意如果在 Core Graphic 绘图里使用时，要注意当前画布的倍数是否和设备屏幕倍数一致，若不一致，不可使用 flatf() 函数。
 */
CG_INLINE float
flatf(float floatValue) {
    return flatfSpecificScale(floatValue, 0);
}

/**
 *  类似flatf()，只不过 flatf 是向上取整，而 floorfInPixel 是向下取整
 */
CG_INLINE float
floorfInPixel(float floatValue) {
    CGFloat resultValue = floorf(floatValue * ScreenScale) / ScreenScale;
    return resultValue;
}

CG_INLINE BOOL
betweenf(float minimumValue, float value, float maximumValue) {
    return minimumValue < value && value < maximumValue;
}

CG_INLINE BOOL
betweenOrEqualf(float minimumValue, float value, float maximumValue) {
    return minimumValue <= value && value <= maximumValue;
}

CG_INLINE void
ReplaceMethod(Class _class, SEL _originSelector, SEL _newSelector) {
    Method oriMethod = class_getInstanceMethod(_class, _originSelector);
    Method newMethod = class_getInstanceMethod(_class, _newSelector);
    BOOL isAddedMethod = class_addMethod(_class, _originSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (isAddedMethod) {
        class_replaceMethod(_class, _newSelector, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, newMethod);
    }
}




#pragma mark - CGFloat
/// 两个点的居中运算
CG_INLINE CGFloat
LeePointGetCenter(CGFloat parent, CGFloat child) {
    return flatf((parent - child) / 2.0);
}
#pragma mark - CGPoint

/// 两个point相加
CG_INLINE CGPoint
LeePointSum(CGPoint point1, CGPoint point2) {
    return CGPointMake(flatf(point1.x + point2.x), flatf(point1.y + point2.y));
}
/// 获取rect的center，注意：包括rect本身的x/y偏移
CG_INLINE CGPoint
LeePointGetCenterWithRect(CGRect rect) {
    return CGPointMake(flatf(CGRectGetMidX(rect)), flatf(CGRectGetMidY(rect)));
}
/// 获取size的center，注意：包括rect本身的x/y偏移
CG_INLINE CGPoint
LeePointGetCenterWithSize(CGSize size) {
    return CGPointMake(flatf(size.width / 2.0), flatf(size.height / 2.0));
}




#pragma mark - UIEdgeInsets

/// 获取UIEdgeInsets在水平方向上的值
CG_INLINE CGFloat
UIEdgeInsetsGetHorizontalValue(UIEdgeInsets insets) {
    return insets.left + insets.right;
}

/// 获取UIEdgeInsets在垂直方向上的值
CG_INLINE CGFloat
UIEdgeInsetsGetVerticalValue(UIEdgeInsets insets) {
    return insets.top + insets.bottom;
}

/// 将两个UIEdgeInsets合并为一个
CG_INLINE UIEdgeInsets
UIEdgeInsetsConcat(UIEdgeInsets insets1, UIEdgeInsets insets2) {
    insets1.top += insets2.top;
    insets1.left += insets2.left;
    insets1.bottom += insets2.bottom;
    insets1.right += insets2.right;
    return insets1;
}

CG_INLINE UIEdgeInsets
UIEdgeInsetsSetTop(UIEdgeInsets insets, CGFloat top) {
    insets.top = flatf(top);
    return insets;
}

CG_INLINE UIEdgeInsets
UIEdgeInsetsSetLeft(UIEdgeInsets insets, CGFloat left) {
    insets.left = flatf(left);
    return insets;
}
CG_INLINE UIEdgeInsets
UIEdgeInsetsSetBottom(UIEdgeInsets insets, CGFloat bottom) {
    insets.bottom = flatf(bottom);
    return insets;
}

CG_INLINE UIEdgeInsets
UIEdgeInsetsSetRight(UIEdgeInsets insets, CGFloat right) {
    insets.right = flatf(right);
    return insets;
}







#pragma mark - CGSize

/// 判断一个size是否为空（宽或高为0）
CG_INLINE BOOL
LeeSizeIsEmpty(CGSize size) {
    return size.width <= 0 || size.height <= 0;
}

/// 将一个CGSize像素对齐 实际测试和下面那个pt 对齐好像没区别
CG_INLINE CGSize
LeeSizeFlatted(CGSize size) {
    return CGSizeMake(flatf(size.width), flatf(size.height));
}

/// 将一个 CGSize 以 pt 为单位向上取整
CG_INLINE CGSize
LeeSizeCeil(CGSize size) {
    return CGSizeMake(ceilf(size.width), ceilf(size.height));
}

/// 将一个 CGSize 以 pt 为单位向下取整
CG_INLINE CGSize
LeeSizeFloor(CGSize size) {
    return CGSizeMake(floorf(size.width), floorf(size.height));
}



#pragma mark - CGRect

/// 判断一个CGRect是否存在NaN
CG_INLINE BOOL
LeeRectIsNaN(CGRect rect) {
    return isnan(rect.origin.x) || isnan(rect.origin.y) || isnan(rect.size.width) || isnan(rect.size.height);
}

/// 创建一个像素对齐的CGRect
CG_INLINE CGRect
LeeRectFlatMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height) {
    return CGRectMake(flatf(x), flatf(y), flatf(width), flatf(height));
}

/// 对CGRect的x/y、width/height都调用一次flatf，以保证像素对齐
CG_INLINE CGRect
LeeRectFlatted(CGRect rect) {
    return CGRectMake(flatf(rect.origin.x), flatf(rect.origin.y), flatf(rect.size.width), flatf(rect.size.height));
}

/// 为一个CGRect叠加scale计算
CG_INLINE CGRect
LeeRectApplyScale(CGRect rect, CGFloat scale) {
    return LeeRectFlatted(CGRectMake(CGRectGetMinX(rect) * scale, CGRectGetMinY(rect) * scale, CGRectGetWidth(rect) * scale, CGRectGetHeight(rect) * scale));
}



/// 计算view的水平居中，传入父view和子view的frame，返回子view在水平居中时的x值
CG_INLINE CGFloat
LeeRectGetMinXHorizontallyCenterInParentRect(CGRect parentRect, CGRect childRect) {
    return flatf((CGRectGetWidth(parentRect) - CGRectGetWidth(childRect)) / 2.0);
}

/// 计算view的垂直居中，传入父view和子view的frame，返回子view在垂直居中时的y值
CG_INLINE CGFloat
LeeRectGetMinYVerticallyCenterInParentRect(CGRect parentRect, CGRect childRect) {
    return flatf((CGRectGetHeight(parentRect) - CGRectGetHeight(childRect)) / 2.0);
}


//还没看完
/// 返回值：同一个坐标系内，想要layoutingRect和已布局完成的referenceRect保持垂直居中时，layoutingRect的originY
CG_INLINE CGFloat
CGRectGetMinYVerticallyCenter(CGRect referenceRect, CGRect layoutingRect) {
    return CGRectGetMinY(referenceRect) + LeeRectGetMinYVerticallyCenterInParentRect(referenceRect, layoutingRect);
}

/// 返回值：同一个坐标系内，想要layoutingRect和已布局完成的referenceRect保持水平居中时，layoutingRect的originX
CG_INLINE CGFloat
LeeRectGetMinXHorizontallyCenter(CGRect referenceRect, CGRect layoutingRect) {
    return CGRectGetMinX(referenceRect) + LeeRectGetMinXHorizontallyCenterInParentRect(referenceRect, layoutingRect);
}



/// 为给定的rect往内部缩小insets的大小
CG_INLINE CGRect
LeeRectInsetEdges(CGRect rect, UIEdgeInsets insets) {
    rect.origin.x += insets.left;
    rect.origin.y += insets.top;
    rect.size.width -= UIEdgeInsetsGetHorizontalValue(insets);
    rect.size.height -= UIEdgeInsetsGetVerticalValue(insets);
    return rect;
}

/// 传入size，返回一个x/y为0的CGRect
CG_INLINE CGRect
CGRectMakeWithSize(CGSize size) {
    return CGRectMake(0, 0, size.width, size.height);
}

CG_INLINE CGRect
CGRectFloatTop(CGRect rect, CGFloat top) {
    rect.origin.y = top;
    return rect;
}

CG_INLINE CGRect
CGRectFloatBottom(CGRect rect, CGFloat bottom) {
    rect.origin.y = bottom - CGRectGetHeight(rect);
    return rect;
}

CG_INLINE CGRect
CGRectFloatRight(CGRect rect, CGFloat right) {
    rect.origin.x = right - CGRectGetWidth(rect);
    return rect;
}

CG_INLINE CGRect
CGRectFloatLeft(CGRect rect, CGFloat left) {
    rect.origin.x = left;
    return rect;
}

/// 保持rect的左边缘不变，改变其宽度，使右边缘靠在right上
CG_INLINE CGRect
CGRectLimitRight(CGRect rect, CGFloat rightLimit) {
    rect.size.width = rightLimit - rect.origin.x;
    return rect;
}

/// 保持rect右边缘不变，改变其宽度和origin.x，使其左边缘靠在left上。只适合那种右边缘不动的view
/// 先改变origin.x，让其靠在offset上
/// 再改变size.width，减少同样的宽度，以抵消改变origin.x带来的view移动，从而保证view的右边缘是不动的
CG_INLINE CGRect
CGRectLimitLeft(CGRect rect, CGFloat leftLimit) {
    CGFloat subOffset = leftLimit - rect.origin.x;
    rect.origin.x = leftLimit;
    rect.size.width = rect.size.width - subOffset;
    return rect;
}

/// 限制rect的宽度，超过最大宽度则截断，否则保持rect的宽度不变
CG_INLINE CGRect
CGRectLimitMaxWidth(CGRect rect, CGFloat maxWidth) {
    CGFloat width = CGRectGetWidth(rect);
    rect.size.width = width > maxWidth ? maxWidth : width;
    return rect;
}

CG_INLINE CGRect
CGRectSetX(CGRect rect, CGFloat x) {
    rect.origin.x = flatf(x);
    return rect;
}

CG_INLINE CGRect
CGRectSetY(CGRect rect, CGFloat y) {
    rect.origin.y = flatf(y);
    return rect;
}

CG_INLINE CGRect
CGRectSetXY(CGRect rect, CGFloat x, CGFloat y) {
    rect.origin.x = flatf(x);
    rect.origin.y = flatf(y);
    return rect;
}

CG_INLINE CGRect
CGRectSetWidth(CGRect rect, CGFloat width) {
    rect.size.width = flatf(width);
    return rect;
}

CG_INLINE CGRect
CGRectSetHeight(CGRect rect, CGFloat height) {
    rect.size.height = flatf(height);
    return rect;
}

CG_INLINE CGRect
CGRectSetSize(CGRect rect, CGSize size) {
    rect.size = LeeSizeFlatted(size);
    return rect;
}

#endif /* LeeCommonHeader_h */
