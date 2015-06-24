//
//  BKCourseResponse.m
//  BUKACH
//
//  Created by Lynn on 15/6/16.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKCourseResponse.h"
#import "BKOneCourseModel.h"

@implementation BKCourseResponse

+(id)courseResponseWithDict:(NSDictionary *)dict
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
        for (NSDictionary * courseDict in _data)
        {
            BKOneCourseModel * course = [BKOneCourseModel oneCourseWithDict:courseDict];
            [objs addObject:course];
        }
        self.data = objs;
    }
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"data:%@, code:%@", _data, _code];
}

@end
