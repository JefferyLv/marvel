#import <UIKit/UIKit.h>

@interface Url : NSObject

@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSString * url;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end