//
//  BKJobCell.h
//  BUKACH
//
//  Created by Lynn on 15/6/25.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BKOneJobModel, BKJobFrame;

@interface BKJobCell : UITableViewCell

@property (nonatomic, strong) BKOneJobModel * job;

@property (nonatomic, strong) BKJobFrame * cellFrame;


/** 快速创建一个cell */
+ (id)cellWithTableView:(UITableView *)tableView;

@end
