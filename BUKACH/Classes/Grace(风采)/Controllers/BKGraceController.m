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

@interface BKGraceController ()<BKGraceWaterFlowViewDataSource, BKGraceWaterFlowViewDelegate>

/** 存放BKOneGraceModel模型的数组 */
@property (nonatomic, strong) NSArray * graces;

@property (nonatomic, weak) BKGraceWaterFlowView * waterFlowView;

@end

@implementation BKGraceController

//懒加载
- (NSArray *)graces
{
    if (_graces == nil)
    {
        _graces = [NSArray array];
    }
    
    return _graces;
}

- (void)viewDidLoad
{
    BKLog(@"%s", __func__);
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
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
        
        self.graces = response.data;
        
        BKLog(@"%@", self.graces);
        
        //添加风采视图
        BKGraceWaterFlowView * waterFlowView = [[BKGraceWaterFlowView alloc] init];
        waterFlowView.backgroundColor = [UIColor lightGrayColor];
        
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


#pragma mark - datasource数据源代理方法

- (NSUInteger)numberOfColumnsInWaterFlowView:(BKGraceWaterFlowView *)waterFlowView
{
    return 2;
}

- (NSUInteger)numberOfCellsInWaterFlowView:(BKGraceWaterFlowView *)waterFlowView
{
    return self.graces.count;
}

- (BKWaterFlowBaseCell *)waterFlowView:(BKGraceWaterFlowView *)waterFlowView cellAtIndex:(NSUInteger)index
{
    BKGraceCell * cell = [BKGraceCell cellWithWaterFlowView:waterFlowView];
    
    cell.backgroundColor = [UIColor yellowColor];
    
    cell.grace = self.graces[index];
    
    return cell;
    
}


#pragma mark - delegate代理方法

- (CGFloat)waterFlowView:(BKGraceWaterFlowView *)waterFlowView heightAtIndex:(NSUInteger)index
{
    //BKOneGraceModel * grace = self.graces[index];
    
    CGFloat h = 0;
    
    if (index == 0)
    {
        h = 150;
    }
    else if (index == 1)
    {
        h = 180;
    }
    else
    {
        h = 200;
    }
    
    return h;
}

@end
