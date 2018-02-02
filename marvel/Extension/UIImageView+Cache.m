//
//  UIImageView+Cache.m
//  marvel
//
//  Created by lvwei on 02/02/2018.
//  Copyright © 2018 lvwei. All rights reserved.
//

#import "UIImageView+Cache.h"
#import "ImageCache.h"
#import "MarvelService.h"

@implementation UIImageView (Cache)

- (void)setImageFromCache:(NSString*)path
{
    [[ImageCache sharedCache] getImage:path
                               success:^(UIImage *img){
                                   self.image = img;
                               }
                               failure:^(NSError *error){
                                   
        [[MarvelService sharedInstance] getImage:path completion:^(UIImage *img, NSError *error) {
            [[ImageCache sharedCache] setImage:img forKey:path];
                                                                     
            dispatch_async(dispatch_get_main_queue(), ^{
                self.image = img;
            });
        }];
    }];
}

@end
