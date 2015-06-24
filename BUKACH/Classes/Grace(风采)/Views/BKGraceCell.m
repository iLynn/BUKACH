//
//  BKGraceCell.m
//  BUKACH
//
//  Created by Lynn on 15/6/23.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKGraceCell.h"
#import "BKGraceWaterFlowView.h"
#import "BKOneGraceModel.h"
#import "UIImageView+WebCache.h"

@interface BKGraceCell()

@property (nonatomic, weak) UILabel * titleLab;

@property (nonatomic, weak) UIImageView * imageView;

@end

@implementation BKGraceCell

+ (id)cellWithWaterFlowView:(BKGraceWaterFlowView *)waterFlowView
{
    static NSString * ID = @"Grace";
    
    BKGraceCell * cell = [waterFlowView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil)
    {
        cell = [[BKGraceCell alloc] init];
        
        cell.identifier = ID;
    }
    
    return cell;
    
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //1.文字
        UILabel * titleLab = [[UILabel alloc] init];
        [self addSubview:titleLab];
        titleLab.backgroundColor = [UIColor redColor];
        titleLab.font = [UIFont systemFontOfSize:14];
        self.titleLab = titleLab;
        
        //2.照片
        UIImageView * imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        imageView.backgroundColor = [UIColor blueColor];
        self.imageView = imageView;
        
    }
    return self;
}

- (void)setGrace:(BKOneGraceModel *)grace
{
    _grace = grace;
    
    self.titleLab.text = grace.grace_title;
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@", BKUrlStr, grace.grace_photo];

    [self.imageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
    
    CGFloat titleX = 0;
    CGFloat titleH = 25;
    CGFloat titleY = self.bounds.size.height - titleH;
    CGFloat titleW = self.bounds.size.width;
    
    self.titleLab.frame = CGRectMake(titleX, titleY, titleW, titleH);
}

@end
