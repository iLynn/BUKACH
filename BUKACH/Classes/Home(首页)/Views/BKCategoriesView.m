//
//  BKCategoriesView.m
//  BUKACH
//
//  Created by Lynn on 15/6/16.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKCategoriesView.h"
#import "BKLeftRightView.h"
#import "BKUpDownView.h"
#import "BKCategoryModel.h"

#define BKCurrentWidth self.bounds.size.width
#define BKCurrentHeight self.bounds.size.height

@implementation BKCategoriesView

+(id)categoriesView
{
    return [[self alloc] initWithFrame:CGRectZero];
}

//只要是alloc方式创建的View,这个一定会被调用
- (id)initWithFrame:(CGRect)frame
{
    return [super initWithFrame:frame];
}

-(void)setCategories:(NSArray *)categories
{
    _categories = categories;
    
    //此处添加子控件才合理
    [self createSubViews];

}

- (void)createSubViews
{
    //1.第0个和第7个上下结构，其他左右结构
    for (int i = 0; i <= _categories.count - 1; i++)
    {
        BKCategoryView * cateView;
        if (i == 0 || i == 7)
        {
            cateView = [[BKUpDownView alloc] init];
        }
        else
        {
            cateView = [[BKLeftRightView alloc] init];
        }
        
        //切割圆角
        cateView.layer.cornerRadius = BKCornerRadius;
        cateView.layer.masksToBounds = YES;
        
        //赋值填充UI
        cateView.category = _categories[i];
        
        //添加事件
        [cateView addTarget:self action:@selector(cateViewTouch:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:cateView];
        
    }
    
    [self getSubviewFrames];
    
}

- (void)cateViewTouch:(BKCategoryView *)categoryView
{
    //通知代理响应操作
    if ([self.delegate respondsToSelector:@selector(jumpToCategoryWithModel:)])
    {
        [self.delegate jumpToCategoryWithModel:categoryView.category];
    }
}

//定制布局
-(void)getSubviewFrames
{
    NSInteger baseCount = (_categories.count + 2) / 2;
    
    CGFloat baseHeight = ( BKCurrentHeight - BKMargin * (baseCount - 1) )/ baseCount;
    
    CGFloat baseWidth = ( BKCurrentWidth - BKMargin ) / 2;
    
    CGFloat viewX = 0;
    CGFloat viewY = 0;
    CGFloat viewH = 0;
    
    for (BKCategoryView * view in self.subviews)
    {
        BKCategoryModel * model = view.category;
        
        view.backgroundColor = BKRandomColor;
        
        NSString * ID = [NSString stringWithFormat:@"%@", model.category_id];
        
        //高度
        if ([ID isEqualToString:@"1"] || [ID isEqualToString:@"8"])
        {
            viewH = 2 * baseHeight + BKMargin;
        }
        else
        {
            viewH = baseHeight;
        }
        
        //Y值
        if ([ID isEqualToString:@"1"] || [ID isEqualToString:@"2"])
        {
            viewY = 0;
        }
        else if ([ID isEqualToString:@"3"])
        {
            viewY = BKMargin + baseHeight;
        }
        else if ([ID isEqualToString:@"4"] || [ID isEqualToString:@"5"])
        {
            viewY = (BKMargin + baseHeight ) * 2;
        }
        else if ([ID isEqualToString:@"6"] || [ID isEqualToString:@"8"])
        {
            viewY = (BKMargin + baseHeight ) * 3;
        }
        //符合行号为 id/2 向上取整时：7符合
        else
        {
            NSInteger row = ceil( ID.floatValue / 2);
            
            viewY = (BKMargin + baseHeight ) * row;
        }
        
        //X值
        if ([ID isEqualToString:@"4"] || [ID isEqualToString:@"6"])
        {
            viewX = 0;
        }
        else if ([ID isEqualToString:@"3"] || [ID isEqualToString:@"5"])
        {
            viewX = BKMargin + baseWidth;
        }
        //符合奇数在左，偶数在右规律时：1，7，2，8符合
        else
        {
            NSInteger column = (ID.integerValue % 2) == 0 ? 1 : 0;
            
            viewX = ( BKMargin + baseWidth ) * column;
        }
        
        
        //设置frame
        view.frame = CGRectMake(viewX, viewY, baseWidth, viewH);
        
    }
    
}


@end
