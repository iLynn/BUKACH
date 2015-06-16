//
//  BKCategoryResponse.h
//  BUKACH
//
//  Created by Lynn on 15/6/16.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKCategoryResponse : NSObject

/** 请求到的数据，里面存的是BKCategoryModel元素 */
@property (nonatomic, strong) NSArray * data;

/** 请求状态 */
@property (nonatomic, strong) NSString * code;

/** 快速创建 */
+(id)categoryResponseWithDict:(NSDictionary *)dict;
-(id)initWithDict:(NSDictionary *)dict;

@end
