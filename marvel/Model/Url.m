
#import "Url.h"

NSString *const kUrlType = @"type";
NSString *const kUrlUrl = @"url";

@interface Url ()
@end
@implementation Url




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kUrlType] isKindOfClass:[NSNull class]]){
		self.type = dictionary[kUrlType];
	}	
	if(![dictionary[kUrlUrl] isKindOfClass:[NSNull class]]){
		self.url = dictionary[kUrlUrl];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.type != nil){
		dictionary[kUrlType] = self.type;
	}
	if(self.url != nil){
		dictionary[kUrlUrl] = self.url;
	}
	return dictionary;

}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	if(self.type != nil){
		[aCoder encodeObject:self.type forKey:kUrlType];
	}
	if(self.url != nil){
		[aCoder encodeObject:self.url forKey:kUrlUrl];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.type = [aDecoder decodeObjectForKey:kUrlType];
	self.url = [aDecoder decodeObjectForKey:kUrlUrl];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Url *copy = [Url new];

	copy.type = [self.type copy];
	copy.url = [self.url copy];

	return copy;
}
@end