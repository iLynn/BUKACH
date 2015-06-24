//
//  BKTeacherController.m
//  BUKACH
//
//  Created by Lynn on 15/6/18.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKTeacherController.h"
#import "BKHttpTool.h"
#import "BKOneTeacherResponse.h"
#import "BKOneTeacherModel.h"
#import "UIImageView+WebCache.h"

#define BKBaseWidth (BKScreenWidth - 2 * BKMargin)

@interface BKTeacherController ()

@property (nonatomic, strong) NSArray * teacherArray;

@property (nonatomic, weak) UIScrollView * contentView;

@property (nonatomic, strong) BKOneTeacherModel * teacherDetail;


@property (nonatomic, weak) UIImageView * photoView;
@property (nonatomic, weak) UILabel * levelLab;
@property (nonatomic, weak) UILabel * nameLab;
@property (nonatomic, weak) UILabel * graduateLab;

@property (nonatomic, weak) UILabel * styleLab;
@property (nonatomic, weak) UILabel * experienceLab;
@property (nonatomic, weak) UILabel * detailLab;
@property (nonatomic, weak) UILabel * awardLab;

@end

@implementation BKTeacherController

- (NSArray *)teacherArray
{
    if (_teacherArray == nil)
    {
        _teacherArray = [[NSArray alloc] init];
    }
    return _teacherArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //有这两行代码，navVC下的view才不会跑偏
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //添加容器
    UIScrollView * contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, BKScreenWidth, BKScreenHeight - 20 - 44)];
    self.contentView = contentView;
    self.contentView.backgroundColor = [UIColor lightGrayColor];
    
    self.view = contentView;
    
}

- (void)setTeacher:(BKOneTeacherModel *)teacher
{
    _teacher = teacher;
    
    self.navigationItem.title = teacher.teacher_name;
    
    NSString * str = teacher.teacher_id;
    
    [self getTeacherWithID:str];
    
}


- (void)getTeacherWithID:(NSString *)ID
{
    //1.封装请求参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"teacher_id"] = ID;
    
    //2.发送请求
    NSString * urlStr = [NSString stringWithFormat:@"%@get_teacher_info", BKUrlStr];
    
    [BKHttpTool post:urlStr params:params success:^(NSDictionary * teacherResponse) {
        
        BKOneTeacherResponse * response = [BKOneTeacherResponse oneTeacherResponseWithDict:teacherResponse];
        
        self.teacherArray = response.data;
        
        if (self.teacherArray.count > 0)
        {
            self.teacherDetail = self.teacherArray[0];
            
            BKLog(@"%@", response);
            
            [self createSubviews];
            
        }
     
    } failure:^(NSError * error) {
        
        BKLog(@"请求失败-------%@", error);
        
    }];
    
}

