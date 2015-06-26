//
//  BKJobCell.m
//  BUKACH
//
//  Created by Lynn on 15/6/25.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKJobCell.h"
#import "BKOneJobModel.h"
#import "BKJobFrame.h"

@interface BKJobCell()

/** 标题：名称+人数+全兼职 */
@property (nonatomic, weak) UILabel * titleLab;
/** “职位详情” */
@property (nonatomic, weak) UILabel * detail;
/** 具体：招聘要求+工作内容 */
@property (nonatomic, weak) UILabel * detailLab;
/** “应聘通道” */
@property (nonatomic, weak) UILabel * resume;
/** 应聘通道 */
@property (nonatomic, weak) UILabel * resumeLab;
/** “职位有效期” */
@property (nonatomic, weak) UILabel * time;
/** 职位有效期 */
@property (nonatomic, weak) UILabel * timeLab;

@end

@implementation BKJobCell

+ (id)cellWithTableView:(UITableView *)tableView
{
    static NSString * ID = @"job";
    BKJobCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell = [[BKJobCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //1.标题：名称+人数+全兼职
        UILabel * titleLab = [[UILabel alloc] init];
        titleLab.font = BKHighlightFont;
        titleLab.textColor = BKHighlightColor;
        [self.contentView addSubview:titleLab];
        
        self.titleLab = titleLab;
        
        
        //2.具体：招聘要求 + 工作内容
        UILabel * detail = [[UILabel alloc] initWithFrame: CGRectMake(BKCustomMargin, CGRectGetMaxY(self.titleLab.frame) + BKCustomMargin, BKFullWidth, BKDefaultHeight)];
        detail.text = @"职位详情";
        detail.font = [UIFont boldSystemFontOfSize:15];
        detail.textColor = BKCustomColor;
        [self.contentView addSubview:detail];
        
        self.detail = detail;
        
        //2.1 职位详情的具体内容
        UILabel * detailLab = [[UILabel alloc] init];
        detailLab.font = BKCustomFont;
        detailLab.textColor = BKCustomColor;
        detailLab.numberOfLines = 0;
        [self.contentView addSubview:detailLab];
        
        self.detailLab = detailLab;
        
        
        //3.简历投递
        UILabel * resume = [[UILabel alloc] initWithFrame:CGRectMake(BKCustomMargin, CGRectGetMaxY(self.detailLab.frame) + BKCustomMargin, BKFullWidth, BKDefaultHeight)];
        resume.text = @"申请方式";
        resume.font = [UIFont boldSystemFontOfSize:15];
        resume.textColor = BKCustomColor;
        [self.contentView addSubview:resume];
        
        self.resume = resume;
        
        //3.1 申请通道的具体内容
        UILabel * resumeLab = [[UILabel alloc] init];
        resumeLab.font = BKCustomFont;
        resumeLab.textColor = BKCustomColor;
        resumeLab.numberOfLines = 0;
        [self.contentView addSubview:resumeLab];
        
        self.resumeLab = resumeLab;
        
        
        //4.有效期
        UILabel * time = [[UILabel alloc] initWithFrame:CGRectMake(BKCustomMargin, CGRectGetMaxY(self.resumeLab.frame) + BKCustomMargin, BKFullWidth, BKDefaultHeight)];
        time.text = @"职位有效期";
        time.font = [UIFont boldSystemFontOfSize:15];
        time.textColor = BKCustomColor;
        [self.contentView addSubview:time];
        
        self.time = time;
        
        //4.1 有效期的具体内容
        UILabel * timeLab = [[UILabel alloc] init];
        timeLab.font = BKCustomFont;
        timeLab.textColor = BKCustomColor;
        timeLab.numberOfLines = 0;
        [self.contentView addSubview:timeLab];
        
        self.timeLab = timeLab;
        
    }
    
    return self;
}

- (void)setJob:(BKOneJobModel *)job
{
    _job = job;
    
    self.titleLab.text = [NSString stringWithFormat:@"%@ · %@ · %@", job.job_name, job.job_quota, job.job_type];
    
    self.detailLab.text = job.job_detail;

    self.resumeLab.text = job.job_resume;
    
    self.timeLab.text = job.job_deadline;
    
    
}


- (void)setCellFrame:(BKJobFrame *)cellFrame
{
    _cellFrame = cellFrame;
    
    // 1.标题 的frame
    self.titleLab.frame = cellFrame.titleFrame;
    
    // 2.详情 的frame
    self.detail.frame = CGRectMake(BKCustomMargin, CGRectGetMaxY(self.titleLab.frame) + BKCustomMargin, BKFullWidth, BKDefaultHeight);
    
    self.detailLab.frame = cellFrame.detailFrame;
    
    // 3.简历 的frame
    self.resume.frame = CGRectMake(BKCustomMargin, CGRectGetMaxY(self.detailLab.frame) + BKCustomMargin, BKFullWidth, BKDefaultHeight);
    
    self.resumeLab.frame = cellFrame.resumeFrame;
    
    // 4.有效期 的frame
    self.time.frame = CGRectMake(BKCustomMargin, CGRectGetMaxY(self.resumeLab.frame) + BKCustomMargin, BKFullWidth, BKDefaultHeight);
    
    self.timeLab.frame = cellFrame.timeFrame;
    
    // 填充自己
    self.job = cellFrame.job;
    
    
}


@end
