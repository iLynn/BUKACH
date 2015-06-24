//
//  BKCategoryModel.h
//  BUKACH
//
//  Created by Lynn on 15/6/16.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKOneCategoryModel : NSObject

/** 分类名 */
@property (nonatomic, strong) NSString * category_name;

/** 分类id */
@property (nonatomic, strong) NSString * category_id;

/** 分类图片，是一个url地址的一部分 */
@property (nonatomic, strong) NSString * category_photo;


+(id)oneCategoryWithDict:(NSDictionary *)dict;
-(id)initWithDict:(NSDictionary *)dict;

@end
