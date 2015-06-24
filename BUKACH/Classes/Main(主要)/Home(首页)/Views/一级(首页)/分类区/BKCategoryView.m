//
//  BKCategoryView.m
//  BUKACH
//
//  Created by Lynn on 15/6/16.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKCategoryView.h"
#import "BKOneCategoryModel.h"
#import "UIImageView+WebCache.h"

@interface BKCategoryView()

@end

@implementation BKCategoryView

//重写初始化方法
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //1.图片
        UIImageView * iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        
        self.iconView = iconView;
        
        
        //2.文字
        UILabel * nameLab = [[UILabel alloc] init];
        [self addSubview:nameLab];
        
        nameLab.font = [UIFont systemFontOfSize:16];
        nameLab.textColor = [UIColor whiteColor];
        
        self.nameLab = nameLab;
        
    }
    
    return self;
    
}

- (void)setCategory:(BKOneCategoryModel *)category
{
    _category = category;
    
    self.nameLab.text = category.category_name;
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@", BKUrlStr, category.category_photo];
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:urlStr]];

    
}

@end
