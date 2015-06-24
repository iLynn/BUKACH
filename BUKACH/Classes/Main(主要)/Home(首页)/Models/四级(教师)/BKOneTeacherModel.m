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
        
        //把教师的课程等级进行一次映射转换
        if (_teacher_level.integerValue == 1)
        {
            _teacher_level = @"一级教师";
        }
        else if (self.teacher_level.integerValue == 2)
        {
            _teacher_level = @"二级教师";
        }
    }
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@----teacher_id:%@, teacher_name:%@, teacher_style:%@, teacher_photo:%@, teacher_experience:%@, teacher_students:%@, teacher_level:%@, teacher_award:%@, teacher_detail:%@, teacher_graduate_school:%@", [self class], _teacher_id, _teacher_name, _teacher_style, _teacher_photo, _teacher_experience, _teacher_students, _teacher_level, _teacher_award, _teacher_detail, _teacher_graduate_school];
}

@end
