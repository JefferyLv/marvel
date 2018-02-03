//
//  CollectionViewCell.m
//  marvel
//
//  Created by lvwei on 01/02/2018.
//  Copyright © 2018 lvwei. All rights reserved.
//

#import "CollectionViewCell.h"
#import "UIImageView+Cache.h"

@implementation CollectionViewCell

#pragma mark <Cell reusing>

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.name.text = @"";
    self.avatar.image = nil;
}

#pragma mark <Cell configuration>

- (void)configureCellWithName:(NSString *)name
                     andImage:(NSString *)image
                     andLiked:(BOOL)liked
{
    self.name.text = name;
    self.like.selected = liked;
    [self.avatar setImageFromCache:image];
}

@end
