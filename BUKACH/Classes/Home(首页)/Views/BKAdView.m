//
//  BKAdView.m
//  BUKACH
//
//  Created by Lynn on 15/6/16.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKAdView.h"
#import "BKAdsModel.h"
#import "UIButton+WebCache.h"

@implementation BKAdView

//重写初始化方法
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //内部图标居中
        self.imageView.contentMode = UIViewContentModeCenter;
        self.adjustsImageWhenHighlighted = NO;
        
        //内部文字靠左对齐
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
    return self;
}

-(void)setAd:(BKAdsModel *)ad
{
    _ad = ad;
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@", BKUrlStr, ad.ads_photo];
    
    [self sd_setBackgroundImageWithURL:[NSURL URLWithString:urlStr] forState:UIControlStateNormal];
    
}

@end
