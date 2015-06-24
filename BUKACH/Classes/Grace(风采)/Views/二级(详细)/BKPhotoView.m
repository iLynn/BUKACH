//
//  BKPhotoView.m
//  BUKACH
//
//  Created by Lynn on 15/6/24.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKPhotoView.h"
#import "BKGracePhotoModel.h"
#import "UIImageView+WebCache.h"

@implementation BKPhotoView

-(void)setPhoto:(BKGracePhotoModel *)photo
{
    _photo = photo;
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@", BKUrlStr, photo.img_location];

    [self sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    
}

@end
