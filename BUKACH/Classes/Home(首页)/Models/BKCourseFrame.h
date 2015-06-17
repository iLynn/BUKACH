//
//  BKCourseFrame.h
//  BUKACH
//
//  Created by Lynn on 15/6/17.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BKCourseModel;

@interface BKCourseFrame : NSObject

/** 图片的frame */
@property (nonatomic, assign) CGRect iconFrame;

/** 名称的frame */
@property (nonatomic, assign) CGRect nameFrame;

/** 介绍的frame */
@property (nonatomic, assign) CGRect introFrame;

/** 自己的高度 */
@property (nonatomic, assign) CGFloat cellHeight;


/** 根据BKCourseModel的数据，计算frame */
@property (nonatomic, strong) BKCourseModel * course;

@end
