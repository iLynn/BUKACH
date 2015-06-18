//
//  BKProfileCell.h
//  BUKACH
//
//  Created by Lynn on 15/6/15.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BKProfileItem;

@interface BKProfileCell : UITableViewCell

/** 此cell涉及的模型 */
@property (nonatomic, strong) BKProfileItem * item;

/** 快速创建的方法 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
