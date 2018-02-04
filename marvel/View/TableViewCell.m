//
//  TableViewCell.m
//  marvel
//
//  Created by lvwei on 01/02/2018.
//  Copyright © 2018 lvwei. All rights reserved.
//

#import "TableViewCell.h"
#import "UILabel+Size.h"

@implementation TableViewCell

#pragma mark <Cell configuration>

- (void)configureCellWithName:(NSString *)name andDescription:(NSString *)description {
    
    self.name.text = name;
    self.desc.text = description;

    CGFloat margin = 36;
    CGRect frame = self.desc.frame;
    UIFont *font = [UIFont systemFontOfSize:14];
    frame.size.width = [[UIScreen mainScreen] bounds].size.width - margin;
    frame.size.height = [UILabel getHeightByWidth:frame.size.width title:description font:font];
    self.desc.frame = frame;
}

@end
