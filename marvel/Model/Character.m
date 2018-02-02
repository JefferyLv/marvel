
#import "Character.h"

NSString *const kResultComics = @"comics";
NSString *const kResultDescriptionField = @"description";
NSString *const kResultEvents = @"events";
NSString *const kResultIdField = @"id";
NSString *const kResultModified = @"modified";
NSString *const kResultName = @"name";
NSString *const kResultResourceURI = @"resourceURI";
NSString *const kResultSeries = @"series";
NSString *const kResultStories = @"stories";
NSString *const kResultThumbnail = @"thumbnail";
NSString *const kResultUrls = @"urls";

@interface Character ()
@end
@implementation Character




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kResultComics] isKindOfClass:[NSNull class]]){
		self.comics = [[Detail alloc] initWithDictionary:dictionary[kResultComics]];
	}

	if(![dictionary[kResultDescriptionField] isKindOfClass:[NSNull class]]){
		self.descriptionField = dictionary[kResultDescriptionField];
	}	
	if(![dictionary[kResultEvents] isKindOfClass:[NSNull class]]){
		self.events = [[Detail alloc] initWithDictionary:dictionary[kResultEvents]];
	}

	if(![dictionary[kResultIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kResultIdField] integerValue];
	}

	if(![dictionary[kResultModified] isKindOfClass:[NSNull class]]){
		self.modified = dictionary[kResultModified];
	}	
	if(![dictionary[kResultName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kResultName];
	}	
	if(![dictionary[kResultResourceURI] isKindOfClass:[NSNull class]]){
		self.resourceURI = dictionary[kResultResourceURI];
	}	
	if(![dictionary[kResultSeries] isKindOfClass:[NSNull class]]){
		self.series = [[Detail alloc] initWithDictionary:dictionary[kResultSeries]];
	}

	if(![dictionary[kResultStories] isKindOfClass:[NSNull class]]){
		self.stories = [[Detail alloc] initWithDictionary:dictionary[kResultStories]];
	}

	if(![dictionary[kResultThumbnail] isKindOfClass:[NSNull class]]){
		self.thumbnail = [[Thumbnail alloc] initWithDictionary:dictionary[kResultThumbnail]];
	}

	if(dictionary[kResultUrls] != nil && [dictionary[kResultUrls] isKindOfClass:[NSArray class]]){
		NSArray * urlsDictionaries = dictionary[kResultUrls];
		NSMutableArray * urlsItems = [NSMutableArray array];
		for(NSDictionary * urlsDictionary in urlsDictionaries){
			Url * urlsItem = [[Url alloc] initWithDictionary:urlsDictionary];
			[urlsItems addObject:urlsItem];
		}
		self.urls = urlsItems;
	}
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.comics != nil){
		dictionary[kResultComics] = [self.comics toDictionary];
	}
	if(self.descriptionField != nil){
		dictionary[kResultDescriptionField] = self.descriptionField;
	}
	if(self.events != nil){
		dictionary[kResultEvents] = [self.events toDictionary];
	}
	dictionary[kResultIdField] = @(self.idField);
	if(self.modified != nil){
		dictionary[kResultModified] = self.modified;
	}
	if(self.name != nil){
		dictionary[kResultName] = self.name;
	}
	if(self.resourceURI != nil){
		dictionary[kResultResourceURI] = self.resourceURI;
	}
	if(self.series != nil){
		dictionary[kResultSeries] = [self.series toDictionary];
	}
	if(self.stories != nil){
		dictionary[kResultStories] = [self.stories toDictionary];
	}
	if(self.thumbnail != nil){
		dictionary[kResultThumbnail] = [self.thumbnail toDictionary];
	}
	if(self.urls != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(Url * urlsElement in self.urls){
			[dictionaryElements addObject:[urlsElement toDictionary]];
		}
		dictionary[kResultUrls] = dictionaryElements;
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
	if(self.comics != nil){
		[aCoder encodeObject:self.comics forKey:kResultComics];
	}
	if(self.descriptionField != nil){
		[aCoder encodeObject:self.descriptionField forKey:kResultDescriptionField];
	}
	if(self.events != nil){
		[aCoder encodeObject:self.events forKey:kResultEvents];
	}
	[aCoder encodeObject:@(self.idField) forKey:kResultIdField];	if(self.modified != nil){
		[aCoder encodeObject:self.modified forKey:kResultModified];
	}
	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:kResultName];
	}
	if(self.resourceURI != nil){
		[aCoder encodeObject:self.resourceURI forKey:kResultResourceURI];
	}
	if(self.series != nil){
		[aCoder encodeObject:self.series forKey:kResultSeries];
	}
	if(self.stories != nil){
		[aCoder encodeObject:self.stories forKey:kResultStories];
	}
	if(self.thumbnail != nil){
		[aCoder encodeObject:self.thumbnail forKey:kResultThumbnail];
	}
	if(self.urls != nil){
		[aCoder encodeObject:self.urls forKey:kResultUrls];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.comics = [aDecoder decodeObjectForKey:kResultComics];
	self.descriptionField = [aDecoder decodeObjectForKey:kResultDescriptionField];
	self.events = [aDecoder decodeObjectForKey:kResultEvents];
	self.idField = [[aDecoder decodeObjectForKey:kResultIdField] integerValue];
	self.modified = [aDecoder decodeObjectForKey:kResultModified];
	self.name = [aDecoder decodeObjectForKey:kResultName];
	self.resourceURI = [aDecoder decodeObjectForKey:kResultResourceURI];
	self.series = [aDecoder decodeObjectForKey:kResultSeries];
	self.stories = [aDecoder decodeObjectForKey:kResultStories];
	self.thumbnail = [aDecoder decodeObjectForKey:kResultThumbnail];
	self.urls = [aDecoder decodeObjectForKey:kResultUrls];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Character *copy = [Character new];

	copy.comics = [self.comics copy];
	copy.descriptionField = [self.descriptionField copy];
	copy.events = [self.events copy];
	copy.idField = self.idField;
	copy.modified = [self.modified copy];
	copy.name = [self.name copy];
	copy.resourceURI = [self.resourceURI copy];
	copy.series = [self.series copy];
	copy.stories = [self.stories copy];
	copy.thumbnail = [self.thumbnail copy];
	copy.urls = [self.urls copy];

	return copy;
}
@end
