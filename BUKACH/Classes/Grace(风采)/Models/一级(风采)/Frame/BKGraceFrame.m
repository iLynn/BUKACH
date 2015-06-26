//
//  BKGraceFrame.m
//  BUKACH
//
//  Created by Lynn on 15/6/23.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKGraceFrame.h"
#import "BKOneGraceModel.h"

//#define BKBaseWidth ceilf((BKScreenWidth - 3 * BKCustomMargin) / 2)


@interface BKGraceFrame()

@property (nonatomic, assign) CGFloat titleHeight;

@property (nonatomic, assign) CGFloat photoHeight;

@end

@implementation BKGraceFrame

- (void)setGrace:(BKOneGraceModel *)grace
{
    _grace = grace;
    
    //计算高度
    [self computeHeight];
    
    //计算frame
    [self setupFrame];
    
}

- (void)computeHeight
{
    //1.title部分
    NSMutableDictionary * dictTitle = [NSMutableDictionary dictionary];
    dictTitle[NSFontAttributeName] = BKCustomFont;
    
    //宽度占屏幕宽度的一半
    CGSize maxSize = CGSizeMake(BKHalfWidth - 2 * BKCustomMargin, MAXFLOAT);
    CGRect rectName = [self.grace.grace_title boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dictTitle context:nil];
    
    self.titleHeight = ceilf(rectName.size.height);
    
    
    //2.photo部分
    CGFloat imgH = self.grace.img_height;
    CGFloat imgW = self.grace.img_width;
    
    self.photoHeight = BKHalfWidth * imgH / imgW;
    
    
    self.cellHeight = self.titleHeight + self.photoHeight + BKCustomMargin * 2;
    
}

- (void)setupFrame
{
    //1.先图片
    CGFloat photoX = 0;
    CGFloat photoY = 0;
    CGFloat photoW = BKHalfWidth;
    //设置成长宽3：2
    CGFloat photoH = _photoHeight;
    
    self.photoFrame = CGRectMake(photoX, photoY, photoW, photoH);
    
    
    
    //2.再文字
    CGFloat titleX = BKCustomMargin;
    CGFloat titleY = CGRectGetMaxY(self.photoFrame) + BKCustomMargin;
    CGFloat titleW = BKHalfWidth - 2 * BKCustomMargin;
    CGFloat titleH = _titleHeight;
    
    self.titleFrame = CGRectMake(titleX, titleY, titleW, titleH);
    

}

@end
