//
//  BKGraceFrame.h
//  BUKACH
//
//  Created by Lynn on 15/6/23.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BKOneGraceModel;

@interface BKGraceFrame : NSObject

/** 标题的frame */
@property (nonatomic, assign) CGRect titleFrame;

/** 图片的frame */
@property (nonatomic, assign) CGRect photoFrame;


/** 自己的高度 */
@property (nonatomic, assign) CGFloat cellHeight;


/** 根据BKOneCourseModel的数据，计算frame */
@property (nonatomic, strong) BKOneGraceModel * grace;

@end
