//
//  Networking.h
//  marvel
//
//  Created by lvwei on 01/02/2018.
//  Copyright © 2018 lvwei. All rights reserved.
//

#import <UIKit/UIkit.h>

typedef NS_ENUM(NSUInteger, ItemType) {
    Comics = 0,
    Events,
    Stories,
    Series,
};

@interface MarvelService : NSObject

+ (instancetype)sharedInstance;

- (void)getCharacters:(NSString*)nameStart
               offset:(NSUInteger)offset
                limit:(NSUInteger)limit
           completion:(void(^)(NSArray *characters, NSInteger total, NSError *error))completion;

- (void)getItemByType:(ItemType)type
            character:(NSString*)characterId
               offset:(NSUInteger)offset
                limit:(NSUInteger)limit
           completion:(void(^)(NSArray *items, NSError *error))completion;

- (void)getImage:(NSString*)url
      completion:(void(^)(UIImage* image, NSError *error))completion;

@end
