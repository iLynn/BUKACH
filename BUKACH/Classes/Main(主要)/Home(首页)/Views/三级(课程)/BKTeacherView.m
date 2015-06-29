//
//  BKTeacherView.m
//  BUKACH
//
//  Created by Lynn on 15/6/18.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKTeacherView.h"
#import "BKOneTeacherModel.h"
#import "UIImageView+WebCache.h"


@interface BKTeacherView()

@property (nonatomic, weak) UIImageView * iconView;

@property (nonatomic, weak) UILabel * nameLab;

@property (nonatomic, weak) UILabel * levelLab;

@end

@implementation BKTeacherView

+ (id)teacherView
{
    return [[self alloc] initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self createSubViews];
    }
    
    return self;
}

/**
 *  固定布局的子控件们
 */
- (void)createSubViews
{
    //1.照片
    UIImageView * iconView = [[UIImageView alloc] init];
    self.iconView = iconView;
    
    CGFloat iconY = 0;
    CGFloat iconH = BKCurrentHeight * 0.7;
    CGFloat iconW = iconH * 0.8;
    CGFloat iconX = (BKCurrentWidth - iconW ) * 0.5;
    self.iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    [self addSubview:iconView];
    
    
    //2.名字
    UILabel * nameLab = [[UILabel alloc] init];
    nameLab.font = BKCustomFont;
    nameLab.textColor = BKCustomColor;
    nameLab.textAlignment = NSTextAlignmentCenter;
    self.nameLab = nameLab;
    
    CGFloat nameX = 0;
    CGFloat nameY = CGRectGetMaxY(self.iconView.frame);
    CGFloat nameW = BKCurrentWidth;
    CGFloat nameH = BKCurrentHeight * 0.15;
    self.nameLab.frame = CGRectMake(nameX, nameY, nameW, nameH);
    
    [self addSubview:nameLab];
    
    
    //3.教师等级
    UILabel * levelLab = [[UILabel alloc] init];
    levelLab.font = BKUnhighlightFont;
    levelLab.textColor = BKUnhighlightColor;
    levelLab.textAlignment = NSTextAlignmentCenter;
    self.levelLab = levelLab;
    
    CGFloat levelX = 0;
    CGFloat levelY = CGRectGetMaxY(self.nameLab.frame);
    CGFloat levelW = BKCurrentWidth;
    CGFloat levelH = BKCurrentHeight * 0.15;
    self.levelLab.frame = CGRectMake(levelX, levelY, levelW, levelH);
    
    [self addSubview:levelLab];
    
}


- (void)setTeacher:(BKOneTeacherModel *)teacher
{
    _teacher = teacher;
    
    //1.照片
    NSString * urlStr = [NSString stringWithFormat:@"%@%@", BKUrlStr, teacher.teacher_photo];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"bukach_wait"]];
    
    //2.名字
    self.nameLab.text = teacher.teacher_name;

    //3.教师等级
    self.levelLab.text = teacher.teacher_level;
    
}


@end
