//
//  BKHotCell.h
//  BUKACH
//
//  Created by Lynn on 15/6/26.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BKOneHotModel;

@interface BKHotCell : UICollectionViewCell

@property (nonatomic, strong) BKOneHotModel * hot;

+ (id)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath andIdentifier:(NSString *)ID;

@end
