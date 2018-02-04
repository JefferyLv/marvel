//
//  Items.m
//  marvel
//
//  Created by lvwei on 04/02/2018.
//  Copyright © 2018 lvwei. All rights reserved.
//

#import "Items.h"
#import "Item.h"

NSString *const kItemData = @"data";
NSString *const kItemResults = @"results";

@implementation Items

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */
-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    
    if(dictionary[kItemData][kItemResults] != nil && [dictionary[kItemData][kItemResults] isKindOfClass:[NSArray class]]){
        NSArray * resultsDictionaries = dictionary[kItemData][kItemResults];
        NSMutableArray * resultsItems = [NSMutableArray array];
        for(NSDictionary * resultsDictionary in resultsDictionaries){
            Item * resultsItem = [[Item alloc] initWithDictionary:resultsDictionary];
            [resultsItems addObject:resultsItem];
        }
        self.results = resultsItems;
    }
    return self;
}

/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSMutableDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [super toDictionary];
    
    if(self.results != nil){
        NSMutableArray * dictionaryElements = [NSMutableArray array];
        for(Item * resultsElement in self.results){
            [dictionaryElements addObject:[resultsElement toDictionary]];
        }
        dictionary[kItemData][kItemResults] = dictionaryElements;
    }
    
    return dictionary;
}

@end
