//
//  BKTeacherModel.m
//  BUKACH
//
//  Created by Lynn on 15/6/18.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKTeacherModel.h"

@implementation BKTeacherModel

+ (id)teacherWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@----teacher_id:%@, teacher_name:%@, teacher_level:%@, teahcer_photo_url:%@", [self class], _teacher_id, _teacher_name, _teacher_level, _teacher_photo_url];
}

@end
