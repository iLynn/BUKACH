//
//  BKAdsController.m
//  BUKACH
//
//  Created by Lynn on 15/6/16.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKAdsController.h"
#import "BKOneAdsModel.h"
#import "BKHttpTool.h"
#import "BKAdsResponse.h"
#import "BKPhotosView.h"

@interface BKAdsController ()

@property (nonatomic, weak) BKPhotosView * contentView;

@property (nonatomic, strong) NSArray * photoArray;

@end

@implementation BKAdsController

//懒加载
- (NSArray *)photoArray
{
    if (_photoArray == nil)
    {
        _photoArray = [NSArray array];
    }
    
    return _photoArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //有这两行代码，navVC下的view才不会跑偏
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    BKPhotosView * contentView = [BKPhotosView photosView];
    self.view = contentView;
    
    self.contentView = contentView;
    
}

- (void)setAds:(BKOneAdsModel *)ads
{
    _ads = ads;
    
    self.navigationItem.title = ads.ads_title;
    
    NSString * str = ads.ads_id;
    
    [self getAdDetailWithAdsID:str];
    
}

- (void)getAdDetailWithAdsID:(NSString *)ID
{
    //1.封装请求参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"ad_id"] = ID;
    
    //2.发送请求
    NSString * urlStr = [NSString stringWithFormat:@"%@get_ad_detail", BKUrlStr];
    
    [BKHttpTool post:urlStr params:params success:^(NSDictionary * adResponse) {
        
        BKAdsResponse * response = [BKAdsResponse adsResponseWithDict:adResponse];
        
        //只有一个ad
        if (response.data.count > 0)
        {
            BKOneAdsModel * model = response.data[0];
            
            //有详细图片时
            if (model.hot_photo_array.count > 0)
            {
                self.contentView.photos = model.hot_photo_array;
            }
            else
            {
                BKLog(@"no ad detail photos");
            }
        }
        
        
    } failure:^(NSError * error) {
        
        BKLog(@"请求失败-------%@", error);
        
    }];
}



@end
