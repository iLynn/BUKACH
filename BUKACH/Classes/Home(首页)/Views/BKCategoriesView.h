//
//  BKCategoriesView.h
//  BUKACH
//
//  Created by Lynn on 15/6/16.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BKCategoriesView : UIView

/** 装有多个categories模型对象的数组 */
@property(nonatomic, strong) NSArray * categories;

/** 快速创建的方法 */
+(id)categoriesView;

@end
