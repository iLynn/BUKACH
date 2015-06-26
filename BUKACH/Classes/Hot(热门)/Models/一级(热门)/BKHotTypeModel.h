//
//  BKHotTypeModel.h
//  BUKACH
//
//  Created by Lynn on 15/6/26.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKHotTypeModel : NSObject

/** 热门分类名字 */
@property (nonatomic, strong) NSString * hot_type_name;

/** 热门分类id */
@property (nonatomic, strong) NSString * hot_type_id;

/** 分类里的具体内容，里面存放的是oneHotModel模型对象 */
@property (nonatomic, strong) NSArray * type_content;


@property (nonatomic, assign) BOOL moreFlag;


+(id)hotTypeWithDict:(NSDictionary *)dict;
-(id)initWithDict:(NSDictionary *)dict;

@end
