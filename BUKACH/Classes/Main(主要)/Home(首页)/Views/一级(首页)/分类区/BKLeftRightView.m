//
//  BKLRView.m
//  BUKACH
//
//  Created by Lynn on 15/6/16.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKLeftRightView.h"

@interface BKLeftRightView()

@end

@implementation BKLeftRightView

+ (id)leftRightView
{
    return [[self alloc] init];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.nameLab.textAlignment = NSTextAlignmentLeft;
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    //1.图片
    CGFloat imageH = BKCurrentHeight * 0.8;
    CGFloat imageW = imageH;
    CGFloat imageY = (BKCurrentHeight - imageH ) * 0.5;
    CGFloat imageX = imageY;
    
    self.iconView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    
    //2.文字
    CGFloat nameX = BKCurrentHeight;
    CGFloat nameY = imageY;
    CGFloat nameW = BKCurrentWidth - BKCurrentHeight;
    CGFloat nameH = imageH;
    
    self.nameLab.frame = CGRectMake(nameX, nameY, nameW, nameH);

    
}




@end
