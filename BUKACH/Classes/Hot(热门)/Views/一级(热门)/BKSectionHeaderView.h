//
//  BKSectionHeaderView.h
//  BUKACH
//
//  Created by Lynn on 15/6/26.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BKHotTypeModel, BKSectionHeaderView;

@interface BKSectionHeaderView : UICollectionReusableView

@property (nonatomic, strong) BKHotTypeModel * type;

@property (nonatomic, strong) NSString * statusStr;

@property (nonatomic, strong) NSString * imageName;


+ (id)viewWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath andIdentifier:(NSString *)ID andSupplementaryKind:(NSString *)kind;

@end
