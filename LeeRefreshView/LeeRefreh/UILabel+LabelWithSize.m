//
//  UILabel+LabelWithSize.m
//  LeeRefreshView
//
//  Created by LiYang on 17/2/22.
//  Copyright © 2017年 https://github.com/Unrealplace     如有问题可以联系：939428468. All rights reserved.
//

#import "UILabel+LabelWithSize.h"

@implementation UILabel (LabelWithSize)

+(CGSize)getTheNewSizeWith:(NSString *)text andFont:(UIFont *)font{

    NSDictionary *attributes = @{NSFontAttributeName:font};

    CGSize textSize = [text sizeWithAttributes:attributes];
    
    return textSize;
}
@end
