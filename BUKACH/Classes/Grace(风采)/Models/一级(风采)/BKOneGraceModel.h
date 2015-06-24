//
//  BKOneGraceModel.h
//  BUKACH
//
//  Created by Lynn on 15/6/23.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKOneGraceModel : NSObject

/** 风采标题 */
@property (nonatomic, strong) NSString * grace_title;

/** 风采id */
@property (nonatomic, strong) NSString * grace_id;

/** 风采图片，是一个url地址的一部分 */
@property (nonatomic, strong) NSString * grace_photo;

/** 图片高度 */
@property (nonatomic, assign) CGFloat img_height;

/** 图片宽度 */
@property (nonatomic, assign) CGFloat img_width;



/** 图片高度 */
@property (nonatomic, assign) CGFloat grace_height;

/** 图片宽度 */
@property (nonatomic, assign) CGFloat grace_width;

/** 存放详细浏览时的所有图片 */
@property (nonatomic, strong) NSArray * grace_photo_array;


+(id)oneGraceWithDict:(NSDictionary *)dict;
-(id)initWithDict:(NSDictionary *)dict;

@end
