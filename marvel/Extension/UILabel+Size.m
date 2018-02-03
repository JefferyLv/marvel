//
//  UILable+Size.m
//  marvel
//
//  Created by lvwei on 03/02/2018.
//  Copyright © 2018 lvwei. All rights reserved.
//

#import "UILabel+Size.h"

@implementation UILabel (Size)

+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    return label.frame.size.height;
}

@end
