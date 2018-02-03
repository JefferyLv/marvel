//
//  Favorites.m
//  marvel
//
//  Created by lvwei on 02/02/2018.
//  Copyright © 2018 lvwei. All rights reserved.
//

#import "FavoriteManager.h"
#import "Character.h"

@interface FavoriteManager ()

@property (nonatomic, strong) NSMutableDictionary *characters;
@property (nonatomic, copy) NSString *persistantFile;

@end

@implementation FavoriteManager

+ (instancetype)sharedInstance
{
    static FavoriteManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[FavoriteManager alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.characters = [NSMutableDictionary new];
        
        NSString *cachesDirectory = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
        NSString *pathComponent = @"com.free.marvel";
        NSString *path = [cachesDirectory stringByAppendingPathComponent:pathComponent];
        NSString *fileName = @"favorites.json";
        self.persistantFile = [path stringByAppendingPathComponent:fileName];
    }
    return self;
}

- (NSArray<Character *> *)all
{
    return [self.characters allValues];
}

- (void)add:(Character *)character
{
    [self.characters setObject:character forKey:[NSNumber numberWithInteger:character.idField]];
}

- (void)remove:(Character *)character
{
    [self.characters removeObjectForKey:[NSNumber numberWithInteger:character.idField]];
}

- (BOOL)isFavorited:(Character *)character
{
    return [[self.characters allKeys] containsObject:[NSNumber numberWithInteger:character.idField]];
}

- (void)persist
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:self.persistantFile])
    {
        [fileManager createFileAtPath:self.persistantFile contents:nil attributes:nil];
    }
    
    [NSKeyedArchiver archiveRootObject:self.characters toFile:self.persistantFile];
}

- (void)restore
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:self.persistantFile])
    {
        self.characters = [NSKeyedUnarchiver unarchiveObjectWithFile:self.persistantFile];
    }
}

@end


