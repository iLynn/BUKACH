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
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        
        //2.名称
        UILabel * nameLab = [[UILabel alloc] init];
        [self.contentView addSubview:nameLab];
        self.nameLab = nameLab;
        
        //3.介绍
        UILabel * introLab = [[UILabel alloc] init];
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
    BKLog(@"%@", urlStr);
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    CGSize size = [self.introLab.text sizeWithAttributes:dict];
    
    BKLog(@"%@", NSStringFromCGSize(size));
    
    // 计算frame
    [self setupFrame];
    
//    // 2.计算introLab部分的frame
//    [self setupIntroFrame];
    
    // 3.计算cell的高度
    //self.cellHeight = CGRectGetMaxY(self.toolbarFrame);
    
}

- (void)setupFrame
{
    //介绍
    CGFloat introX = BKMargin;
    CGFloat introY = BKMargin;
    CGFloat introW = 120;
    CGFloat introH = 80;
    self.introLab.frame = CGRectMake(introX, introY, introW, introH);
    
    //图片
    CGFloat iconX = BKMargin;
    CGFloat iconY = BKMargin;
    CGFloat iconW = 120;
    CGFloat iconH = 80;
    self.iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    //名称
    CGFloat nameX = 0;
    CGFloat nameY = BKMargin;
    CGFloat nameW = 0;
    CGFloat nameH = 0;
    self.nameLab.frame = CGRectMake(nameX, nameY, nameW, nameH);
    
}

- (void)setupIntroFrame
{
    
}

@end
