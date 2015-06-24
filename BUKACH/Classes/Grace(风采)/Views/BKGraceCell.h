//
//  BKGraceCell.h
//  BUKACH
//
//  Created by Lynn on 15/6/23.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKWaterFlowBaseCell.h"
@class BKOneGraceModel, BKGraceWaterFlowView;

@interface BKGraceCell : BKWaterFlowBaseCell

+ (id)cellWithWaterFlowView:(BKGraceWaterFlowView *)waterFlowView;

@property (nonatomic, strong) BKOneGraceModel * grace;

@end
