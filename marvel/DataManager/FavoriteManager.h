//
//  Favorites.h
//  marvel
//
//  Created by lvwei on 02/02/2018.
//  Copyright © 2018 lvwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Character.h"

@interface FavoriteManager : NSObject

+ (instancetype)sharedInstance;

- (NSArray*)all;
- (void)add:(Character *)character;
- (void)remove:(Character *)character;
- (BOOL)isFavorited:(Character *)character;

- (void)persist;
- (void)restore;

@end
