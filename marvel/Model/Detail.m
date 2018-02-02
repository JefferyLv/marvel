
#import "Detail.h"

NSString *const kComicAvailable = @"available";
NSString *const kComicCollectionURI = @"collectionURI";
NSString *const kComicItems = @"items";
NSString *const kComicReturned = @"returned";

@interface Detail ()
@end
@implementation Detail




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kComicAvailable] isKindOfClass:[NSNull class]]){
		self.available = [dictionary[kComicAvailable] integerValue];
	}

	if(![dictionary[kComicCollectionURI] isKindOfClass:[NSNull class]]){
		self.collectionURI = dictionary[kComicCollectionURI];
	}	
	if(dictionary[kComicItems] != nil && [dictionary[kComicItems] isKindOfClass:[NSArray class]]){
		NSArray * itemsDictionaries = dictionary[kComicItems];
		NSMutableArray * itemsItems = [NSMutableArray array];
		for(NSDictionary * itemsDictionary in itemsDictionaries){
			Item * itemsItem = [[Item alloc] initWithDictionary:itemsDictionary];
			[itemsItems addObject:itemsItem];
		}
		self.items = itemsItems;
	}
	if(![dictionary[kComicReturned] isKindOfClass:[NSNull class]]){
		self.returned = [dictionary[kComicReturned] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kComicAvailable] = @(self.available);
	if(self.collectionURI != nil){
		dictionary[kComicCollectionURI] = self.collectionURI;
	}
	if(self.items != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(Item * itemsElement in self.items){
			[dictionaryElements addObject:[itemsElement toDictionary]];
		}
		dictionary[kComicItems] = dictionaryElements;
	}
	dictionary[kComicReturned] = @(self.returned);
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
	[aCoder encodeObject:@(self.available) forKey:kComicAvailable];	if(self.collectionURI != nil){
		[aCoder encodeObject:self.collectionURI forKey:kComicCollectionURI];
	}
	if(self.items != nil){
		[aCoder encodeObject:self.items forKey:kComicItems];
	}
	[aCoder encodeObject:@(self.returned) forKey:kComicReturned];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.available = [[aDecoder decodeObjectForKey:kComicAvailable] integerValue];
	self.collectionURI = [aDecoder decodeObjectForKey:kComicCollectionURI];
	self.items = [aDecoder decodeObjectForKey:kComicItems];
	self.returned = [[aDecoder decodeObjectForKey:kComicReturned] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Detail *copy = [Detail new];

	copy.available = self.available;
	copy.collectionURI = [self.collectionURI copy];
	copy.items = [self.items copy];
	copy.returned = self.returned;

	return copy;
}
@end
