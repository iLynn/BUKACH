//
//  BKOneTeacherModel.m
//  BUKACH
//
//  Created by Lynn on 15/6/18.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKOneTeacherModel.h"

@implementation BKOneTeacherModel

+(id)oneTeacherWithDict:(NSDictionary *)dict
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
    return [NSString stringWithFormat:@"%@----teacher_id:%@, teacher_name:%@, teacher_style:%@, teacher_photo:%@, teacher_experience:%@, teacher_students:%@, teacher_level:%@, teacher_award:%@, teacher_detail:%@", [self class], _teacher_id, _teacher_name, _teacher_style, _teacher_photo, _teacher_experience, _teacher_students, _teacher_level, _teacher_award, _teacher_detail];
}

@end
