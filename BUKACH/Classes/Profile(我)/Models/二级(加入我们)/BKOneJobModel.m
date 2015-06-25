//
//  BKOneJobModel.m
//  BUKACH
//
//  Created by Lynn on 15/6/25.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKOneJobModel.h"

@implementation BKOneJobModel

+(id)oneJobWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@----job_name:%@, job_quota:%@, job_type:%@, job_detail:%@, job_deadline:%@", [self class], _job_name, _job_quota, _job_type, _job_detail, _job_deadline];
}

@end
