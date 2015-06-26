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

#import "BKRefreshView.h"

@interface BKGraceController ()<BKGraceWaterFlowViewDataSource, BKGraceWaterFlowViewDelegate>

/** 存放BKGraceFrame模型的数组 */
@property (nonatomic, strong) NSArray * graceFrames;

@property (nonatomic, weak) BKGraceWaterFlowView * waterFlowView;

@property (nonatomic, weak) BKRefreshView * header;

@property (nonatomic, weak) BKRefreshView * footer;

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
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.864 alpha:1.000];
    
    //有这两行代码，navVC下的view才不会跑偏
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //1.添加下拉、上拉刷新控件
    [self setupRefresh];
    
    //2.加载数据
    [self getGraceInfo];
    
}

/** 添加下拉、上拉刷新控件 */
- (void)setupRefresh
{
    // 1.添加下拉刷新控件
    BKRefreshView * header = [BKRefreshView refreshView];
    [self.view addSubview:header];
    
    self.header = header;
    
    
    // 2.添加上拉加载更多控件
    BKRefreshView * footer = [BKRefreshView refreshView];
    [self.view addSubview:footer];
    
    self.footer = footer;
    
//    
//    // 2.让刷新控件自动进入刷新状态
//    [refreshControl beginRefreshing];
//    
//    // 4.手动加载一次数据
//    [self refreshControlStateChange:refreshControl];
//    
//    // 5.给tableView添加一个footer
//    LYLoadMoreFooterView * footer = [LYLoadMoreFooterView footer];
//    self.tableView.tableFooterView = footer;
//    
//    LYLog(@"%@", NSStringFromCGRect(self.tableView.frame));
//    LYLog(@"%@", NSStringFromCGRect(self.tableView.tableFooterView.frame));
//    
//    self.footer = footer;
    
}

///** 当下拉刷新控件进入刷新状态的时候会自动调用此方法，加载数据 */
//- (void)refreshControlStateChange:(UIRefreshControl *)refreshControl
//{
//    [self loadNewStatuses:refreshControl];
//    
//}

//#pragma mark - 加载微博数据
//
///** 加载最新的微博数据 */
//- (void)loadNewStatuses:(UIRefreshControl *)refreshControl
//{
//    //1.封装请求参数
//    NSMutableDictionary * params = [NSMutableDictionary dictionary];
//    params[@"start"] = @"0";
//    params[@"end"] = @"4";
//    
//    //2.发送请求
//    NSString * urlStr = [NSString stringWithFormat:@"%@get_all_grace", BKUrlStr];
//    
//    [BKHttpTool post:urlStr params:params success:^(NSDictionary * graceResponse) {
//        
//        // 字典转模型
//        BKGraceResponse * response = [BKGraceResponse graceResponseWithDict:graceResponse];
//        
//        // 获取courseFrame的数组
//        self.graceFrames = [self graceFramesWithGraces:response.data];
//        
//        //添加风采视图
//        BKGraceWaterFlowView * waterFlowView = [[BKGraceWaterFlowView alloc] init];
//        
//        waterFlowView.frame = CGRectMake(0, 0, BKScreenWidth, BKScreenHeight - 20 - 44 - 49);
//        
//        waterFlowView.dataSource = self;
//        
//        waterFlowView.BKdelegate = self;
//        
//        self.waterFlowView = waterFlowView;
//        
//        [self.view addSubview:waterFlowView];
//        
//        // 填充UI
//        [self.waterFlowView reloadData];
//        
//    } failure:^(NSError * error)
//     {
//         BKLog(@"请求失败-------%@", error);
//         
//     }];
//    
//}
//


- (void)getGraceInfo
{
    //1.封装请求参数
#warning 返回>start, <=end的集合
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"start"] = @"0";
    params[@"end"] = @"4";
    
    //2.发送请求
    NSString * urlStr = [NSString stringWithFormat:@"%@get_all_grace", BKUrlStr];
    
    [BKHttpTool post:urlStr params:params success:^(NSDictionary * graceResponse) {

        // 字典转模型
        BKGraceResponse * response = [BKGraceResponse graceResponseWithDict:graceResponse];
        
        // 获取courseFrame的数组
        self.graceFrames = [self graceFramesWithGraces:response.data];
        
        // 添加风采视图
        BKGraceWaterFlowView * waterFlowView = [[BKGraceWaterFlowView alloc] init];
        
        waterFlowView.frame = CGRectMake(0, 0, BKScreenWidth, BKScreenHeight - 20 - 44 - 49);
        
        waterFlowView.dataSource = self;
        
        waterFlowView.BKdelegate = self;
        
        self.waterFlowView = waterFlowView;
        
        [self.view addSubview:waterFlowView];
        
        // 填充UI
        [self.waterFlowView reloadData];
        
    } failure:^(NSError * error) {
        
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

//#pragma mark - 下拉刷新最新的数据、上拉加载更多的数据
//
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    // 没有数据或正在刷新数据，不响应
//    if (self.statusFrames.count <= 0 || self.footer.refreshStatus) return;
//    
//    // 1.差距
//    CGFloat delta = scrollView.contentSize.height - scrollView.contentOffset.y;
//    
//    // 刚好能完整看到footer时的高度
//    CGFloat sawFooterH = self.view.height - self.tabBarController.tabBar.height;
//    
//    // 2.如果能看见整个footer
//    if (delta <= (sawFooterH - 0))
//    {
//        // 进入上拉刷新状态
//        [self.footer beginRefreshing];
//        
//        //开一个线程，加载更多数据
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            // 加载更多的微博数据
//            [self loadMoreStatuses];
//        });
//    }
//}

///** 加载更多的微博数据 */
//- (void)loadMoreStatuses
//{
//    //1.封装请求参数
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"access_token"] = [LYAccountTool account].access_token;
//    LYStatusFrame * lastFrame = [self.statusFrames lastObject];
//    LYStatus * lastStatus =  lastFrame.status;
//    if (lastStatus)
//    {
//        params[@"max_id"] = @([lastStatus.idstr longLongValue] - 1);
//    }
//    
//    //2.发送请求
//    [LYHttpTool get:@"https://api.weibo.com/2/statuses/home_timeline.json" params:params success:^(id responseObj) {
//        
//        // 微博字典数组
//        NSArray *statusDictArray = responseObj[@"statuses"];
//        // 微博字典数组 ---> 微博模型数组
//        NSArray *newStatuses = [LYStatus objectArrayWithKeyValuesArray:statusDictArray];
//        
//        // 获得最新的微博frame数组
//        NSArray * newFrames = [self statusFramesWithStatuses:newStatuses];
//        
//        // 将新数据插入到旧数据的最后面
//        [self.statusFrames addObjectsFromArray:newFrames];
//        
//        // 重新刷新表格
//        [self.tableView reloadData];
//        
//        // 让刷新控件停止刷新（恢复默认的状态）
//        [self.footer endRefreshing];
//        
//        // 提示用户最新的微博数量
//        [self showNewStatusesCount:newStatuses.count];
//        
//    } failure:^(NSError * error) {
//        
//        LYLog(@"请求失败--%@", error);
//        
//        // 让刷新控件停止刷新（恢复默认的状态）
//        [self.footer endRefreshing];
//        
//    }];
//    
//}
//


@end
