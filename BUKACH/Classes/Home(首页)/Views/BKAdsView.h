//
//  BKAdsView.h
//  BUKACH
//
//  Created by Lynn on 15/6/15.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BKAdsView : UIView

/**装有多个ads模型对象的数组*/
@property(nonatomic, strong)NSArray * ads;

+(id)adsView;

@end
