//
//  BKCategoryModel.m
//  BUKACH
//
//  Created by Lynn on 15/6/16.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKOneCategoryModel.h"

@implementation BKOneCategoryModel

+(id)oneCategoryWithDict:(NSDictionary *)dict
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
    return [NSString stringWithFormat:@"%@----category_name:%@, category_id:%@, category_photo:%@", [self class], _category_name, _category_id, _category_photo];
}

@end
