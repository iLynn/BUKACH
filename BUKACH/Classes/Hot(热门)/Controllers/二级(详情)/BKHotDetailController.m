//
//  BKHotDetailController.m
//  BUKACH
//
//  Created by Lynn on 15/6/26.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKHotDetailController.h"
#import "BKOneHotModel.h"
#import "BKPhotosView.h"
#import "BKHttpTool.h"
#import "BKOneHotResponse.h"

@interface BKHotDetailController ()

@property (nonatomic, weak) BKPhotosView * contentView;

@property (nonatomic, strong) NSArray * photoArray;

@end


@implementation BKHotDetailController

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

- (void)setHot:(BKOneHotModel *)hot
{
    _hot = hot;

    self.navigationItem.title = hot.hot_title;
    
    NSString * str = hot.hot_id;
    
    [self getHotDetailWithHotID:str];
    
    
}

- (void)getHotDetailWithHotID:(NSString *)ID
{
    
    //1.封装请求参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"hot_id"] = ID;
    
    //2.发送请求
    NSString * urlStr = [NSString stringWithFormat:@"%@get_hot_detail", BKUrlStr];
    
    [BKHttpTool post:urlStr params:params success:^(NSDictionary * hotResponse) {
        
        BKOneHotResponse * response = [BKOneHotResponse oneHotResponseWithDict:hotResponse];
        
        //只有一个grace
        if (response.data.count > 0)
        {
            BKOneHotModel * model = response.data[0];
            
            //有详细图片时
            if (model.hot_photo_array.count > 0)
            {
                self.contentView.photos = model.hot_photo_array;
            }
            else
            {
                BKLog(@"no grace detail photos");
            }
        }
        
    } failure:^(NSError * error) {
        
        BKLog(@"请求失败-------%@", error);
        
    }];
}


@end
