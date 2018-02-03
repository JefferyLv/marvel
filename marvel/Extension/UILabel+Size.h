//
//  UILabel+size.h
//  marvel
//
//  Created by lvwei on 03/02/2018.
//  Copyright © 2018 lvwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Size)

+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font;
@end
