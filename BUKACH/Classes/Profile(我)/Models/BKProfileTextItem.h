//
//  BKProfileTextItem.h
//  BUKACH
//
//  Created by Lynn on 15/6/15.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKProfileItem.h"

@interface BKProfileTextItem : BKProfileItem

/** 附带文本 */
@property (nonatomic, copy) NSString * customerText;

// 快速创建
- (instancetype)initWithIcon:(NSString *)icon andTitle:(NSString *)title andText:(NSString *)customerText;

@end
