//
//  BKCourseModel.h
//  BUKACH
//
//  Created by Lynn on 15/6/16.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKCourseModel : NSObject

/** 课程名 */
@property (nonatomic, strong) NSString * course_name;

/** 课程id */
@property (nonatomic, strong) NSString * course_id;

/** 课程图片，是一个url地址的一部分 */
@property (nonatomic, strong) NSString * course_photo;

/** 课程简介 */
@property (nonatomic, strong) NSString * course_intro;


+(id)courseWithDict:(NSDictionary *)dict;
-(id)initWithDict:(NSDictionary *)dict;

@end
