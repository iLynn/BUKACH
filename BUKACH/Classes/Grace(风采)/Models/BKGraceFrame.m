//
//  BKGraceFrame.m
//  BUKACH
//
//  Created by Lynn on 15/6/23.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKGraceFrame.h"
#import "BKOneGraceModel.h"

#define BKBaseWidth ceilf((BKScreenWidth - 2 * BKMargin - BKCellMargin) / 2)


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
    dictTitle[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    
    //宽度占屏幕宽度的一半
    CGSize maxSize = CGSizeMake(BKBaseWidth, MAXFLOAT);
    CGRect rectName = [self.grace.grace_title boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dictTitle context:nil];
    
    self.titleHeight = ceilf(rectName.size.height);
    
    
    //2.photo部分
    
    
    
    self.cellHeight = self.titleHeight + self.photoHeight;
    
}

- (void)setupFrame
{
    //1.标题
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleW = BKBaseWidth;
    CGFloat titleH = self.titleHeight;
    
    self.titleFrame = CGRectMake(titleX, titleY, titleW, titleH);
    
    //图片
    CGFloat photoX = 0;
    CGFloat photoY = CGRectGetMaxY(self.titleFrame);
    CGFloat photoW = BKBaseWidth;
    //设置成长宽3：2
    CGFloat photoH = self.photoHeight;
    
    self.photoFrame = CGRectMake(photoX, photoY, photoW, photoH);

}

@end
