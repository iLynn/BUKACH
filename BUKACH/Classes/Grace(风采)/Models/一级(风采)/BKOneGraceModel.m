//
//  BKOneGraceModel.m
//  BUKACH
//
//  Created by Lynn on 15/6/23.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKOneGraceModel.h"
//#import "BKGracePhotoModel.h"

@implementation BKOneGraceModel

+(id)oneGraceWithDict:(NSDictionary *)dict
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
    return [NSString stringWithFormat:@"%@----grace_title:%@, grace_id:%@, grace_photo:%@, img_width:%f, img_height:%f, grace_photo_array:%@", [self class], _grace_title, _grace_id, _grace_photo, _img_width, _img_height, _grace_photo_array];
}

@end
