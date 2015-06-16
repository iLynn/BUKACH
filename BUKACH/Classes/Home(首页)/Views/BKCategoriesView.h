//
//  BKCategoriesView.h
//  BUKACH
//
//  Created by Lynn on 15/6/16.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BKCategoryModel;

//对跳转事件的响应
@protocol BKCategoriesViewDelegate <NSObject>

- (void)jumpToCategoryWithModel:(BKCategoryModel *)category;

@end

@interface BKCategoriesView : UIView

/** 装有多个categories模型对象的数组 */
@property (nonatomic, strong) NSArray * categories;

@property (nonatomic, strong) id <BKCategoriesViewDelegate> delegate;

/** 快速创建的方法 */
+(id)categoriesView;

@end
