//
//  BKSectionHeaderView.m
//  BUKACH
//
//  Created by Lynn on 15/6/26.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKSectionHeaderView.h"
#import "BKHotTypeModel.h"

@interface BKSectionHeaderView()

@property (nonatomic, weak) UILabel * titleLab;

@property (nonatomic, weak) UILabel * statusTextLab;

@property (nonatomic, weak) UIImageView * imageView;

@end

@implementation BKSectionHeaderView

+ (id)viewWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath andIdentifier:(NSString *)ID andSupplementaryKind:(NSString *)kind
{
    //此dequeue方法，没有会自动创建一个新的
    BKSectionHeaderView * view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:ID forIndexPath:indexPath];
    
    view.backgroundColor = [UIColor whiteColor];
    
    return view;
    
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //1.标题
        UILabel * titleLab = [[UILabel alloc] initWithFrame:CGRectMake(BKCustomMargin, 0, BKCurrentWidth * 0.5, BKCurrentHeight)];
        titleLab.font = BKHighlightFont;
        titleLab.textColor = BKHighlightColor;
        
        [self addSubview:titleLab];
        
        self.titleLab = titleLab;
        
        //2.文字
        UILabel * statusTextLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLab.frame), 0, BKCurrentWidth * 0.4, BKCurrentHeight)];
        statusTextLab.textAlignment = NSTextAlignmentRight;
        statusTextLab.font = BKCustomFont;
        statusTextLab.textColor = BKCustomColor;
        
        [self addSubview:statusTextLab];
        
        self.statusTextLab = statusTextLab;
        
        //3.图标：找一个像素点是20*15的图标图片
        CGFloat imageX = CGRectGetMaxX(self.statusTextLab.frame);
        CGFloat imageY = ( BKCurrentHeight - 15 ) * 0.5;
        CGFloat imageW = 20;
        CGFloat imageH = 15;
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
        
        [self addSubview:imageView];
        
        self.imageView = imageView;
        
    }
    
    return self;
}

- (void)setType:(BKHotTypeModel *)type
{
    _type = type;
    
    self.titleLab.text = type.hot_type_name;
    
}

- (void)setStatusStr:(NSString *)statusStr
{
    _statusStr = statusStr;
    
    self.statusTextLab.text = statusStr;
    
}

- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    
    self.imageView.image = [UIImage imageNamed:imageName];
    
}

@end
