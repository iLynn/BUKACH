//
//  BKProfileDetailController.m
//  BUKACH
//
//  Created by Lynn on 15/6/15.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKProfileAboutController.h"
#import "BKHttpTool.h"
#import "BKAboutResponse.h"
#import "BKAboutModel.h"

@interface BKProfileAboutController ()

@property (nonatomic, weak) UILabel * detailLab;

@property (nonatomic, strong) NSArray * aboutArray;

@property (nonatomic, strong) BKAboutModel * about;

@end

@implementation BKProfileAboutController

- (NSArray *)aboutArray
{
    if (_aboutArray == nil)
    {
        _aboutArray = [[NSArray alloc] init];
    }
    return _aboutArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //有这两行代码，navVC下的view才不会跑偏
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //1.添加输入控件
    [self createSubviews];
    
    //2.联系方式
    [self getAboutInfo];

}

- (void)createSubviews
{
    UILabel * detailLab = [[UILabel alloc] initWithFrame:CGRectMake(BKCustomMargin, BKCustomMargin, BKScreenWidth - 2 * BKCustomMargin, 200)];
    detailLab.numberOfLines = 0;
    detailLab.font = [UIFont systemFontOfSize:15];
    
    [self.view addSubview:detailLab];
    
    self.detailLab = detailLab;
    
}

- (void)getAboutInfo
{
    //1.封装请求参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    //2.发送请求
    NSString * urlStr = [NSString stringWithFormat:@"%@about_us", BKUrlStr];
    
    [BKHttpTool post:urlStr params:params success:^(NSDictionary * aboutResponse) {
        
        // 字典转模型
        BKAboutResponse * response = [BKAboutResponse aboutResponseWithDict:aboutResponse];
        
        // 赋值填充UI
        self.aboutArray = response.data;
        
        if (self.aboutArray.count > 0)
        {
            self.about = self.aboutArray[0];
            
            [self fillSubviews];
            
        }
        
    } failure:^(NSError * error)
     {
         BKLog(@"请求失败-------%@", error);
         
     }];
    
}

- (void)fillSubviews
{
#warning 提醒后台修改此字段的属性，不然布局太难看！
    self.detailLab.text = self.about.about_us_detail;
    
    NSMutableDictionary * dictTitle = [NSMutableDictionary dictionary];
    dictTitle[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    
    //宽度占屏幕宽度的一半
    CGSize maxSize = CGSizeMake(CGRectGetMaxX(self.detailLab.frame), MAXFLOAT);
    CGRect rectName = [self.about.about_us_detail boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dictTitle context:nil];
    
    
    self.detailLab.height = ceilf(rectName.size.height);
    
}



@end
