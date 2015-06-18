//
//  BKProfileArrowItem.h
//  BUKACH
//
//  Created by Lynn on 15/6/15.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKProfileItem.h"

@interface BKProfileArrowItem : BKProfileItem

/** 目标控制器 */
@property (nonatomic, assign) Class destVC;

// 快速创建
- (instancetype)initWithIcon:(NSString *)icon andTitle:(NSString *)title andDestClass:(Class)destVc;

@end
