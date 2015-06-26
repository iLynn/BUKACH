//
//  BKHotResponse.m
//  BUKACH
//
//  Created by Lynn on 15/6/26.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKHotResponse.h"
#import "BKHotTypeModel.h"

@implementation BKHotResponse

+(id)hotResponseWithDict:(NSDictionary *)dict
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
        for (NSDictionary * typeDict in _data)
        {
            BKHotTypeModel * type = [BKHotTypeModel hotTypeWithDict:typeDict];
            [objs addObject:type];
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
