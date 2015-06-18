//
//  BKProfileArrowItem.m
//  BUKACH
//
//  Created by Lynn on 15/6/15.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKProfileArrowItem.h"

@implementation BKProfileArrowItem

- (instancetype)initWithIcon:(NSString *)icon andTitle:(NSString *)title andDestClass:(Class)destVc
{
    if (self = [super initWithIcon:icon andTitle:title])
    {
        self.destVC = destVc;
    }
    
    return self;
}

@end
