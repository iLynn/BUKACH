//
//  BKAdsModel.m
//  BUKACH
//
//  Created by Lynn on 15/6/16.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKOneAdsModel.h"

@implementation BKOneAdsModel

+(id)oneAdsWithDict:(NSDictionary *)dict
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
    return [NSString stringWithFormat:@"%@----ads_title:%@, ads_id:%@, ads_photo:%@, ad_text:%@, ad_id:%@, hot_photo_array:%@", [self class], _ads_title, _ads_id, _ads_photo, _ad_text, _ad_id, _hot_photo_array];
}

@end
