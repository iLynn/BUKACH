//
//  BKPhotosView.h
//  BUKACH
//
//  Created by Lynn on 15/6/24.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BKPhotosView : UIView

/** photos里存放的是photo_url的字符串 */
@property (nonatomic, strong) NSArray * photos;

+ (id)photosView;

@end
