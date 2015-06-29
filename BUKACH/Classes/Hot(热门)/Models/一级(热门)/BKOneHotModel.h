//
//  BKOneHotModel.h
//  BUKACH
//
//  Created by Lynn on 15/6/26.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKOneHotModel : NSObject

/** 热门图片，是一个url地址的一部分 */
@property (nonatomic, strong) NSString * hot_photo;

/** 热门日期 */
@property (nonatomic, strong) NSString * hot_date;

/** 热门标题 */
@property (nonatomic, strong) NSString * hot_title;

/** 热门id */
@property (nonatomic, strong) NSString * hot_id;


/** 热门标题 */
@property (nonatomic, strong) NSString * hot_name;

/** 热门的一组图片 */
@property (nonatomic, strong) NSArray * hot_photo_array;


+(id)oneHotWithDict:(NSDictionary *)dict;
-(id)initWithDict:(NSDictionary *)dict;

@end
