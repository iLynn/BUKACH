//
//  BKCategoryView.m
//  BUKACH
//
//  Created by Lynn on 15/6/16.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKCategoryView.h"
#import "BKCategoryModel.h"
#import "UIButton+WebCache.h"

@implementation BKCategoryView

-(void)setCategory:(BKCategoryModel *)category
{
    _category = category;
    
    [self setTitle:category.category_name forState:UIControlStateNormal];
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@", BKUrlStr, category.category_photo];
    
    [self sd_setImageWithURL:[NSURL URLWithString:urlStr] forState:UIControlStateNormal];
    
}

@end
