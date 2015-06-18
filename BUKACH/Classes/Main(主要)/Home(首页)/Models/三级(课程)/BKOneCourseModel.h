//
//  BKOneCourseModel.h
//  BUKACH
//
//  Created by Lynn on 15/6/18.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKOneCourseModel : NSObject

/** 课程名 */
@property (nonatomic, strong) NSString * course_name;

/** 课程详细 */
@property (nonatomic, strong) NSString * course_detail;

/** 课程id */
@property (nonatomic, strong) NSString * course_id;

/** 课程图片，是一个url地址的一部分 */
@property (nonatomic, strong) NSString * course_photo;

/** 课程简介 */
@property (nonatomic, strong) NSString * course_intro;

/** 课程有关的教师：数组里存的是BKTeacherModel对象 */
@property (nonatomic, strong) NSArray * teacher_arr;


+(id)oneCourseWithDict:(NSDictionary *)dict;
-(id)initWithDict:(NSDictionary *)dict;

@end
