#import <UIKit/UIKit.h>

@interface BaseResponse : NSObject

@property (nonatomic, strong) NSString * attributionHTML;
@property (nonatomic, strong) NSString * attributionText;
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSString * copyright;
@property (nonatomic, strong) NSString * etag;
@property (nonatomic, strong) NSString * status;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSMutableDictionary *)toDictionary;
@end
