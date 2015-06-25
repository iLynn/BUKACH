//
//  BKJobsResponse.m
//  BUKACH
//
//  Created by Lynn on 15/6/25.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKJobsResponse.h"
#import "BKOneJobModel.h"

@implementation BKJobsResponse

+(id)jobsResponseWithDict:(NSDictionary *)dict
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
        for (NSDictionary * jobDict in _data)
        {
            BKOneJobModel * job = [BKOneJobModel oneJobWithDict:jobDict];
            [objs addObject:job];
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
