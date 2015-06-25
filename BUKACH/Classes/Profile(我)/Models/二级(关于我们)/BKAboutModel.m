//
//  BKAboutModel.m
//  BUKACH
//
//  Created by Lynn on 15/6/25.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKAboutModel.h"

@implementation BKAboutModel

+(id)aboutWithDict:(NSDictionary *)dict
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
    return [NSString stringWithFormat:@"%@----about_us_detail:%@", [self class], _about_us_detail];
}


@end
