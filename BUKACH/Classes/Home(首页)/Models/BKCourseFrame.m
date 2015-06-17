//
//  BKCourseFrame.m
//  BUKACH
//
//  Created by Lynn on 15/6/17.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKCourseFrame.h"
#import "BKCourseModel.h"

#define BKBaseWidth ceilf((BKScreenWidth - 2 * BKMargin - BKCellMargin) / 3)

@interface BKCourseFrame()

@property (nonatomic, assign) CGFloat nameHeight;

@property (nonatomic, assign) CGFloat introHeight;

@end

@implementation BKCourseFrame

- (void)setCourse:(BKCourseModel *)course
{
    _course = course;
    
    //计算高度
    [self computeHeight];
    
    //计算frame
    [self setupFrame];
    
}

- (void)computeHeight
{
    //name部分
    NSMutableDictionary * dictName = [NSMutableDictionary dictionary];
    dictName[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    //宽度占屏幕宽度的2/3
    CGSize maxSize = CGSizeMake(2 * BKBaseWidth, MAXFLOAT);
    CGRect rectName = [self.course.course_name boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dictName context:nil];
    
    self.nameHeight = ceilf(rectName.size.height);
    
    
    //intro部分
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    //和name一样宽
    CGRect rect = [self.course.course_intro boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    
    self.introHeight = ceilf(rect.size.height);
    
    
    CGFloat height = 3 * BKMargin + _nameHeight + _introHeight;
    CGFloat baseHeight = BKBaseWidth / 1.5 + 2 * BKMargin;
    
    //比图片的高度要小时
    self.cellHeight = (height < baseHeight) ? baseHeight : height;
    
}

- (void)setupFrame
{
    //nameLab的起点，要保证居中
    CGFloat baseLine = (_cellHeight - _nameHeight - _introHeight - BKMargin) / 2;
    
    //图片
    CGFloat iconX = BKMargin;
    CGFloat iconW = BKBaseWidth;
    //设置成长宽3：2
    CGFloat iconH = BKBaseWidth / 1.5;
    CGFloat iconY = (_cellHeight - iconH ) / 2;
    self.iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    //名称
    CGFloat nameX = CGRectGetMaxX(self.iconFrame) + BKCellMargin;
    CGFloat nameY = baseLine;
    CGFloat nameW = BKBaseWidth * 2;
    CGFloat nameH = _nameHeight;
    self.nameFrame = CGRectMake(nameX, nameY, nameW, nameH);
    
    //介绍
    CGFloat introX = nameX;
    CGFloat introY = CGRectGetMaxY(self.nameFrame) + BKMargin;
    CGFloat introW = BKBaseWidth * 2;
    CGFloat introH = _introHeight;
    self.introFrame = CGRectMake(introX, introY, introW, introH);
    
}


@end
