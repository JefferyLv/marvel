
#import "BaseResponse.h"

NSString *const kmavelAttributionHTML = @"attributionHTML";
NSString *const kmavelAttributionText = @"attributionText";
NSString *const kmavelCode = @"code";
NSString *const kmavelCopyright = @"copyright";
NSString *const kmavelEtag = @"etag";
NSString *const kmavelStatus = @"status";

@interface BaseResponse ()
@end
@implementation BaseResponse




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kmavelAttributionHTML] isKindOfClass:[NSNull class]]){
		self.attributionHTML = dictionary[kmavelAttributionHTML];
	}	
	if(![dictionary[kmavelAttributionText] isKindOfClass:[NSNull class]]){
		self.attributionText = dictionary[kmavelAttributionText];
	}	
	if(![dictionary[kmavelCode] isKindOfClass:[NSNull class]]){
		self.code = [dictionary[kmavelCode] integerValue];
	}
	if(![dictionary[kmavelCopyright] isKindOfClass:[NSNull class]]){
		self.copyright = dictionary[kmavelCopyright];
	}
	if(![dictionary[kmavelEtag] isKindOfClass:[NSNull class]]){
		self.etag = dictionary[kmavelEtag];
	}	
	if(![dictionary[kmavelStatus] isKindOfClass:[NSNull class]]){
		self.status = dictionary[kmavelStatus];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSMutableDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.attributionHTML != nil){
		dictionary[kmavelAttributionHTML] = self.attributionHTML;
	}
	if(self.attributionText != nil){
		dictionary[kmavelAttributionText] = self.attributionText;
	}
	dictionary[kmavelCode] = @(self.code);
	if(self.copyright != nil){
		dictionary[kmavelCopyright] = self.copyright;
	}
	if(self.etag != nil){
		dictionary[kmavelEtag] = self.etag;
	}
	if(self.status != nil){
		dictionary[kmavelStatus] = self.status;
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
	if(self.attributionHTML != nil){
		[aCoder encodeObject:self.attributionHTML forKey:kmavelAttributionHTML];
	}
	if(self.attributionText != nil){
		[aCoder encodeObject:self.attributionText forKey:kmavelAttributionText];
	}
	[aCoder encodeObject:@(self.code) forKey:kmavelCode];	if(self.copyright != nil){
		[aCoder encodeObject:self.copyright forKey:kmavelCopyright];
	}
	if(self.etag != nil){
		[aCoder encodeObject:self.etag forKey:kmavelEtag];
	}
	if(self.status != nil){
		[aCoder encodeObject:self.status forKey:kmavelStatus];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.attributionHTML = [aDecoder decodeObjectForKey:kmavelAttributionHTML];
	self.attributionText = [aDecoder decodeObjectForKey:kmavelAttributionText];
	self.code = [[aDecoder decodeObjectForKey:kmavelCode] integerValue];
	self.copyright = [aDecoder decodeObjectForKey:kmavelCopyright];
	self.etag = [aDecoder decodeObjectForKey:kmavelEtag];
	self.status = [aDecoder decodeObjectForKey:kmavelStatus];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	BaseResponse *copy = [BaseResponse new];

	copy.attributionHTML = [self.attributionHTML copy];
	copy.attributionText = [self.attributionText copy];
	copy.code = self.code;
	copy.copyright = [self.copyright copy];
	copy.etag = [self.etag copy];
	copy.status = [self.status copy];

	return copy;
}
@end
