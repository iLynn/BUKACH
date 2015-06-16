//
//  BKAdView.h
//  BUKACH
//
//  Created by Lynn on 15/6/16.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BKAdsModel;

@interface BKAdView : UIButton

/** 用于填充view的模型 */
@property(nonatomic, strong) BKAdsModel * ad;

@end
