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
#import "BaseResponse.h"

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
        NSDictionary * json = [NSJSONSerialization JSONObjectWithData:data
                                                              options:NSJSONReadingMutableContainers
                                                                error:nil];
        BaseResponse* res = [[BaseResponse alloc] initWithDictionary:json];
        
        if (completion) {
            if (error) {
                completion(nil, 0, error);
            } else {
                completion(res.data.results, res.data.total, nil);
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
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            if (completion) completion(nil, error);
            return;
        }
        
        UIImage *img = [UIImage imageWithData:data];
//        [[ImageCache sharedCache] setImage:img forKey:image];
        dispatch_async(dispatch_get_main_queue(), ^{
//            self.avatar.image = img;
            if (completion) {
                completion(img, nil);
            }
        });
    }];
    [task resume];
}
@end
