//
//  BKAdsView.h
//  BUKACH
//
//  Created by Lynn on 15/6/15.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BKAdsModel;

@protocol BKAdsViewDelegate <NSObject>

- (void)jumpToAdsWithModel:(BKAdsModel *)ad;

@end

@interface BKAdsView : UIView

/** 装有多个ads模型对象的数组 */
@property (nonatomic, strong) NSArray * ads;

@property (nonatomic, strong) id <BKAdsViewDelegate> delegate;

/** 快速创建的方法 */
+(id)adsView;

@end
