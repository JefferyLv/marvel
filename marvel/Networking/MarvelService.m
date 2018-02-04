//
//  Networking.m
//  marvel
//
//  Created by lvwei on 01/02/2018.
//  Copyright © 2018 lvwei. All rights reserved.
//

#import "MarvelService.h"
#import "NSString+MD5.h"

#import "Character.h"
#import "Characters.h"

#import "Item.h"
#import "Items.h"

static NSString * const HOST = @"https://gateway.marvel.com:443";

@interface MarvelService ()

@property (nonatomic, copy) NSString* publicKey;
@property (nonatomic, copy) NSString* privateKey;

@end

@implementation MarvelService

+ (instancetype)sharedInstance
{
    static MarvelService *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MarvelService alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        NSDictionary* infos = [[NSBundle mainBundle] infoDictionary];
        self.publicKey = infos[@"MarvelPublicKey"];
        self.privateKey = infos[@"MarvelPrivateKey"];
    }
    return self;
}

- (void)getCharacters:(NSString*)nameStart
               offset:(NSUInteger)offset
                limit:(NSUInteger)limit
           completion:(void(^)(NSArray *characters, NSInteger total, NSError *error))completion
{
    NSString *api = @"v1/public/characters";
    
    long currentTime = (long)(NSTimeInterval)([[NSDate date] timeIntervalSince1970]);

    NSString *stringToHash = [NSString stringWithFormat:@"%lu%@%@", currentTime, self.privateKey, self.publicKey];
    NSString *hash = [NSString MD5:stringToHash];

    NSString* endpoint = [NSString stringWithFormat:@"%@/%@?orderBy=name&limit=%ld&offset=%ld&apikey=%@&ts=%lu&&hash=%@", HOST, api, limit, offset, self.publicKey, currentTime, hash];
    
    if (nameStart && nameStart.length > 0) {
        endpoint = [endpoint stringByAppendingFormat:@"&nameStartsWith=%@", nameStart];
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:endpoint]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data,
                                                                NSURLResponse * _Nullable response,
                                                                NSError * _Nullable error) {
        if (!data) {
            if (completion) completion(nil, 0, error);
            return;
        }
                                                
        NSDictionary * json = [NSJSONSerialization JSONObjectWithData:data
                                                              options:NSJSONReadingMutableContainers
                                                                error:nil];
        Characters *res = [[Characters alloc] initWithDictionary:json];
        
        if (completion) {
            if (error) {
                completion(nil, 0, error);
            } else {
                completion(res.results, res.total, nil);
            }
            
        }
    }];
    
    [task resume];
}

- (void)getItemByType:(ItemType)type
            character:(NSString*)characterId
               offset:(NSUInteger)offset
                limit:(NSUInteger)limit
           completion:(void(^)(NSArray *items, NSError *error))completion
{
    switch (type) {
        case Comics:
            [self getItemsByApi:@"comics" character:characterId order:@"title" offset:offset limit:limit completion:completion];
            break;
        case Events:
            [self getItemsByApi:@"events" character:characterId order:@"name" offset:offset limit:limit completion:completion];
            break;
        case Stories:
            [self getItemsByApi:@"stories" character:characterId order:@"id" offset:offset limit:limit completion:completion];
            break;
        case Series:
            [self getItemsByApi:@"series" character:characterId order:@"title" offset:offset limit:limit completion:completion];
            break;
        default:
            break;
    }
}
- (void)getItemsByApi:(NSString*)api
             character:(NSString*)characterId
                 order:(NSString*)order
                offset:(NSUInteger)offset
                 limit:(NSUInteger)limit
            completion:(void(^)(NSArray *comics, NSError *error))completion
{
    long currentTime = (long)(NSTimeInterval)([[NSDate date] timeIntervalSince1970]);
    NSString *stringToHash = [NSString stringWithFormat:@"%lu%@%@", currentTime, self.privateKey, self.publicKey];
    NSString *hash = [NSString MD5:stringToHash];
    
    NSString* endpoint = [NSString stringWithFormat:@"%@/v1/public/characters/%@/%@?orderBy=%@&limit=%ld&offset=%ld&apikey=%@&ts=%lu&&hash=%@", HOST, characterId, api, order, limit, offset, self.publicKey, currentTime, hash];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:endpoint]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data,
                                                                NSURLResponse * _Nullable response,
                                                                NSError * _Nullable error) {
                                                if (!data) {
                                                    if (completion) completion(nil, error);
                                                    return;
                                                }
                                                NSDictionary * json = [NSJSONSerialization JSONObjectWithData:data
                                                                                                      options:NSJSONReadingMutableContainers
                                                                                                        error:nil];
                                                Items* res = [[Items alloc] initWithDictionary:json];
                                                
                                                if (completion) {
                                                    if (error) {
                                                        completion(nil, error);
                                                    } else {
                                                        completion(res.results, nil);
                                                    }
                                                    
                                                }
                                            }];
    
    [task resume];
}


- (void)getImage:(NSString*)url
      completion:(void(^)(UIImage* image, NSError *error))completion
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data,
                                                                NSURLResponse * _Nullable response,
                                                                NSError * _Nullable error) {
        if (error) {
            if (completion) completion(nil, error);
        } else {
            UIImage *img = [UIImage imageWithData:data];
            if (completion) completion(img, nil);
        }
                                                
    }];
    [task resume];
}
@end
