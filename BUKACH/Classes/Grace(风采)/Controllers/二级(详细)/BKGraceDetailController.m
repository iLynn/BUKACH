//
//  BKGraceDetailController.m
//  BUKACH
//
//  Created by Lynn on 15/6/24.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKGraceDetailController.h"
#import "BKOneGraceModel.h"
#import "BKHttpTool.h"
#import "BKGraceResponse.h"

#import "UIImageView+WebCache.h"
#import "BKPhotosView.h"

@interface BKGraceDetailController ()

@property (nonatomic, weak) BKPhotosView * contentView;

@property (nonatomic, strong) NSArray * photoArray;

@end

@implementation BKGraceDetailController

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


- (void)setGrace:(BKOneGraceModel *)grace
{
    _grace = grace;
    
    self.navigationItem.title = grace.grace_title;
    
    NSString * str = grace.grace_id;
    
    [self getGraceDetailWithGraceID:str];

    
}

- (void)getGraceDetailWithGraceID:(NSString *)ID
{
    
    //1.封装请求参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"grace_id"] = ID;
    
    //2.发送请求
    NSString * urlStr = [NSString stringWithFormat:@"%@get_grace_detail", BKUrlStr];
    
    [BKHttpTool post:urlStr params:params success:^(NSDictionary * graceResponse) {

        BKGraceResponse * response = [BKGraceResponse graceResponseWithDict:graceResponse];
        
        //只有一个grace
        if (response.data.count > 0)
        {
            BKOneGraceModel * model = response.data[0];
            
            //有详细图片时
            if (model.grace_photo_array.count > 0)
            {
                self.contentView.photos = model.grace_photo_array;
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
