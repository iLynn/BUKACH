//
//  BKOneTeacherResponse.m
//  BUKACH
//
//  Created by Lynn on 15/6/19.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKOneTeacherResponse.h"
#import "BKOneTeacherModel.h"

@implementation BKOneTeacherResponse

+(id)oneTeacherResponseWithDict:(NSDictionary *)dict
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
        for (NSDictionary * teacherDict in _data)
        {
            BKOneTeacherModel * teacher = [BKOneTeacherModel oneTeacherWithDict:teacherDict];
            [objs addObject:teacher];
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
