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
#import "BKGraceFrame.h"

@interface BKGraceCell()

@property (nonatomic, weak) UILabel * titleLab;

@property (nonatomic, weak) UIImageView * photoView;

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
        titleLab.numberOfLines = 0;
        titleLab.font = BKCustomFont;
        titleLab.textColor = BKCustomColor;
        self.titleLab = titleLab;
        
        //2.照片
        UIImageView * photoView = [[UIImageView alloc] init];
        [self addSubview:photoView];
        self.photoView = photoView;
        
    }
    return self;
}

- (void)setGraceFrame:(BKGraceFrame *)graceFrame
{
    //计算frame
    self.titleLab.frame = graceFrame.titleFrame;
    
    self.photoView.frame = graceFrame.photoFrame;
    
    //填充界面
    BKOneGraceModel * grace = graceFrame.grace;
    
    self.titleLab.text = grace.grace_title;
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@", BKUrlStr, grace.grace_photo];
    
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"bukach_wait"]];
    
}


@end
