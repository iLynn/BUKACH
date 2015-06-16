//
//  BKLRView.m
//  BUKACH
//
//  Created by Lynn on 15/6/16.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKLeftRightView.h"

@implementation BKLeftRightView

+(id)leftRightView
{
    return [[self alloc] init];
}

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //内部图标居中
        self.imageView.contentMode = UIViewContentModeCenter;
        self.adjustsImageWhenHighlighted = NO;
        
        //内部文字靠左对齐
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = BKNavigatorFont;
        [self setTitleColor:BKNavigatorColor forState:UIControlStateNormal];
        
    }
    return self;
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
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageH = contentRect.size.height;
    CGFloat imageW = imageH;
    
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
    CGFloat titleY = 0;
    CGFloat titleH = contentRect.size.height;
    CGFloat titleX = titleH;
    CGFloat titleW = contentRect.size.width - titleH;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
}


@end
