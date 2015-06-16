//
//  BKCategoryController.m
//  BUKACH
//
//  Created by Lynn on 15/6/16.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKCategoryController.h"
#import "BKCategoryModel.h"
#import "BKHttpTool.h"
#import "BKCourseResponse.h"
#import "BKCourseModel.h"
#import "UIImageView+WebCache.h"

@interface BKCategoryController ()

@property (nonatomic, strong) NSArray * courses;

@end

@implementation BKCategoryController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)setCategory:(BKCategoryModel *)category
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
        
        BKLog(@"%@", courseResponse);
        
        BKCourseResponse * response = [BKCourseResponse courseResponseWithDict:courseResponse];
        
        self.courses = response.data;
        
        [self.tableView reloadData];
        
    } failure:^(NSError * error) {
        
        BKLog(@"请求失败-------%@", error);
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.courses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"course"];
    
    BKCourseModel * model = self.courses[indexPath.row];
    
    BKLog(@"model:%@", model);
    
    cell.textLabel.text = model.course_name;
    
    cell.detailTextLabel.text = model.course_intro;
    cell.detailTextLabel.numberOfLines = 0;
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    CGSize size = [model.course_intro sizeWithAttributes:dict];
    
    cell.detailTextLabel.height = size.height;
//    
//    BKLog(@"%@", NSStringFromCGSize(size));
//    
//    NSString * urlStr = [NSString stringWithFormat:@"%@%@", BKUrlStr, model.course_photo];
//    BKLog(@"%@", urlStr);
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
  
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BKCourseModel * model = self.courses[indexPath.row];
    CGSize maxSize = CGSizeMake(BKScreenWidth, MAXFLOAT);
    CGRect maxRect = CGRectMake(0, 0, BKScreenWidth, MAXFLOAT);
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    NSStringDrawingContext * context = [[NSStringDrawingContext alloc] init];
    CGRect rect = [model.course_intro boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading attributes:dict context:context]; //sizeWithFont:[UIFont systemFontOfSize:11] constrainedToSize:maxSize];
    
    BKLog(@"%@", NSStringFromCGRect(rect));
    
    return rect.size.height + 50;
}

#pragma mark - table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 立即取消选中
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    // 先取出对应组的组模型
//    BKProfileGroup * group = self.datas[indexPath.section];
//    
//    // 从组模型中取出对应行的模型
//    BKProfileItem * item = group.items[indexPath.row];
//    
//    // 如果block中保存了代码，就执行block中保存的代码
//    if (item.option != nil)
//    {
//        item.option();
//    }
//    else if ([item isKindOfClass:[BKProfileArrowItem class]])
//    {
//        // 创建目标控制并且添加到栈中
//        BKProfileArrowItem * arrowItem = (BKProfileArrowItem *)item;
//        
//        UIViewController * vc = [[arrowItem.destVC alloc] init];
//        
//        // 设置导航标题
//        vc.navigationItem.title = item.tilte;
//        
//        [self.navigationController pushViewController:vc animated:YES];
//        
//    }
    
}



@end
