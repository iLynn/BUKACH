//
//  BKProfileGroup.h
//  BUKACH
//
//  Created by Lynn on 15/6/15.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKProfileGroup : NSObject

/** 头部标题 */
@property (nonatomic, copy) NSString * headerTitle;

/** 底部标题 */
@property (nonatomic, copy) NSString * footerTitle;
/**
 *  当前分组中所有行的数据(保存的是BKProfileItem模型)
 */
@property (nonatomic, strong) NSArray * items;

@end
