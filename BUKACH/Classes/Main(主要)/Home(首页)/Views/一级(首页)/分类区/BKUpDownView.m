//
//  BKUDView.m
//  BUKACH
//
//  Created by Lynn on 15/6/16.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKUpDownView.h"

@implementation BKUpDownView

+(id)upDownView
{
    return [[self alloc] init];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.nameLab.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    //1.图片
    CGFloat imageH = BKCurrentHeight * 0.4;
    CGFloat imageW = imageH;
    CGFloat imageY = BKCurrentHeight * 0.5 - imageH;
    CGFloat imageX = (BKCurrentWidth - imageW) * 0.5;
    
    self.iconView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    
    //2.文字
    CGFloat nameX = 0;
    CGFloat nameY = BKCurrentHeight * 0.5;
    CGFloat nameW = BKCurrentWidth;
    CGFloat nameH = nameY;
    
    self.nameLab.frame = CGRectMake(nameX, nameY, nameW, nameH);
    
    
    
}



@end
