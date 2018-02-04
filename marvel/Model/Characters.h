//
//  Characters.h
//  marvel
//
//  Created by lvwei on 04/02/2018.
//  Copyright © 2018 lvwei. All rights reserved.
//

#import "BaseData.h"

@interface Characters : BaseData

@property (nonatomic, strong) NSArray * results;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSMutableDictionary *)toDictionary;

@end
