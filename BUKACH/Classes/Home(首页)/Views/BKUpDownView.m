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

/**
 *  重写方法，设置图片的位置：左边
 *
 *  @param contentRect 整个button的frame
 *
 *  @return 图片的frame
 */
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageY = 0;
    CGFloat imageW = contentRect.size.height / 2;
    CGFloat imageH = imageW;
    CGFloat imageX = (contentRect.size.width - imageW ) / 2;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}

/**
 *  重写方法，设置文字的位置：右边
 *
 *  @param contentRect 整个button的frame
 *
 *  @return 文字的frame
 */
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = contentRect.size.height / 2;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = titleY;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
}

@end
