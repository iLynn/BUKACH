//
//  BKCategoryView.h
//  BUKACH
//
//  Created by Lynn on 15/6/16.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BKOneCategoryModel;

@interface BKCategoryView : UIButton

@property (nonatomic, weak) UIImageView * iconView;

@property (nonatomic, weak) UILabel * nameLab;

/** 用于填充view的模型 */
@property(nonatomic, strong) BKOneCategoryModel * category;

@end
