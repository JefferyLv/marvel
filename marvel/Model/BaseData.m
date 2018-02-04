
#import "BaseData.h"

NSString *const kDataCount = @"count";
NSString *const kDataLimit = @"limit";
NSString *const kDataOffset = @"offset";
NSString *const kDataResults = @"results";
NSString *const kDataTotal = @"total";
NSString *const kmavelData = @"data";

@interface BaseData ()
@end

@implementation BaseData


/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super initWithDictionary:dictionary];
    NSDictionary* data = dictionary[kmavelData];
	if(![data[kDataCount] isKindOfClass:[NSNull class]]){
		self.count = [data[kDataCount] integerValue];
	}
	if(![data[kDataLimit] isKindOfClass:[NSNull class]]){
		self.limit = [data[kDataLimit] integerValue];
	}
	if(![data[kDataOffset] isKindOfClass:[NSNull class]]){
		self.offset = [data[kDataOffset] integerValue];
	}
	if(![data[kDataTotal] isKindOfClass:[NSNull class]]){
		self.total = [data[kDataTotal] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSMutableDictionary *)toDictionary
{
    NSMutableDictionary * dictionary= [super toDictionary];
    
	NSMutableDictionary * data = [NSMutableDictionary dictionary];
	data[kDataCount] = @(self.count);
	data[kDataLimit] = @(self.limit);
	data[kDataOffset] = @(self.offset);
	data[kDataTotal] = @(self.total);
    dictionary[kmavelData] = data;
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
	[aCoder encodeObject:@(self.count) forKey:kDataCount];
    [aCoder encodeObject:@(self.limit) forKey:kDataLimit];
    [aCoder encodeObject:@(self.offset) forKey:kDataOffset];
	[aCoder encodeObject:@(self.total) forKey:kDataTotal];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.count = [[aDecoder decodeObjectForKey:kDataCount] integerValue];
	self.limit = [[aDecoder decodeObjectForKey:kDataLimit] integerValue];
	self.offset = [[aDecoder decodeObjectForKey:kDataOffset] integerValue];
	self.total = [[aDecoder decodeObjectForKey:kDataTotal] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	BaseData *copy = [BaseData new];

	copy.count = self.count;
	copy.limit = self.limit;
	copy.offset = self.offset;
	copy.total = self.total;

	return copy;
}
@end
