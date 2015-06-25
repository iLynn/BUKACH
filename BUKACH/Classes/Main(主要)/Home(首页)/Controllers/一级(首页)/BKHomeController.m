//
//  BKHomeController.m
//  BUKACH
//
//  Created by Lynn on 15/6/13.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKHomeController.h"
#import "BKHttpTool.h"

#import "BKAdsView.h"
#import "BKAdsResponse.h"
#import "BKCategoryResponse.h"
#import "BKCategoriesView.h"

#import "BKOneCategoryModel.h"
#import "BKCategoryController.h"
#import "BKOneAdsModel.h"
#import "BKAdsController.h"


@interface BKHomeController ()<BKCategoriesViewDelegate, BKAdsViewDelegate>

/** 广告区 */
@property (nonatomic, weak) BKAdsView * adsView;
/** 课程分类区 */
@property (nonatomic, weak) BKCategoriesView * categoriesView;

@end

@implementation BKHomeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //有这两行代码，navVC下的view才不会跑偏
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
  
    //1.添加广告视图
    BKAdsView * adsView = [[BKAdsView alloc] initWithFrame:CGRectMake(0, 0, BKScreenWidth, BKScreenHeight * 0.3)];
    
    self.adsView = adsView;
    
    //设置代理
    self.adsView.delegate = self;
  
    [self.view addSubview:adsView];
    
    
    //2.添加分类视图
    CGFloat categoriesX = BKCustomMargin;
    CGFloat categoriesY = CGRectGetMaxY(self.adsView.frame) + BKCustomMargin;
    CGFloat categoriesW = BKScreenWidth - 2 * BKCustomMargin;
    CGFloat categoriesH = BKScreenHeight - categoriesY - 20 - 44 - 49 - BKCustomMargin;
    
    BKCategoriesView * categoriesView = [[BKCategoriesView alloc] initWithFrame:CGRectMake(categoriesX, categoriesY, categoriesW, categoriesH)];
    
    self.categoriesView = categoriesView;
    
    //设置代理
    self.categoriesView.delegate = self;
    
    [self.view addSubview:categoriesView];
    
    
    //3.获得广告信息
    [self getAdsInfo];
    
    //4.获得分类信息
    [self getCategoryInfo];
    
}

- (void)getAdsInfo
{
    //1.封装请求参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    //2.发送请求
    NSString * urlStr = [NSString stringWithFormat:@"%@get_ads_info", BKUrlStr];
    
    [BKHttpTool post:urlStr params:params success:^(NSDictionary * adsResponse) {
        
        // 字典转模型
        BKAdsResponse * response = [BKAdsResponse adsResponseWithDict:adsResponse];
        
        // 赋值填充UI
        self.adsView.ads = response.data;
        
    } failure:^(NSError * error)
    {
        BKLog(@"请求失败-------%@", error);
        
    }];
    
}

- (void)getCategoryInfo
{
    //1.封装请求参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    //2.发送请求
    NSString * urlStr = [NSString stringWithFormat:@"%@get_course_category", BKUrlStr];
    
    [BKHttpTool post:urlStr params:params success:^(NSDictionary * categoryResponse) {
        
        BKCategoryResponse * response = [BKCategoryResponse categoryResponseWithDict:categoryResponse];
        
        self.categoriesView.categories = response.data;
        
        
    } failure:^(NSError * error) {
        
        BKLog(@"请求失败-------%@", error);
        
    }];

}

#pragma mark - BKCategoriesViewDelegate代理方法

- (void)jumpToCategoryWithModel:(BKOneCategoryModel *)category
{
    BKCategoryController * vc = [[BKCategoryController alloc] init];
    
    vc.category = category;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}


#pragma mark - BKAdsViewDelegate代理方法

- (void)jumpToAdsWithModel:(BKOneAdsModel *)ad
{
    BKAdsController * vc = [[BKAdsController alloc] init];
    
    vc.ads = ad;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
