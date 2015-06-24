//
//  BKGraceWaterFlowView.h
//  BUKACH
//
//  Created by Lynn on 15/6/23.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    BKWaterFlowMarginTypeTop,
    BKWaterFlowMarginTypeBottom,
    BKWaterFlowMarginTypeLeft,
    BKWaterFlowMarginTypeRight,
    BKWaterFlowMarginTypeColumn, // 每一列
    BKWaterFlowMarginTypeRow, // 每一行
} BKWaterFlowMarginType;

@class BKGraceWaterFlowView, BKWaterFlowBaseCell;

#pragma mark - 数据源方法(协议)

@protocol BKGraceWaterFlowViewDataSource <NSObject>

@required

/** 一共有多少个cell */
- (NSUInteger)numberOfCellsInWaterFlowView:(BKGraceWaterFlowView *)waterFlowView;

/** 返回index位置对应的cell */
- (BKWaterFlowBaseCell *)waterFlowView:(BKGraceWaterFlowView *)waterFlowView cellAtIndex:(NSUInteger)index;

@optional
/** 一共有多少列 */
- (NSUInteger)numberOfColumnsInWaterFlowView:(BKGraceWaterFlowView *)waterFlowView;

@end

#pragma mark - 代理方法(对操作的响应)

@protocol BKGraceWaterFlowViewDelegate <UIScrollViewDelegate>

@optional

/** 第index位置cell对应的高度 */
- (CGFloat)waterFlowView:(BKGraceWaterFlowView *)waterFlowView heightAtIndex:(NSUInteger)index;

/** 选中第index位置的cell */
- (void)waterFlowView:(BKGraceWaterFlowView *)waterFlowView didSelectAtIndex:(NSUInteger)index;

/** 返回间距 */
- (CGFloat)waterFlowView:(BKGraceWaterFlowView *)waterFlowView marginForType:(BKWaterFlowMarginType)type;

@end

#pragma mark - 瀑布流控件

@interface BKGraceWaterFlowView : UIScrollView

/** 数据源 */
@property (nonatomic, weak) id<BKGraceWaterFlowViewDataSource> dataSource;

/** 代理 */
@property (nonatomic, weak) id<BKGraceWaterFlowViewDelegate> BKdelegate;

/** 刷新数据（只要调用这个方法，会重新向数据源和代理发送请求，请求数据） */
- (void)reloadData;

/** cell的宽度 */
- (CGFloat)cellWidth;

/** 根据标识去缓存池查找可循环利用的cell */
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier;

@end
