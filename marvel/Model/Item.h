#import <UIKit/UIKit.h>

@interface Item : NSObject

@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSString * desc;
@property (nonatomic, strong) NSString * resourceURI;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
