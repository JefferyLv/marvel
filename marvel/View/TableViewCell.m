//
//  TableViewCell.m
//  marvel
//
//  Created by lvwei on 01/02/2018.
//  Copyright © 2018 lvwei. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

#pragma mark <Cell configuration>

- (void)configureCellWithName:(NSString *)name andDescription:(NSString *)description {
    
    self.name.text = name;
    self.desc.text = description;

    [self.desc sizeToFit];
}

@end
