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

#import "MJRefresh.h"
#import "SVProgressHUD.h"

@interface BKGraceController ()<BKGraceWaterFlowViewDataSource, BKGraceWaterFlowViewDelegate>

/** 存放所有BKGraceFrame模型的数组 */
@property (nonatomic, strong) NSMutableArray * graceFrames;

/** 存放本次加载的BKGraceFrame模型的数组 */
@property (nonatomic, strong) NSMutableArray * newGraceFrames;

@property (nonatomic, weak) BKGraceWaterFlowView * waterFlowView;

@property (nonatomic, assign) NSInteger end;

@end

@implementation BKGraceController

//懒加载
- (NSMutableArray *)graceFrames
{
    if (_graceFrames == nil)
    {
        _graceFrames = [NSMutableArray array];
    }
    
    return _graceFrames;
}

//懒加载
- (NSMutableArray *)newGraceFrames
{
    if (_newGraceFrames == nil)
    {
        _newGraceFrames = [NSMutableArray array];
    }
    
    return _newGraceFrames;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.864 alpha:1.000];
    
    //有这两行代码，navVC下的view才不会跑偏
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // 添加风采视图
    BKGraceWaterFlowView * waterFlowView = [[BKGraceWaterFlowView alloc] init];
    
    waterFlowView.frame = CGRectMake(0, 0, BKScreenWidth, BKScreenHeight - 20 - 44 - 49);
    
    waterFlowView.dataSource = self;
    
    waterFlowView.BKdelegate = self;
    
    waterFlowView.delegate = self;
    
    self.waterFlowView = waterFlowView;
    
    [self.view addSubview:waterFlowView];
    
    
    //1.添加下拉、上拉刷新控件
    [self setupRefresh];
    
    //2.加载数据
    [self getGraceInfoWithStart:0 andEnd:4];
    
    //先自动滚一下，不然UI填充不起来，原因未知
    self.waterFlowView.contentOffset = CGPointMake(0, -100);
    [self scrollViewDidScroll:self.waterFlowView];
    
}

/** 添加下拉、上拉刷新控件 */
- (void)setupRefresh
{
    __weak BKGraceWaterFlowView * scrollView = self.waterFlowView;
    
    // 下拉刷新
    scrollView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getGraceInfoWithStart:0 andEnd:4];
        
        [scrollView.header endRefreshing];
     
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    scrollView.header.autoChangeAlpha = YES;
    
    // 上拉刷新
    scrollView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{

        [self getGraceInfoWithStart:self.end andEnd:self.end + 4];
        
        [scrollView.footer endRefreshing];

    }];
    
}

- (void)getGraceInfoWithStart:(NSInteger)start andEnd:(NSInteger)end
{
    self.end = end;
    
    //加载网络请求
    [SVProgressHUD show];
    
    //1.封装请求参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"start"] = [NSString stringWithFormat:@"%ld", start];
    params[@"end"] = [NSString stringWithFormat:@"%ld", end];
    
    //2.发送请求
    NSString * urlStr = [NSString stringWithFormat:@"%@get_all_grace", BKUrlStr];
    
    [BKHttpTool post:urlStr params:params success:^(NSDictionary * graceResponse) {

        // 字典转模型
        BKGraceResponse * response = [BKGraceResponse graceResponseWithDict:graceResponse];
        
        // 获取courseFrame的数组
        self.newGraceFrames = [self graceFramesWithGraces:response.data];
        
        //如果从零开始
        if (start == 0)
        {
            self.graceFrames = self.newGraceFrames;
        }
        else
        {
            //上拉加载更多，在原基础上加1页数据
            //首先去除之前存储的数据，拼接成一个新的数组，再传递回去
            NSMutableArray * newObjs = [NSMutableArray arrayWithArray:self.graceFrames];
            [newObjs addObjectsFromArray:self.newGraceFrames];
            self.graceFrames = newObjs;
            
        }
        
        // 填充UI
        [self.waterFlowView reloadData];
        
        [SVProgressHUD showSuccessWithStatus:@"加载完成"];
        
    } failure:^(NSError * error) {
        
        BKLog(@"请求失败-------%@", error);
        
        [SVProgressHUD showErrorWithStatus:(NSString *)error];
         
     }];
    
}


/**
 *  将 grace模型数组 转成 graceFrame模型数据
 */
- (NSMutableArray *)graceFramesWithGraces:(NSArray *)graces
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

#pragma mark - 下拉刷新最新的数据、上拉加载更多的数据

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 没有数据或正在刷新数据，不响应

}


@end
