//
//  LYAdsView.h
//  重构-豆果美食
//
//  Created by qianfeng on 15-4-27.
//  Copyright (c) 2015年 李颖. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYAdsView : UIView

/**装有多个ads模型对象的数组*/
@property(nonatomic, strong)NSArray * ads;

+(id)adsView;

@end
