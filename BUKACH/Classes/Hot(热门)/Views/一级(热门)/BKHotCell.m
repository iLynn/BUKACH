//
//  BKHotCell.m
//  BUKACH
//
//  Created by Lynn on 15/6/26.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKHotCell.h"
#import "BKOneHotModel.h"
#import "UIImageView+WebCache.h"

@interface BKHotCell()

@property (nonatomic, weak) UIImageView * imageView;

@property (nonatomic, weak) UILabel * titleLab;

@end

@implementation BKHotCell

+ (id)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath andIdentifier:(NSString *)ID
{
    //此dequeue方法，没有会自动创建一个新的
    BKHotCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];

    return cell;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
        //1.图片
        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BKCurrentWidth, BKCurrentHeight * 0.8)];
        
        [self.contentView addSubview:image];
        
        self.imageView = image;
        
        //2.标题
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imageView.frame), BKCurrentWidth, BKCurrentHeight * 0.2)];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = BKCustomFont;
        lab.textColor = BKCustomColor;
        
        [self.contentView addSubview:lab];
        
        self.titleLab = lab;
        
    }
    return self;
}

- (void)setHot:(BKOneHotModel *)hot
{
    _hot = hot;
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@", BKUrlStr, hot.hot_photo];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    
    self.titleLab.text = hot.hot_title;
    
}

@end
