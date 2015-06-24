//
//  BKOneCourseModel.m
//  BUKACH
//
//  Created by Lynn on 15/6/18.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKOneCourseModel.h"
#import "BKOneTeacherModel.h"

@implementation BKOneCourseModel

+(id)oneCourseWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
        
        //对数组的处理：依次转模型
        NSMutableArray * objs = [NSMutableArray array];
        for (NSDictionary * teacherDict in _teacher_arr)
        {
            BKOneTeacherModel * teacher = [BKOneTeacherModel oneTeacherWithDict:teacherDict];
            [objs addObject:teacher];
        }
        self.teacher_arr = objs;
    }
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@----course_name:%@, course_detail:%@, course_id:%@, course_photo:%@, course_intro:%@, teacher_arr:%@", [self class], _course_name, _course_detail, _course_id, _course_photo, _course_intro, _teacher_arr];
}

@end
