#import <UIKit/UIKit.h>

@interface Thumbnail : NSObject

@property (nonatomic, strong) NSString * extension;
@property (nonatomic, strong) NSString * path;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
-(NSString *)toString;
@end
