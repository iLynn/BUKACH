//
//  BKAdsModel.h
//  BUKACH
//
//  Created by Lynn on 15/6/16.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKOneAdsModel : NSObject

/** 广告标题 */
@property (nonatomic, strong) NSString * ads_title;

/** 广告id */
@property (nonatomic, strong) NSString * ads_id;

/** 广告图片，是一个url地址的一部分 */
@property (nonatomic, strong) NSString * ads_photo;

#warning 是否提醒后台修改一致？
//以下是详细时用的
@property (nonatomic, strong) NSString * ad_text;

@property (nonatomic, strong) NSString * ad_id;

@property (nonatomic, strong) NSArray * hot_photo_array;


+(id)oneAdsWithDict:(NSDictionary *)dict;
-(id)initWithDict:(NSDictionary *)dict;

@end
