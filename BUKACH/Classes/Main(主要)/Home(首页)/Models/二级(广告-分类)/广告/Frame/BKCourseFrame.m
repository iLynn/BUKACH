//
//  BKCourseFrame.m
//  BUKACH
//
//  Created by Lynn on 15/6/17.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKCourseFrame.h"
#import "BKOneCourseModel.h"

#define BKBaseWidth ceilf((BKScreenWidth - 2 * BKCustomMargin - BKSubviewMargin) / 3)

@interface BKCourseFrame()

/** 课程名栏位的高度 */
@property (nonatomic, assign) CGFloat nameHeight;

/** 简介栏位的高度 */
@property (nonatomic, assign) CGFloat introHeight;

@end

@implementation BKCourseFrame

- (void)setCourse:(BKOneCourseModel *)course
{
    _course = course;
    
    //计算高度
    [self computeHeight];
    
    //计算frame
    [self setupFrame];
    
}

- (void)computeHeight
{
    //1. name部分
    NSMutableDictionary * dictName = [NSMutableDictionary dictionary];
    dictName[NSFontAttributeName] = BKCustomFont;
    //名字的宽度占屏幕宽度的2/3
    CGSize maxSize = CGSizeMake(2 * BKBaseWidth, MAXFLOAT);
    CGRect rectName = [self.course.course_name boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dictName context:nil];
    
    self.nameHeight = ceilf(rectName.size.height);
    
    
    //2. intro部分
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = BKUnhighlightFont;
    //和name一样宽
    CGRect rect = [self.course.course_intro boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    
    self.introHeight = ceilf(rect.size.height);
    
    
    CGFloat height = 3 * BKCustomMargin + _nameHeight + _introHeight;
    CGFloat baseHeight = BKBaseWidth / 1.5 + 2 * BKCustomMargin;
    
    //比图片的高度要小时
    self.cellHeight = (height < baseHeight) ? baseHeight : height;
    
}

- (void)setupFrame
{
    //nameLab的起点，要保证居中
    CGFloat baseLine = (_cellHeight - _nameHeight - _introHeight - BKCustomMargin) * 0.5;
    
    //图片
    CGFloat iconX = BKCustomMargin;
    CGFloat iconW = BKBaseWidth;
    //设置成长宽3：2
    CGFloat iconH = BKBaseWidth / 1.5;
    CGFloat iconY = (_cellHeight - iconH ) * 0.5;
    self.iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    //名称
    CGFloat nameX = CGRectGetMaxX(self.iconFrame) + BKSubviewMargin;
    CGFloat nameY = baseLine;
    CGFloat nameW = BKBaseWidth * 2;
    CGFloat nameH = _nameHeight;
    self.nameFrame = CGRectMake(nameX, nameY, nameW, nameH);
    
    //介绍
    CGFloat introX = nameX;
    CGFloat introY = CGRectGetMaxY(self.nameFrame) + BKCustomMargin;
    CGFloat introW = BKBaseWidth * 2;
    CGFloat introH = _introHeight;
    self.introFrame = CGRectMake(introX, introY, introW, introH);
    
}


@end
