//
//  BKHotTypeModel.m
//  BUKACH
//
//  Created by Lynn on 15/6/26.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKHotTypeModel.h"
#import "BKOneHotModel.h"

@implementation BKHotTypeModel

+(id)hotTypeWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
        
        //给moreFlag一个初始值
        self.moreFlag = NO;
        
        //对数组的处理：依次转模型
        NSMutableArray * objs = [NSMutableArray array];
        for (NSDictionary * hotDict in _type_content)
        {
            BKOneHotModel * hot = [BKOneHotModel oneHotWithDict:hotDict];
            [objs addObject:hot];
        }
        self.type_content = objs;
    }
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@----moreFlag:%d, hot_type_name:%@, hot_type_id:%@, type_content:%@, ", [self class], _moreFlag, _hot_type_name, _hot_type_id, _type_content];
}

@end
