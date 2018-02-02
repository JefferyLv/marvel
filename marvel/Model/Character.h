#import <UIKit/UIKit.h>

#import "Detail.h"
#import "Thumbnail.h"
#import "Url.h"

@interface Character : NSObject

@property (nonatomic, strong) Detail * comics;
@property (nonatomic, strong) NSString * descriptionField;
@property (nonatomic, strong) Detail * events;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSString * modified;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * resourceURI;
@property (nonatomic, strong) Detail * series;
@property (nonatomic, strong) Detail * stories;
@property (nonatomic, strong) Thumbnail * thumbnail;
@property (nonatomic, strong) NSArray * urls;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
