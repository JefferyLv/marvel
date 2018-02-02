
#import "Data.h"

NSString *const kDataCount = @"count";
NSString *const kDataLimit = @"limit";
NSString *const kDataOffset = @"offset";
NSString *const kDataResults = @"results";
NSString *const kDataTotal = @"total";

@interface Data ()
@end
@implementation Data




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kDataCount] isKindOfClass:[NSNull class]]){
		self.count = [dictionary[kDataCount] integerValue];
	}

	if(![dictionary[kDataLimit] isKindOfClass:[NSNull class]]){
		self.limit = [dictionary[kDataLimit] integerValue];
	}

	if(![dictionary[kDataOffset] isKindOfClass:[NSNull class]]){
		self.offset = [dictionary[kDataOffset] integerValue];
	}

	if(dictionary[kDataResults] != nil && [dictionary[kDataResults] isKindOfClass:[NSArray class]]){
		NSArray * resultsDictionaries = dictionary[kDataResults];
		NSMutableArray * resultsItems = [NSMutableArray array];
		for(NSDictionary * resultsDictionary in resultsDictionaries){
			Character * resultsItem = [[Character alloc] initWithDictionary:resultsDictionary];
			[resultsItems addObject:resultsItem];
		}
		self.results = resultsItems;
	}
	if(![dictionary[kDataTotal] isKindOfClass:[NSNull class]]){
		self.total = [dictionary[kDataTotal] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kDataCount] = @(self.count);
	dictionary[kDataLimit] = @(self.limit);
	dictionary[kDataOffset] = @(self.offset);
	if(self.results != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(Character * resultsElement in self.results){
			[dictionaryElements addObject:[resultsElement toDictionary]];
		}
		dictionary[kDataResults] = dictionaryElements;
	}
	dictionary[kDataTotal] = @(self.total);
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
	[aCoder encodeObject:@(self.count) forKey:kDataCount];	[aCoder encodeObject:@(self.limit) forKey:kDataLimit];	[aCoder encodeObject:@(self.offset) forKey:kDataOffset];	if(self.results != nil){
		[aCoder encodeObject:self.results forKey:kDataResults];
	}
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
	self.results = [aDecoder decodeObjectForKey:kDataResults];
	self.total = [[aDecoder decodeObjectForKey:kDataTotal] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Data *copy = [Data new];

	copy.count = self.count;
	copy.limit = self.limit;
	copy.offset = self.offset;
	copy.results = [self.results copy];
	copy.total = self.total;

	return copy;
}
@end
