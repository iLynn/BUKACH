//
//  BKGraceResponse.m
//  BUKACH
//
//  Created by Lynn on 15/6/23.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKGraceResponse.h"
#import "BKOneGraceModel.h"

@implementation BKGraceResponse

+(id)graceResponseWithDict:(NSDictionary *)dict
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
        for (NSDictionary * graceDict in _data)
        {
            BKOneGraceModel * grace = [BKOneGraceModel oneGraceWithDict:graceDict];
            [objs addObject:grace];
        }
        self.data = objs;
    }
    return self;
}

//重写description方法
-(NSString *)description
{
    return [NSString stringWithFormat:@"data:%@, code:%@", _data, _code];
}


@end
