//
//  BKCategoryController.m
//  BUKACH
//
//  Created by Lynn on 15/6/16.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKCategoryController.h"
#import "BKOneCategoryModel.h"
#import "BKHttpTool.h"
#import "BKCourseResponse.h"

#import "BKCourseCell.h"
#import "BKCourseFrame.h"
#import "BKCourseController.h"
#import "BKOneCourseModel.h"


@interface BKCategoryController ()

/** 让courses里面存frame模型，而不是普通数据模型 */
@property (nonatomic, strong) NSArray * courseFrames;

@end

@implementation BKCategoryController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)setCategory:(BKOneCategoryModel *)category
{
    _category = category;
    
    self.navigationItem.title = category.category_name;
    
    NSString * str = category.category_id;
    
    [self getCourseInfoWithCategoryID:str];

}

- (void)getCourseInfoWithCategoryID:(NSString *)ID
{
    //1.封装请求参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"category_id"] = ID;
    
    //2.发送请求
    NSString * urlStr = [NSString stringWithFormat:@"%@get_course_info", BKUrlStr];
    
    [BKHttpTool post:urlStr params:params success:^(NSDictionary * courseResponse) {
        
        BKCourseResponse * response = [BKCourseResponse courseResponseWithDict:courseResponse];
        
        // 获取courseFrame的数组
        self.courseFrames = [self courseFramesWithCourses:response.data];
        
        [self.tableView reloadData];
        
    } failure:^(NSError * error) {
        
        BKLog(@"请求失败-------%@", error);
        
    }];
}

/**
 *  将 course模型数组 转成 courseFrame模型数据
 */
- (NSArray *)courseFramesWithCourses:(NSArray *)courses
{
    NSMutableArray * frames = [NSMutableArray array];
    for (BKOneCourseModel * course in courses)
    {
        BKCourseFrame * frame = [[BKCourseFrame alloc] init];
        
        // 传递course模型数据，计算所有子控件的frame
        frame.course = course;
        
        [frames addObject:frame];
    }
    return frames;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.courseFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BKCourseCell * cell = [BKCourseCell cellWithTableView:tableView];
    
    cell.cellFrame = self.courseFrames[indexPath.row];
  
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BKCourseFrame * frame = self.courseFrames[indexPath.row];
    
    return frame.cellHeight;

}

#pragma mark - table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 立即取消选中
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BKCourseFrame * frame = self.courseFrames[indexPath.row];

    // 跳转到新的控制器
    BKCourseController * vc = [[BKCourseController alloc] init];
    
    vc.course = frame.course;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}



@end
