//
//  BKAdsResponse.m
//  BUKACH
//
//  Created by Lynn on 15/6/16.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKAdsResponse.h"
#import "BKOneAdsModel.h"

@implementation BKAdsResponse

+(id)adsResponseWithDict:(NSDictionary *)dict
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
        for (NSDictionary * adsDict in _data)
        {
            BKOneAdsModel * ads = [BKOneAdsModel oneAdsWithDict:adsDict];
            [objs addObject:ads];
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
