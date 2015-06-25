//
//  BKProfileItem.h
//  BUKACH
//
//  Created by Lynn on 15/6/15.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef  void (^optionBlcok)();

@interface BKProfileItem : NSObject

/** 图标 */
@property (nonatomic, copy) NSString * icon;

/** 标题 */
@property (nonatomic, copy) NSString * tilte;


/** 定义block保存将来要执行的代码 */
@property (nonatomic, copy) optionBlcok option;

/** 快速创建的方法 */
- (instancetype)initWithIcon:(NSString *)icon andTitle:(NSString *)title;

@end
