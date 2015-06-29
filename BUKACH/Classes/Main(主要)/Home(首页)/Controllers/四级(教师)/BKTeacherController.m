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


@interface BKTeacherController ()

/** 存放teacher模型的数组 */
@property (nonatomic, strong) NSArray * teacherArray;
/** 整个页面的容器 */
@property (nonatomic, weak) UIScrollView * contentView;
/** 具体的某个教师模型，用于填充此页面的 */
@property (nonatomic, strong) BKOneTeacherModel * teacherDetail;

/** 教师照片 */
@property (nonatomic, weak) UIImageView * photoView;
/** 教师等级 */
@property (nonatomic, weak) UILabel * levelLab;
/** 教师名字 */
@property (nonatomic, weak) UILabel * nameLab;
/** 教师教育背景 */
@property (nonatomic, weak) UILabel * graduate;
/** 教师教育背景 */
@property (nonatomic, weak) UILabel * graduateLab;
/** “教学风格” */
@property (nonatomic, weak) UILabel * style;
/** 教师教学风格 */
@property (nonatomic, weak) UILabel * styleLab;
/** “教师经验” */
@property (nonatomic, weak) UILabel * experience;
/** 教师经验 */
@property (nonatomic, weak) UILabel * experienceLab;
/** “教师详细信息” */
@property (nonatomic, weak) UILabel * detail;
/** 教师详细信息 */
@property (nonatomic, weak) UILabel * detailLab;
/** “教师获奖情况” */
@property (nonatomic, weak) UILabel * award;
/** 教师获奖情况 */
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
            
            [self createSubviews];
            
        }
     
    } failure:^(NSError * error) {
        
        BKLog(@"请求失败-------%@", error);
        
    }];
    
}

