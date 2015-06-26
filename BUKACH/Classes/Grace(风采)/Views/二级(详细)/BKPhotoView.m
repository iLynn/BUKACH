//
//  BKPhotoView.m
//  BUKACH
//
//  Created by Lynn on 15/6/24.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKPhotoView.h"
#import "UIImageView+WebCache.h"

@implementation BKPhotoView

-(void)setPhoto_url:(NSString *)photo_url
{
    _photo_url = photo_url;
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@", BKUrlStr, photo_url];

    [self sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    
}

@end
