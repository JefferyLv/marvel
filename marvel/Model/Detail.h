#import <UIKit/UIKit.h>
#import "Item.h"

@interface Detail : NSObject

@property (nonatomic, assign) NSInteger available;
@property (nonatomic, strong) NSString * collectionURI;
@property (nonatomic, strong) NSArray * items;
@property (nonatomic, assign) NSInteger returned;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
