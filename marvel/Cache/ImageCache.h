//
//  ImageCache.h
//  marvel
//
//  Created by lvwei on 02/02/2018.
//  Copyright © 2018 lvwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCache : NSObject

+ (ImageCache*)sharedCache;

- (void)setImage:(UIImage*)image forKey:(NSString*)key;
- (void)getImage:(NSString*)key
         success:(void (^)(UIImage *image))successBlock
         failure:(void (^)(NSError *error))failureBlock;

@end

