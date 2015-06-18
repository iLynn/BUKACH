//
//  BKProfileItem.m
//  BUKACH
//
//  Created by Lynn on 15/6/15.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKProfileItem.h"

@implementation BKProfileItem

- (instancetype)initWithIcon:(NSString *)icon andTitle:(NSString *)title
{
    if (self = [super init])
    {
        self.icon = icon;
        self.tilte = title;
    }
    return self;
    
}

@end
