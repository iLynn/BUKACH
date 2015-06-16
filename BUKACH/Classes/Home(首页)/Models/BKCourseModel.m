//
//  BKCourseModel.m
//  BUKACH
//
//  Created by Lynn on 15/6/16.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKCourseModel.h"

@implementation BKCourseModel

+(id)courseWithDict:(NSDictionary *)dict
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
    return [NSString stringWithFormat:@"%@----course_name:%@, course_id:%@, course_photo:%@, course_intro:%@", [self class], _course_name, _course_id, _course_photo, _course_intro];
}


@end
