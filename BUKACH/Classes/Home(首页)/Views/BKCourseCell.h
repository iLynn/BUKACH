//
//  BKCourseCell.h
//  BUKACH
//
//  Created by Lynn on 15/6/16.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BKCourseModel, BKCourseFrame;

@interface BKCourseCell : UITableViewCell

@property (nonatomic, strong) BKCourseModel * course;

@property (nonatomic, strong) BKCourseFrame * cellFrame;

/** 快速创建一个cell */
+ (id)cellWithTableView:(UITableView *)tableView;

@end
