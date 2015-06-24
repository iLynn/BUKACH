//
//  BKOneGraceModel.m
//  BUKACH
//
//  Created by Lynn on 15/6/23.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKOneGraceModel.h"
#import "BKGracePhotoModel.h"

@implementation BKOneGraceModel

+(id)oneGraceWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
//        self.grace_id = dict[@"grace_id"];
//        self.grace_title = dict[@"grace_title"];
//        self.grace_photo = dict[@"grace_photo"];
//        self.grace_photo_array = dict[@"grace_photo_array"];
//        self.img_height
        
        //对数组的处理：依次转模型
        NSMutableArray * objs = [NSMutableArray array];
        for (NSDictionary * photoDict in _grace_photo_array)
        {
            BKGracePhotoModel * photo = [BKGracePhotoModel gracePhotoWithDict:photoDict];
            [objs addObject:photo];
        }
        self.grace_photo_array = objs;
        
    }
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@----grace_title:%@, grace_id:%@, grace_photo:%@, img_width:%f, img_height:%f, grace_photo_array:%@", [self class], _grace_title, _grace_id, _grace_photo, _img_width, _img_height, _grace_photo_array];
}

@end
