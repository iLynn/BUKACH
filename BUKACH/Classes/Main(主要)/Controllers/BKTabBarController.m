//
//  BKTabBarController.m
//  BUKACH
//
//  Created by Lynn on 15/6/13.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKTabBarController.h"
#import "BKHomeController.h"
#import "BKGraceController.h"
#import "BKHotController.h"
#import "BKProfileController.h"
#import "BKNavigationController.h"

@interface BKTabBarController ()

@property (nonatomic, weak) BKHomeController * home;

@property (nonatomic, weak) BKGraceController * grace;

@property (nonatomic, weak) BKHotController * hot;

@property (nonatomic, weak) BKProfileController * profile;

@end

@implementation BKTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //1.添加子控制器
    [self addAllChildVCs];
    
    //2.渲染颜色为红色
    self.tabBar.tintColor = [UIColor redColor];
    
}

/**
 *  添加子控制器
 */
-(void)addAllChildVCs
{
    BKHomeController * home = [[BKHomeController alloc]init];
    [self addOneChildViewController:home withTitle:@"首页" andImageName:@"home" andSelectedImageName:@"home_hl"];
    self.home = home;
    
    BKGraceController * grace = [[BKGraceController alloc]init];
    [self addOneChildViewController:grace withTitle:@"风采" andImageName:@"grace" andSelectedImageName:@"grace_hl"];
    self.grace = grace;
    
    BKHotController * hot = [[BKHotController alloc]init];
    [self addOneChildViewController:hot withTitle:@"热门" andImageName:@"hot" andSelectedImageName:@"hot_hl"];
    self.hot = hot;
    
    BKProfileController * profile = [[BKProfileController alloc]init];
    [self addOneChildViewController:profile withTitle:@"我" andImageName:@"profile" andSelectedImageName:@"profile_hl"];
    self.profile = profile;
    
}

/**
 *  添加单个子控制器的方法
 *
 *  @param childVC           子控制器名
 *  @param title             tabbar标题
 *  @param imageName         tabbar默认图片
 *  @param selectedImageName tabbar选中图片
 */
-(void)addOneChildViewController:(UIViewController *)childVC withTitle:(NSString *)title andImageName:(NSString *)imageName andSelectedImageName:(NSString *)selectedImageName
{
    //1.控制器的基础设置
    childVC.tabBarItem.title = title;
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //2.创建一个个navigationBarController
    childVC.navigationItem.title = title;
    BKNavigationController * navC = [[BKNavigationController alloc]initWithRootViewController:childVC];
    
    //3.添加到tabbar控制器
    [self addChildViewController:navC];
    
}

@end
