//
//  BKJobFrame.h
//  BUKACH
//
//  Created by Lynn on 15/6/25.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BKOneJobModel;

@interface BKJobFrame : NSObject

/** 标题：名称+人数+全兼职 */
@property (nonatomic, assign) CGRect titleFrame;

/** 具体：招聘要求+工作内容 */
@property (nonatomic, assign) CGRect detailFrame;

/** 应聘通道 */
@property (nonatomic, assign) CGRect resumeFrame;

/** 职位有效期 */
@property (nonatomic, assign) CGRect timeFrame;

/** 自己的高度 */
@property (nonatomic, assign) CGFloat cellHeight;


/** 根据BKOneCourseModel的数据，计算frame */
@property (nonatomic, strong) BKOneJobModel * job;

@end
