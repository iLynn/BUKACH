//
//  BKCourseCell.m
//  BUKACH
//
//  Created by Lynn on 15/6/16.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKCourseCell.h"
#import "BKCourseModel.h"
#import "UIImageView+WebCache.h"
#import "BKCourseFrame.h"


@interface BKCourseCell()

@property (nonatomic, weak) UIImageView * iconView;

@property (nonatomic, weak) UILabel * nameLab;

@property (nonatomic, weak) UILabel * introLab;

@end

@implementation BKCourseCell

+ (id)cellWithTableView:(UITableView *)tableView
{
    static NSString * ID = @"course";
    BKCourseCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell = [[BKCourseCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //1.图片
        UIImageView * iconView = [[UIImageView alloc] init];
        iconView.layer.cornerRadius = BKCornerRadius;
        iconView.layer.masksToBounds = YES;
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        
        //2.名称
        UILabel * nameLab = [[UILabel alloc] init];
        nameLab.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:nameLab];
        self.nameLab = nameLab;
        
        //3.介绍
        UILabel * introLab = [[UILabel alloc] init];
        introLab.font = [UIFont systemFontOfSize:12];
        introLab.numberOfLines = 0;
        [self.contentView addSubview:introLab];
        self.introLab = introLab;

    }
    
    return self;
}

- (void)setCourse:(BKCourseModel *)course
{
    _course = course;
    
    self.nameLab.text = course.course_name;
    
    self.introLab.text = course.course_intro;
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@", BKUrlStr, course.course_photo];

    [self.iconView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    
    
}

- (void)setCellFrame:(BKCourseFrame *)cellFrame
{
    _cellFrame = cellFrame;
    
    // 1.icon的frame数据
    self.iconView.frame = cellFrame.iconFrame;
    
    // 2.name的frame数据
    self.nameLab.frame = cellFrame.nameFrame;
    
    // 3.intro的frame数据
    self.introLab.frame = cellFrame.introFrame;
    
    // 填充自己
    self.course = cellFrame.course;
    
}

@end
