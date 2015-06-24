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
#import "BKGracePhotoModel.h"

#import "UIImageView+WebCache.h"
#import "BKPhotosView.h"

@interface BKGraceDetailController ()

//@property (nonatomic, weak) UIScrollView * contentView;

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
    
    BKLog(@"%@", NSStringFromCGRect(self.contentView.frame));
    
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
        
#warning 提醒后台修改字段名？
        BKGraceResponse * response = [BKGraceResponse graceResponseWithDict:graceResponse];
        
        //只有一个grace
        if (response.data.count > 0)
        {
            BKOneGraceModel * model = response.data[0];
            
            self.contentView.photos = model.grace_photo_array;
        }
        
    } failure:^(NSError * error) {
        
        BKLog(@"请求失败-------%@", error);
        
    }];
}


@end
