//
//  BKProfileController.m
//  BUKACH
//
//  Created by Lynn on 15/6/13.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKProfileController.h"
#import "BKProfileGroup.h"
#import "BKProfileItem.h"
#import "BKProfileArrowItem.h"
#import "BKProfileTextItem.h"
#import "BKProfileCell.h"
#import "BKProfileAboutController.h"
#import "BKProfileSuggestionController.h"
#import "BKProfileJoinController.h"

@interface BKProfileController ()

/** 记录cell的文字和图标 */
@property (nonatomic, strong) NSMutableArray * datas;

@end

@implementation BKProfileController

#pragma mark - 懒加载

- (NSMutableArray *)datas
{
    if (_datas == nil)
    {
        // 获得当前打开软件的版本号
        NSString * versionKey = (__bridge NSString *)kCFBundleVersionKey;
        NSString * currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
        
        // 第一组数据
        BKProfileItem * item00 = [[BKProfileTextItem alloc] initWithIcon:@"current_version" andTitle:@"当前版本" andText:currentVersion];
        BKProfileItem * item01 = [[BKProfileArrowItem alloc] initWithIcon:@"write_suggestion" andTitle:@"用户反馈" andDestClass:[BKProfileSuggestionController class]];
        BKProfileItem * item02 = [[BKProfileItem alloc] initWithIcon:@"clear" andTitle:@"清理缓存"];
        item02.option = ^{
            BKLog(@"清理缓存了！");
        };
        
        BKProfileGroup * group0 = [[BKProfileGroup alloc] init];
        group0.items = @[item00, item01, item02];
        
        // 第二组数据
        BKProfileItem * item10 = [[BKProfileArrowItem alloc] initWithIcon:@"about_us" andTitle:@"关于我们" andDestClass:[BKProfileAboutController class]];
        BKProfileItem * item11 = [[BKProfileArrowItem alloc] initWithIcon:@"join_us" andTitle:@"加入我们" andDestClass:[BKProfileJoinController class]];
        
        BKProfileGroup * group1 = [[BKProfileGroup alloc] init];
        group1.items = @[item10, item11];
        
        _datas = [NSMutableArray array];
        
        [_datas addObject:group0];
        [_datas addObject:group1];
        
    }
    return _datas;
}

- (id)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.view.backgroundColor = [UIColor colorWithRed:1.000 green:0.799 blue:0.966 alpha:1.000];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 取出对应的group模型
    BKProfileGroup * group = self.datas[section];
    
    return group.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    BKProfileCell * cell = [BKProfileCell cellWithTableView:tableView];
    
    // 先取出对应组的组模型
    BKProfileGroup * group = self.datas[indexPath.section];
    
    // 从组模型中取出对应行的模型
    BKProfileItem * item = group.items[indexPath.row];
    
    // 填充cell
    cell.item = item;
 
    return cell;
    
}

#pragma mark - table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 立即取消选中
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

    // 先取出对应组的组模型
    BKProfileGroup * group = self.datas[indexPath.section];
    
    // 从组模型中取出对应行的模型
    BKProfileItem * item = group.items[indexPath.row];
    
    // 如果block中保存了代码，就执行block中保存的代码
    if (item.option != nil)
    {
        item.option();
    }
    else if ([item isKindOfClass:[BKProfileArrowItem class]])
    {
        // 创建目标控制并且添加到栈中
        BKProfileArrowItem * arrowItem = (BKProfileArrowItem *)item;
        
        UIViewController * vc = [[arrowItem.destVC alloc] init];
        
        // 设置导航标题
        vc.navigationItem.title = item.tilte;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}


@end
