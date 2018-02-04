//
//  Networking.h
//  marvel
//
//  Created by lvwei on 01/02/2018.
//  Copyright © 2018 lvwei. All rights reserved.
//

#import <UIKit/UIkit.h>

@interface MarvelService : NSObject

+ (instancetype)sharedInstance;

- (void)getCharacters:(NSString*)nameStart
               offset:(NSUInteger)offset
                limit:(NSUInteger)limit
           completion:(void(^)(NSArray *characters, NSInteger total, NSError *error))completion;

- (void)getComics:(NSString*)characterId
           offset:(NSUInteger)offset
            limit:(NSUInteger)limit
       completion:(void(^)(NSArray *comics, NSError *error))completion;

- (void)getImage:(NSString*)url
      completion:(void(^)(UIImage* image, NSError *error))completion;

@end
