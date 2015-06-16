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

-(void)setCategory:(BKCategoryModel *)category
{
    _category = category;
    
    [self setTitle:category.category_name forState:UIControlStateNormal];
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@", BKUrlStr, category.category_photo];
    
    [self sd_setImageWithURL:[NSURL URLWithString:urlStr] forState:UIControlStateNormal];
    
}

@end
