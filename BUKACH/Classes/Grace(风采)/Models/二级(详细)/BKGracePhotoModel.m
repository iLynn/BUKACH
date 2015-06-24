//
//  BKGracePhotoModel.m
//  BUKACH
//
//  Created by Lynn on 15/6/24.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKGracePhotoModel.h"

@implementation BKGracePhotoModel

+(id)gracePhotoWithDict:(NSDictionary *)dict
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
    return [NSString stringWithFormat:@"%@----img_location:%@, img_width:%f, img_height:%f", [self class], _img_location, _img_width, _img_height];
}

@end
