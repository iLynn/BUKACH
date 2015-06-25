//
//  BKAdsController.m
//  BUKACH
//
//  Created by Lynn on 15/6/16.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKAdsController.h"
#import "BKOneAdsModel.h"

@interface BKAdsController ()

@end

@implementation BKAdsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)setAds:(BKOneAdsModel *)ads
{
    _ads = ads;
    
    self.navigationItem.title = ads.ads_title;
    
#warning 等待接口，再继续做
    
}


@end
