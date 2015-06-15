//
//  BKHomeController.m
//  BUKACH
//
//  Created by Lynn on 15/6/13.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKHomeController.h"
#import "BKAdsView.h"
#import "LYAdsView.h"
#import "BKHttpTool.h"

@interface BKHomeController ()

@end

@implementation BKHomeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //有这两行代码，navVC下的view才不会跑偏
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = [UIColor whiteColor];
  
    //BKAdsView * adsView = [[BKAdsView alloc] initWithFrame:CGRectMake(0, 0, BKScreenWidth, 200)];
    BKAdsView * adsView = [[BKAdsView alloc] init];

    //LYAdsView * adsView = [[LYAdsView alloc] init];
    NSMutableArray * array = [NSMutableArray array];
    
    UIImage * image1 = [UIImage imageNamed:@"ads_01"];
    [array addObject:image1];
    UIImage * image2 = [UIImage imageNamed:@"ads_02"];
    [array addObject:image2];
    UIImage * image3 = [UIImage imageNamed:@"ads_03"];
    [array addObject:image3];
    UIImage * image4 = [UIImage imageNamed:@"ads_04"];
    [array addObject:image4];
    UIImage * image5 = [UIImage imageNamed:@"ads_05"];
    [array addObject:image5];
    

    adsView.ads = array;
    
    [self.view addSubview:adsView];
    
    [self setupAdsInfo];
    
}

/**
 *  获得用户信息
 */
- (void)setupAdsInfo
{
    //1.封装请求参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    //2.发送请求
    NSString * urlStr = [NSString stringWithFormat:@"%@get_ads_info", BKUrlStr];
    [BKHttpTool post:urlStr params:params success:^(id responseObj) {
        
        BKLog(@"1111----%@", responseObj);
        
    } failure:^(NSError * error) {
        
        BKLog(@"请求失败-------%@", error);
        
    }];
    
//    //2.发送请求
//    [BKHttpTool post:@"http://192.168.10.8:8089/get_course_category" params:params success:^(id responseObj) {
//        
//        BKLog(@"2222-----%@", responseObj);
//        
//    } failure:^(NSError * error) {
//        
//        BKLog(@"请求失败-------%@", error);
//        
//    }];
//    
//    //2.发送请求
//    params[@"category_id"] = @"3";
//    [BKHttpTool post:@"http://192.168.10.8:8089/get_course_info" params:params success:^(id responseObj) {
//        
//        BKLog(@"3333----%@", responseObj);
//        
//    } failure:^(NSError * error) {
//        
//        BKLog(@"请求失败-------%@", error);
//        
//    }];
}


@end
