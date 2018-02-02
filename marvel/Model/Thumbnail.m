
#import "Thumbnail.h"

NSString *const kThumbnailExtension = @"extension";
NSString *const kThumbnailPath = @"path";

@interface Thumbnail ()
@end
@implementation Thumbnail



-(NSString *)toString
{
    return [NSString stringWithFormat:@"%@.%@", self.path, self.extension];
}
/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kThumbnailExtension] isKindOfClass:[NSNull class]]){
		self.extension = dictionary[kThumbnailExtension];
	}	
	if(![dictionary[kThumbnailPath] isKindOfClass:[NSNull class]]){
		self.path = dictionary[kThumbnailPath];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.extension != nil){
		dictionary[kThumbnailExtension] = self.extension;
	}
	if(self.path != nil){
		dictionary[kThumbnailPath] = self.path;
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
	if(self.extension != nil){
		[aCoder encodeObject:self.extension forKey:kThumbnailExtension];
	}
	if(self.path != nil){
		[aCoder encodeObject:self.path forKey:kThumbnailPath];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.extension = [aDecoder decodeObjectForKey:kThumbnailExtension];
	self.path = [aDecoder decodeObjectForKey:kThumbnailPath];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Thumbnail *copy = [Thumbnail new];

	copy.extension = [self.extension copy];
	copy.path = [self.path copy];

	return copy;
}
@end
