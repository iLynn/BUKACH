//
//  BKTeacherView.h
//  BUKACH
//
//  Created by Lynn on 15/6/18.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BKTeacherModel;

@interface BKTeacherView : UIButton

/** 填充UI用的模型 */
@property (nonatomic, strong) BKTeacherModel * teacher;


+ (id)teacherView;

@end
