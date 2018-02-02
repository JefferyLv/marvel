
#import "Item.h"

NSString *const kItemName = @"name";
NSString *const kItemResourceURI = @"resourceURI";
NSString *const kItemType = @"type";

@interface Item ()
@end
@implementation Item




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kItemName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kItemName];
	}	
	if(![dictionary[kItemResourceURI] isKindOfClass:[NSNull class]]){
		self.resourceURI = dictionary[kItemResourceURI];
	}	
	if(![dictionary[kItemType] isKindOfClass:[NSNull class]]){
		self.type = dictionary[kItemType];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.name != nil){
		dictionary[kItemName] = self.name;
	}
	if(self.resourceURI != nil){
		dictionary[kItemResourceURI] = self.resourceURI;
	}
	if(self.type != nil){
		dictionary[kItemType] = self.type;
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
	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:kItemName];
	}
	if(self.resourceURI != nil){
		[aCoder encodeObject:self.resourceURI forKey:kItemResourceURI];
	}
	if(self.type != nil){
		[aCoder encodeObject:self.type forKey:kItemType];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.name = [aDecoder decodeObjectForKey:kItemName];
	self.resourceURI = [aDecoder decodeObjectForKey:kItemResourceURI];
	self.type = [aDecoder decodeObjectForKey:kItemType];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Item *copy = [Item new];

	copy.name = [self.name copy];
	copy.resourceURI = [self.resourceURI copy];
	copy.type = [self.type copy];

	return copy;
}
@end