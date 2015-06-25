//
//  BKProfileJoinController.m
//  BUKACH
//
//  Created by Lynn on 15/6/15.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKProfileJoinController.h"
#import "BKHttpTool.h"
#import "BKJobsResponse.h"
#import "BKJobCell.h"
#import "BKJobFrame.h"

@interface BKProfileJoinController ()

/** 存job的frame模型 */
@property (nonatomic, strong) NSArray * jobFrames;

@end

@implementation BKProfileJoinController

- (NSArray *)jobFrames
{
    if (_jobFrames == nil)
    {
        _jobFrames = [NSArray array];
    }
    
    return _jobFrames;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self getJobsInfo];
    
}

- (void)getJobsInfo
{
    //1.封装请求参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    //2.发送请求
    NSString * urlStr = [NSString stringWithFormat:@"%@get_job_info", BKUrlStr];
    
    [BKHttpTool post:urlStr params:params success:^(NSDictionary * jobsResponse) {

        BKJobsResponse * response = [BKJobsResponse jobsResponseWithDict:jobsResponse];
        
        // 获取jobFrame的数组
        self.jobFrames = [self jobFramesWithJobs:response.data];
        
        [self.tableView reloadData];
        
    } failure:^(NSError * error) {
        
        BKLog(@"请求失败-------%@", error);
        
    }];
}

/**
 *  将 job模型数组 转成 jobFrame模型数据
 */
- (NSArray *)jobFramesWithJobs:(NSArray *)jobs
{
    NSMutableArray * frames = [NSMutableArray array];
    for (BKOneJobModel * job in jobs)
    {
        BKJobFrame * frame = [[BKJobFrame alloc] init];
        
        // 传递job模型数据，计算所有子控件的frame
        frame.job = job;
        
        [frames addObject:frame];
    }
    return frames;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.jobFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BKJobCell * cell = [BKJobCell cellWithTableView:tableView];
    
    cell.cellFrame = self.jobFrames[indexPath.row];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BKJobFrame * frame = self.jobFrames[indexPath.row];
    
    return frame.cellHeight;
    
}

#pragma mark - table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 立即取消选中
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}



@end