- (void)createSubviews
{
    //1.教师图片
    UIImageView * photoView = [[UIImageView alloc] initWithFrame:CGRectMake(BKCustomMargin, BKCustomMargin, (BKFullWidth - BKCustomMargin ) * 0.6, (BKFullWidth - BKCustomMargin ) * 0.8)];
    [self.contentView addSubview:photoView];
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@", BKUrlStr, self.teacherDetail.teacher_photo];
    [photoView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"bukach_wait"]];
    
    self.photoView = photoView;
    
    
    //2.教师等级
    UILabel * levelLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.photoView.frame) + BKCustomMargin, BKCustomMargin, (BKFullWidth - BKCustomMargin ) * 0.4, (BKFullWidth - BKCustomMargin ) * 0.5)];
    levelLab.font = [UIFont systemFontOfSize:60];
    levelLab.textAlignment = NSTextAlignmentCenter;
    levelLab.textColor = BKHighlightColor;
    levelLab.numberOfLines = 0;
    [self.contentView addSubview:levelLab];
    levelLab.text = self.teacherDetail.teacher_level;
    
    self.levelLab = levelLab;
    
    
    //3.教师名字
    UILabel * nameLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.photoView.frame) + BKCustomMargin, CGRectGetMaxY(self.levelLab.frame), (BKFullWidth - BKCustomMargin ) * 0.4, (BKFullWidth - BKCustomMargin ) * 0.3)];
    nameLab.font = [UIFont systemFontOfSize:36];
    nameLab.textAlignment = NSTextAlignmentCenter;
    nameLab.textColor = BKCustomColor;
    [self.contentView addSubview:nameLab];
    nameLab.text = self.teacherDetail.teacher_name;
    
    self.nameLab = nameLab;
    
    
    //4.教师学历
    UILabel * graduate = [[UILabel alloc] initWithFrame:CGRectMake(BKCustomMargin, CGRectGetMaxY(self.photoView.frame) + BKCustomMargin, BKFullWidth, BKDefaultHeight)];
    graduate.text = @"教师背景";
    graduate.font = BKHighlightFont;
    graduate.textColor = BKHighlightColor;
    [self.contentView addSubview:graduate];
    
    self.graduate = graduate;
    
    //4.1 学历的具体内容
    UILabel * graduateLab = [[UILabel alloc] initWithFrame:CGRectMake(BKCustomMargin, CGRectGetMaxY(self.graduate.frame) + BKCustomMargin, BKFullWidth, BKDefaultHeight)];
    [self.contentView addSubview:graduateLab];
    graduateLab.font = BKCustomFont;
    graduateLab.textColor = BKCustomColor;
    graduateLab.text = self.teacherDetail.teacher_graduate_school;
    graduateLab.numberOfLines = 0;
    
    self.graduateLab = graduateLab;
    
    //4.2 计算高度
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = BKCustomFont;
    CGSize maxSize = CGSizeMake(BKFullWidth, MAXFLOAT);
    
    CGRect graduateRect = [self.teacherDetail.teacher_graduate_school boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    
    self.graduateLab.height = ceilf(graduateRect.size.height);
    
    
    //5.教学风格
    UILabel * style = [[UILabel alloc] initWithFrame:CGRectMake(BKCustomMargin, CGRectGetMaxY(self.graduateLab.frame) + BKCustomMargin, BKFullWidth, BKDefaultHeight)];
    style.text = @"教学风格";
    style.font = BKHighlightFont;
    style.textColor = BKHighlightColor;
    [self.contentView addSubview:style];
    
    self.style = style;
    
    //5.1 风格的具体内容
    UILabel * styleLab = [[UILabel alloc] initWithFrame:CGRectMake(BKCustomMargin, CGRectGetMaxY(self.style.frame) + BKCustomMargin, BKFullWidth, BKDefaultHeight)];
    [self.contentView addSubview:styleLab];
    styleLab.font = BKCustomFont;
    styleLab.textColor = BKCustomColor;
    styleLab.text = self.teacherDetail.teacher_style;
    styleLab.numberOfLines = 0;
    
    self.styleLab = styleLab;
    
    //5.2 计算高度
    CGRect styleRect = [self.teacherDetail.teacher_style boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    
    self.styleLab.height = ceilf(styleRect.size.height);
    
    
    //6.教学经验
    UILabel * experience = [[UILabel alloc] initWithFrame:CGRectMake(BKCustomMargin, CGRectGetMaxY(self.styleLab.frame) + BKCustomMargin, BKFullWidth, BKDefaultHeight)];
    experience.text = @"教学经验";
    experience.font = BKHighlightFont;
    experience.textColor = BKHighlightColor;
    [self.contentView addSubview:experience];
    
    self.experience = experience;
    
    //6.1 经验的具体内容
    UILabel * experienceLab = [[UILabel alloc] initWithFrame:CGRectMake(BKCustomMargin, CGRectGetMaxY(self.experience.frame) + BKCustomMargin, BKFullWidth, BKDefaultHeight)];
    [self.contentView addSubview:experienceLab];
    experienceLab.font = BKCustomFont;
    experienceLab.textColor = BKCustomColor;
    experienceLab.text = self.teacherDetail.teacher_experience;
    experienceLab.numberOfLines = 0;
    
    self.experienceLab = experienceLab;
    
    //6.2 计算高度
    CGRect experienceRect = [self.teacherDetail.teacher_experience boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    
    self.experienceLab.height = ceilf(experienceRect.size.height);
    
    
    //7.教师详情
    UILabel * detail = [[UILabel alloc] initWithFrame:CGRectMake(BKCustomMargin, CGRectGetMaxY(self.experienceLab.frame) + BKCustomMargin, BKFullWidth, BKDefaultHeight)];
    detail.text = @"教师详情";
    detail.font = BKHighlightFont;
    detail.textColor = BKHighlightColor;
    [self.contentView addSubview:detail];
    
    self.detail = detail;
    
    //7.1 详情的具体内容
    UILabel * detailLab = [[UILabel alloc] initWithFrame:CGRectMake(BKCustomMargin, CGRectGetMaxY(self.detail.frame) + BKCustomMargin, BKFullWidth, BKDefaultHeight)];
    [self.contentView addSubview:detailLab];
    detailLab.font = BKCustomFont;
    detailLab.textColor = BKCustomColor;
    detailLab.text = self.teacherDetail.teacher_detail;
    detailLab.numberOfLines = 0;
    
    self.detailLab = detailLab;
    
    //7.2 计算高度
    CGRect detailRect = [self.teacherDetail.teacher_detail boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    
    self.detailLab.height = ceilf(detailRect.size.height);
    
    
    //8.奖项
    UILabel * award = [[UILabel alloc] initWithFrame:CGRectMake(BKCustomMargin, CGRectGetMaxY(self.detailLab.frame) + BKCustomMargin, BKFullWidth, BKDefaultHeight)];
    award.text = @"获奖情况";
    award.font = BKHighlightFont;
    award.textColor = BKHighlightColor;
    [self.contentView addSubview:award];
    
    self.award = award;
    
    //7.1 奖项的具体内容
    UILabel * awardLab = [[UILabel alloc] initWithFrame:CGRectMake(BKCustomMargin, CGRectGetMaxY(self.award.frame) + BKCustomMargin, BKFullWidth, BKDefaultHeight)];
    [self.contentView addSubview:awardLab];
    awardLab.font = BKCustomFont;
    awardLab.textColor = BKCustomColor;
    awardLab.text = self.teacherDetail.teacher_award;
    awardLab.numberOfLines = 0;
    
    self.awardLab = awardLab;
    
    //计算高度
    CGRect awardRect = [self.teacherDetail.teacher_award boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    
    self.awardLab.height = ceilf(awardRect.size.height);
    
    
    
    
    //9.重新计算scrollView的contentSize
    self.contentView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.awardLab.frame) + BKCustomMargin);
    
    
}


@end
