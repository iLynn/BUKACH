//
//  BKTeacherModel.h
//  BUKACH
//
//  Created by Lynn on 15/6/18.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKTeacherModel : NSObject

/** 教师ID */
@property (nonatomic, strong) NSString * teacher_id;

/** 教师姓名 */
@property (nonatomic, strong) NSString * teacher_name;

/** 教师等级 */
@property (nonatomic, strong) NSString * teacher_level;

/** 教师照片，是url地址的一部分 */
@property (nonatomic, strong) NSString * teacher_photo_url;


+ (id)teacherWithDict:(NSDictionary *)dict;
- (id)initWithDict:(NSDictionary *)dict;

@end
