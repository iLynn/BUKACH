//
//  BKRefreshView.m
//  BUKACH
//
//  Created by Lynn on 15/6/25.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKRefreshView.h"

@interface BKRefreshView()

@property (weak, nonatomic) UILabel * label;

@property (weak, nonatomic) UIActivityIndicatorView * indicator;

@end

@implementation BKRefreshView

+ (id)refreshView
{
    return [[self alloc] init];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //1. 文字
        UILabel * label = [[UILabel alloc] init];
        label.font = BKCustomFont;
        label.textColor = BKUnhighlightColor;
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        self.label = label;
        
        //2. 菊花
        UIActivityIndicatorView * indicator = [[UIActivityIndicatorView alloc] init];
        [self addSubview:indicator];
        
        self.indicator = indicator;
        
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    self.label.text = title;
    
    //设置frame值
    //1. 文字
    NSMutableDictionary * dictTitle = [NSMutableDictionary dictionary];
    dictTitle[NSFontAttributeName] = BKCustomFont;
    
    self.label.size = [title sizeWithAttributes:dictTitle];

    CGFloat titleX = ( BKCurrentWidth - self.label.width - BKCustomMargin ) * 0.5;
    CGFloat titleY = ( BKCurrentHeight - self.label.height ) * 0.5;

    self.label.origin = CGPointMake(titleX, titleY);
    
    //2. 菊花：菊花的size固定是(20, 20)
    CGFloat indicatorX = CGRectGetMaxX(self.label.frame) + BKCustomMargin;
    CGFloat indicatorY = ( BKCurrentHeight - 20) * 0.5;
    
    self.indicator.origin = CGPointMake(indicatorX, indicatorY);
    
}

- (void)beginRefreshingWithTitle:(NSString *)title
{
    self.label.text = title;
    [self.indicator startAnimating];
    self.refreshStatus = YES;
}

- (void)endRefreshingWithTitle:(NSString *)title
{
    self.label.text = title;
    [self.indicator stopAnimating];
    self.refreshStatus = NO;
}

@end
