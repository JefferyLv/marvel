//
//  ImageCache.m
//  marvel
//
//  Created by lvwei on 02/02/2018.
//  Copyright © 2018 lvwei. All rights reserved.
//

#import "ImageCache.h"
#import "NSString+MD5.h"

@implementation ImageCache {
    NSCache  *_memoryCaches;
    NSString *_rootDirectory;
    dispatch_queue_t _ioQueue;
}

#pragma mark <Initializing the cache>

+ (ImageCache*)sharedCache
{
    static ImageCache *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ImageCache alloc] initWithName:@"shared"];
    });
    return instance;
}

- (instancetype)initWithName:(NSString*)name
{
    self = [super init];
    if (self)
    {
        // Raise the count will take more memory consumption.In my observation,
        // memory will be limited about 150MB when count is set to 50 and about 100MB when it's 20
        _memoryCaches = [NSCache new];
        _memoryCaches.countLimit = 50;
        
        NSString *cachesDirectory = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
        NSString *pathComponent = @"com.free.marvel";
        NSString *path = [cachesDirectory stringByAppendingPathComponent:pathComponent];
        _rootDirectory = [path stringByAppendingPathComponent:name];
        
        NSFileManager *fileManager = NSFileManager.new;
        if (![fileManager fileExistsAtPath:_rootDirectory])
        {
            [fileManager createDirectoryAtPath:_rootDirectory
                   withIntermediateDirectories:YES
                                    attributes:nil
                                         error:NULL];
        }
        
        _ioQueue = dispatch_queue_create("com.free.marvel", DISPATCH_QUEUE_SERIAL);
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didReceiveMemoryWarning:)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidReceiveMemoryWarningNotification
                                                  object:nil];
}

- (void)didReceiveMemoryWarning:(NSNotification*)notification
{
    [_memoryCaches removeAllObjects];
}

#pragma mark <Accessing the cache>

- (void)setImage:(UIImage*)image forKey:(NSString*)key
{
    NSString* md5Key = [NSString MD5:key];

    // Cache the images in memory for better performance...
    if (image)
    {
        [_memoryCaches setObject:image forKey:md5Key];
    }
    else
    {
        [_memoryCaches removeObjectForKey:md5Key];
    }
    
    // Cache the images in disk for second launch or memory warning case...
    dispatch_async(_ioQueue, ^{

        NSString *path = [_rootDirectory stringByAppendingPathComponent:md5Key];
        NSData *data = UIImageJPEGRepresentation(image, (CGFloat)1.0);
        NSFileManager *fileManager = NSFileManager.new;
        [fileManager createFileAtPath:path contents:data attributes:nil];
        
    });
}

- (void)getImage:(NSString*)key
         success:(void (^)(UIImage *image))successBlock
         failure:(void (^)(NSError *error))failureBlock
{
    NSString* md5Key = [NSString MD5:key];
    
     // First check the in-memory cache...
    UIImage *image = [_memoryCaches objectForKey:md5Key];
    if (image)
    {
        if (successBlock) successBlock(image);
    }
    
    // Second check the disk cache...
    dispatch_async(_ioQueue, ^{
        
        NSString *path = [_rootDirectory stringByAppendingPathComponent:md5Key];
        NSData *data = [NSData dataWithContentsOfFile:path];
        UIImage *image = [UIImage imageWithData:data];

        dispatch_async(dispatch_get_main_queue(), ^{
            if (image)
            {
                [_memoryCaches setObject:image forKey:md5Key];
                if (successBlock) successBlock(image);
            }
            else
            {
                // No hit in cache...
                if (failureBlock) failureBlock(nil);
            }
        });
    });
}

@end
