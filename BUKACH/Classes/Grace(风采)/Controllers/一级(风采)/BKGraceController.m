//
//  BKGraceController.m
//  BUKACH
//
//  Created by Lynn on 15/6/13.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKGraceController.h"
#import "BKHttpTool.h"
#import "BKGraceResponse.h"
#import "BKGraceWaterFlowView.h"
#import "BKWaterFlowBaseCell.h"

#import "BKOneGraceModel.h"
#import "BKGraceCell.h"
#import "BKGraceFrame.h"
#import "BKGraceDetailController.h"

@interface BKGraceController ()<BKGraceWaterFlowViewDataSource, BKGraceWaterFlowViewDelegate>

/** 存放BKGraceFrame模型的数组 */
@property (nonatomic, strong) NSArray * graceFrames;

@property (nonatomic, weak) BKGraceWaterFlowView * waterFlowView;

@end

@implementation BKGraceController

//懒加载
- (NSArray *)graceFrames
{
    if (_graceFrames == nil)
    {
        _graceFrames = [NSArray array];
    }
    
    return _graceFrames;
}

- (void)viewDidLoad
{
    BKLog(@"%s", __func__);
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.864 alpha:1.000];
    
    //有这两行代码，navVC下的view才不会跑偏
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;

    [self getGraceInfo];
    
}

- (void)getGraceInfo
{
    //1.封装请求参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    //2.发送请求
    NSString * urlStr = [NSString stringWithFormat:@"%@get_all_grace", BKUrlStr];
    
    [BKHttpTool post:urlStr params:params success:^(NSDictionary * graceResponse) {
        
        // 字典转模型
        BKGraceResponse * response = [BKGraceResponse graceResponseWithDict:graceResponse];
        
        // 获取courseFrame的数组
        self.graceFrames = [self graceFramesWithGraces:response.data];
  
        //添加风采视图
        BKGraceWaterFlowView * waterFlowView = [[BKGraceWaterFlowView alloc] init];
        
        waterFlowView.frame = CGRectMake(0, 0, BKScreenWidth, BKScreenHeight - 20 - 44 - 49);
        
        waterFlowView.dataSource = self;
        
        waterFlowView.BKdelegate = self;
        
        self.waterFlowView = waterFlowView;
        
        [self.view addSubview:waterFlowView];
        
        // 填充UI
        [self.waterFlowView reloadData];
        
    } failure:^(NSError * error)
     {
         BKLog(@"请求失败-------%@", error);
         
     }];
    
}


/**
 *  将 grace模型数组 转成 graceFrame模型数据
 */
- (NSArray *)graceFramesWithGraces:(NSArray *)graces
{
    NSMutableArray * frames = [NSMutableArray array];
    for (BKOneGraceModel * grace in graces)
    {
        BKGraceFrame * frame = [[BKGraceFrame alloc] init];
        
        // 传递grace模型数据，计算所有子控件的frame
        frame.grace = grace;
        
        [frames addObject:frame];
    }
    return frames;
}


#pragma mark - datasource数据源代理方法

- (NSUInteger)numberOfColumnsInWaterFlowView:(BKGraceWaterFlowView *)waterFlowView
{
    return 2;
}

- (NSUInteger)numberOfCellsInWaterFlowView:(BKGraceWaterFlowView *)waterFlowView
{
    return self.graceFrames.count;
}

- (BKWaterFlowBaseCell *)waterFlowView:(BKGraceWaterFlowView *)waterFlowView cellAtIndex:(NSUInteger)index
{
    BKGraceCell * cell = [BKGraceCell cellWithWaterFlowView:waterFlowView];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.graceFrame = self.graceFrames[index];
    
    //把index记录下来，在点击时可以用到
    cell.tag = index;
    
    [cell addTarget:self action:@selector(cellTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}


#pragma mark - delegate代理方法

- (CGFloat)waterFlowView:(BKGraceWaterFlowView *)waterFlowView heightAtIndex:(NSUInteger)index
{
    BKGraceFrame * frame = self.graceFrames[index];
    
    return frame.cellHeight;
}

- (void)cellTouch:(BKGraceCell *)cell
{
    // 立即取消选中
    BKGraceFrame * frame = self.graceFrames[cell.tag];
    
    // 跳转到新的控制器
    BKGraceDetailController * vc = [[BKGraceDetailController alloc] init];
    
    vc.grace = frame.grace;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
