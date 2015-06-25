//
//  BKAboutResponse.m
//  BUKACH
//
//  Created by Lynn on 15/6/25.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKAboutResponse.h"
#import "BKAboutModel.h"

@implementation BKAboutResponse

+(id)aboutResponseWithDict:(NSDictionary *)dict
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
        for (NSDictionary * aboutDict in _data)
        {
            BKAboutModel * about = [BKAboutModel aboutWithDict:aboutDict];
            [objs addObject:about];
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
