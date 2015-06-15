//
//  BKProfileTextItem.m
//  BUKACH
//
//  Created by Lynn on 15/6/15.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKProfileTextItem.h"

@implementation BKProfileTextItem

- (instancetype)initWithIcon:(NSString *)icon andTitle:(NSString *)title andText:(NSString *)customerText
{
    if (self = [super initWithIcon:icon andTitle:title])
    {
        self.customerText = customerText;
    }
    
    return self;
}

@end
