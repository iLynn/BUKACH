//
//  BKJobFrame.m
//  BUKACH
//
//  Created by Lynn on 15/6/25.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKJobFrame.h"
#import "BKOneJobModel.h"

@interface BKJobFrame()

@property (nonatomic, assign) CGFloat titleHeight;

@property (nonatomic, assign) CGFloat detailHeight;

@property (nonatomic, assign) CGFloat resumeHeight;

@property (nonatomic, assign) CGFloat timeHeight;

@end

@implementation BKJobFrame

- (void)setJob:(BKOneJobModel *)job
{
    _job = job;
    
    //计算高度
    [self computeHeight];
    
    //计算frame
    [self setupFrame];
    
}

- (void)computeHeight
{
    //1. 标题：名称+人数+全兼职
    NSMutableDictionary * dictTitle = [NSMutableDictionary dictionary];
    dictTitle[NSFontAttributeName] = BKHighlightFont;
    CGSize maxSize = CGSizeMake(BKFullWidth, MAXFLOAT);
    NSString * titleStr = [NSString stringWithFormat:@"%@ · %@ · %@", self.job.job_name, self.job.job_quota, self.job.job_type];
    CGRect rectTitle = [titleStr boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dictTitle context:nil];
    
    self.titleHeight = rectTitle.size.height;
    
    
    //2. 具体：招聘要求+工作内容
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = BKCustomFont;
    CGRect rectDetail = [self.job.job_detail boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    
    self.detailHeight = rectDetail.size.height;
    
    
    //3. 应聘通道
    //CGRect rectResume = [self.job.job_resume boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    
    //self.resumeHeight = rectResume.size.height;
    
    
    //4. 职位有效期
    CGRect rectTime = [self.job.job_deadline boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    
    self.timeHeight = rectTime.size.height;
    
    
    //5. 高度
    self.cellHeight = self.titleHeight + self.detailHeight + self.resumeHeight + self.timeHeight + 2 * BKDefaultHeight + 6 * BKCustomMargin;
    
}

- (void)setupFrame
{
    //1.标题：名称+人数+全兼职
    CGFloat titleX = BKCustomMargin;
    CGFloat titleY = BKCustomMargin;
    CGFloat titleW = BKFullWidth;
    CGFloat titleH = _titleHeight;
    self.titleFrame = CGRectMake(titleX, titleY, titleW, titleH);
    
    //2. 具体：招聘要求+工作内容
    CGFloat detailX = BKCustomMargin;
    CGFloat detailY = CGRectGetMaxY(self.titleFrame) + BKCustomMargin * 2 + BKDefaultHeight;
    CGFloat detailW = BKFullWidth;
    CGFloat detailH = _detailHeight;
    self.detailFrame = CGRectMake(detailX, detailY, detailW, detailH);
    
//    //3. 应聘通道
//    CGFloat resumeX = detailX;
//    CGFloat resumeY = CGRectGetMaxY(self.detailFrame) + BKCustomMargin * 2 + BKDefaultHeight;
//    CGFloat resumeW = BKFullWidth;
//    CGFloat resumeH = _resumeHeight;
//    self.resumeFrame = CGRectMake(resumeX, resumeY, resumeW, resumeH);
    
    //4. 职位有效期
    CGFloat timeX = detailX;
    CGFloat timeY = CGRectGetMaxY(self.detailFrame) + BKCustomMargin * 2 + BKDefaultHeight;
    CGFloat timeW = BKFullWidth;
    CGFloat timeH = _timeHeight;
    self.timeFrame = CGRectMake(timeX, timeY, timeW, timeH);
    
}



@end
