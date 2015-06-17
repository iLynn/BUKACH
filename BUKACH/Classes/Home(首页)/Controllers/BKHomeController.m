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

#import "BKCategoryModel.h"
#import "BKCategoryController.h"
#import "BKAdsModel.h"
#import "BKAdsController.h"


@interface BKHomeController ()<BKCategoriesViewDelegate, BKAdsViewDelegate>

@property (nonatomic, weak) BKAdsView * adsView;

@property (nonatomic, weak) BKCategoriesView * categoriesView;

@end

@implementation BKHomeController

#pragma mark - 懒加载

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //有这两行代码，navVC下的view才不会跑偏
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
  
    //1.添加广告视图
    BKAdsView * adsView = [[BKAdsView alloc] initWithFrame:CGRectMake(0, 0, BKScreenWidth, 200)];
    
    self.adsView = adsView;
    
    //设置代理
    self.adsView.delegate = self;
  
    [self.view addSubview:adsView];
    
    
    //2.添加分类视图
    CGFloat categoriesX = BKMargin;
    CGFloat categoriesY = CGRectGetMaxY(self.adsView.frame) + BKMargin;
    CGFloat categoriesW = BKScreenWidth - 2 * BKMargin;
    CGFloat categoriesH = BKScreenHeight - categoriesY - 20 - 44 - 49 - BKMargin;
    
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

- (void)jumpToCategoryWithModel:(BKCategoryModel *)category
{
    BKCategoryController * vc = [[BKCategoryController alloc] init];
    
    vc.category = category;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}


#pragma mark - BKAdsViewDelegate代理方法

- (void)jumpToAdsWithModel:(BKAdsModel *)ad
{
    BKAdsController * vc = [[BKAdsController alloc] init];
    
    vc.ads = ad;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