- (void)createSubviews
{
    //1.教师图片
    UIImageView * photoView = [[UIImageView alloc] initWithFrame:CGRectMake(BKMargin, BKMargin, (BKBaseWidth - BKMargin ) * 0.6, (BKBaseWidth - BKMargin ) * 0.8)];
    [self.contentView addSubview:photoView];
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@", BKUrlStr, self.teacherDetail.teacher_photo];
    [photoView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    
    self.photoView = photoView;
    
    
    //2.教师等级
    UILabel * levelLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.photoView.frame) + BKMargin, BKMargin, (BKBaseWidth - BKMargin ) * 0.4, (BKBaseWidth - BKMargin ) * 0.5)];
    levelLab.font = [UIFont systemFontOfSize:60];
    levelLab.textAlignment = NSTextAlignmentCenter;
    levelLab.textColor = [UIColor orangeColor];
    levelLab.numberOfLines = 0;
    [self.contentView addSubview:levelLab];
    levelLab.text = self.teacherDetail.teacher_level;
    
    self.levelLab = levelLab;
    
    
    //3.教师名字
    UILabel * nameLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.photoView.frame) + BKMargin, CGRectGetMaxY(self.levelLab.frame), (BKBaseWidth - BKMargin ) * 0.4, (BKBaseWidth - BKMargin ) * 0.3)];
    nameLab.font = [UIFont systemFontOfSize:36];
    nameLab.textAlignment = NSTextAlignmentCenter;
    nameLab.textColor = [UIColor blackColor];
    [self.contentView addSubview:nameLab];
    nameLab.text = self.teacherDetail.teacher_name;
    
    self.nameLab = nameLab;
    
    
    //4.教师学历
    UILabel * graduate = [[UILabel alloc] initWithFrame:CGRectMake(BKMargin, CGRectGetMaxY(self.photoView.frame) + BKMargin, BKBaseWidth, 30)];
    graduate.text = @"教师背景";
    graduate.font = [UIFont systemFontOfSize:18];
    graduate.textColor = [UIColor orangeColor];
    [self.contentView addSubview:graduate];
    
    UILabel * graduateLab = [[UILabel alloc] initWithFrame:CGRectMake(BKMargin, CGRectGetMaxY(self.photoView.frame) + 2 * BKMargin + 30, BKBaseWidth, 30)];
    [self.contentView addSubview:graduateLab];
    graduateLab.font = [UIFont systemFontOfSize:15];
    graduateLab.text = self.teacherDetail.teacher_graduate_school;
    graduateLab.numberOfLines = 0;
    
    self.graduateLab = graduateLab;
    
    //计算高度
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    CGSize maxSize = CGSizeMake(BKBaseWidth, MAXFLOAT);
    
    CGRect graduateRect = [self.teacherDetail.teacher_graduate_school boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    
    self.graduateLab.height = ceilf(graduateRect.size.height);
    
    
    //5.教学风格
    UILabel * style = [[UILabel alloc] initWithFrame:CGRectMake(BKMargin, CGRectGetMaxY(self.graduateLab.frame) + BKMargin, BKBaseWidth, 30)];
    style.text = @"教学风格";
    style.font = [UIFont systemFontOfSize:18];
    style.textColor = [UIColor orangeColor];
    [self.contentView addSubview:style];
    
    UILabel * styleLab = [[UILabel alloc] initWithFrame:CGRectMake(BKMargin, CGRectGetMaxY(self.graduateLab.frame) + 2 * BKMargin + 30, BKBaseWidth, 30)];
    [self.contentView addSubview:styleLab];
    styleLab.font = [UIFont systemFontOfSize:15];
    styleLab.text = self.teacherDetail.teacher_style;
    styleLab.numberOfLines = 0;
    
    self.styleLab = styleLab;
    
    //计算高度
    CGRect styleRect = [self.teacherDetail.teacher_style boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    
    self.styleLab.height = ceilf(styleRect.size.height);
    
    
    //6.教学经验
    UILabel * experience = [[UILabel alloc] initWithFrame:CGRectMake(BKMargin, CGRectGetMaxY(self.styleLab.frame) + BKMargin, BKBaseWidth, 30)];
    experience.text = @"教学经验";
    experience.font = [UIFont systemFontOfSize:18];
    experience.textColor = [UIColor orangeColor];
    [self.contentView addSubview:experience];
    
    UILabel * experienceLab = [[UILabel alloc] initWithFrame:CGRectMake(BKMargin, CGRectGetMaxY(self.styleLab.frame) + 2 * BKMargin + 30, BKBaseWidth, 30)];
    [self.contentView addSubview:experienceLab];
    experienceLab.font = [UIFont systemFontOfSize:15];
    experienceLab.text = self.teacherDetail.teacher_experience;
    experienceLab.numberOfLines = 0;
    
    self.experienceLab = experienceLab;
    
    //计算高度
    CGRect experienceRect = [self.teacherDetail.teacher_experience boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    
    self.experienceLab.height = ceilf(experienceRect.size.height);
    
    
    //7.教师详情
    UILabel * detail = [[UILabel alloc] initWithFrame:CGRectMake(BKMargin, CGRectGetMaxY(self.experienceLab.frame) + BKMargin, BKBaseWidth, 30)];
    detail.text = @"教师详情";
    detail.font = [UIFont systemFontOfSize:18];
    detail.textColor = [UIColor orangeColor];
    [self.contentView addSubview:detail];
    
    UILabel * detailLab = [[UILabel alloc] initWithFrame:CGRectMake(BKMargin, CGRectGetMaxY(self.experienceLab.frame) + 2 * BKMargin + 30, BKBaseWidth, 30)];
    [self.contentView addSubview:detailLab];
    detailLab.font = [UIFont systemFontOfSize:15];
    detailLab.text = self.teacherDetail.teacher_detail;
    detailLab.numberOfLines = 0;
    
    self.detailLab = detailLab;
    
    //计算高度
    CGRect detailRect = [self.teacherDetail.teacher_detail boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    
    self.detailLab.height = ceilf(detailRect.size.height);
    
    
    //8.奖项
    UILabel * award = [[UILabel alloc] initWithFrame:CGRectMake(BKMargin, CGRectGetMaxY(self.detailLab.frame) + BKMargin, BKBaseWidth, 30)];
    award.text = @"获奖情况";
    award.font = [UIFont systemFontOfSize:18];
    award.textColor = [UIColor orangeColor];
    [self.contentView addSubview:award];
    
    UILabel * awardLab = [[UILabel alloc] initWithFrame:CGRectMake(BKMargin, CGRectGetMaxY(self.detailLab.frame) + 2 * BKMargin + 30, BKBaseWidth, 30)];
    [self.contentView addSubview:awardLab];
    awardLab.font = [UIFont systemFontOfSize:15];
    awardLab.text = self.teacherDetail.teacher_award;
    awardLab.numberOfLines = 0;
    
    self.awardLab = awardLab;
    
    //计算高度
    CGRect awardRect = [self.teacherDetail.teacher_award boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    
    self.awardLab.height = ceilf(awardRect.size.height);
    
    
    
    
    //9.重新计算scrollView的contentSize
    self.contentView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.awardLab.frame) + BKMargin);
    
    
}


@end
