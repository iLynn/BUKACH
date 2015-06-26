//
//  BKOneHotModel.m
//  BUKACH
//
//  Created by Lynn on 15/6/26.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKOneHotModel.h"

@implementation BKOneHotModel

+(id)oneHotWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];

    }
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@----hot_photo:%@, hot_date:%@, hot_title:%@, hot_id:%@, hot_name:%@, hot_photo_array:%@", [self class], _hot_photo, _hot_date, _hot_title, _hot_id, _hot_name, _hot_photo_array];
}

@end
