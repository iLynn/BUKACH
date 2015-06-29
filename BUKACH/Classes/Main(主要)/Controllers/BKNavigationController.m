//
//  BKNavigationController.m
//  BUKACH
//
//  Created by Lynn on 15/6/13.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKNavigationController.h"
#import "BKCallTool.h"

@interface BKNavigationController ()<UIAlertViewDelegate>

@end

@implementation BKNavigationController

/**
 *  当第一次调用这个类的时候，此函数运行一次。将appearence放在这里设置，优化了内存。
 */
+ (void)initialize
{
    //设置UINavigationBar的主题
    [self setNavigationBarTheme];
    
    //设置UIBarButtonItem的主题
    [self setUIBarButtonTheme];
    
}

/**
 *  设置UINavigationBar的主题
 */
+ (void)setNavigationBarTheme
{
    UINavigationBar * barApperence = [UINavigationBar appearance];
    
    //设置导航背景
    [barApperence setBackgroundImage:[UIImage imageNamed:@"NavBarBg"] forBarMetrics:UIBarMetricsDefault];
    barApperence.tintColor = [UIColor whiteColor];
    
    //设置文字属性
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    dict[NSFontAttributeName] = BKNavigationFont;
    
    [barApperence setTitleTextAttributes:dict];
}

/**
 *  设置UIBarButtonItem的主题
 */
+ (void)setUIBarButtonTheme
{
    //appearence一次设置，全局可用！
    
    //通过appearence对象设置整个项目中所有UIBarButtonItem的样式
    UIBarButtonItem * itemAppearence = [UIBarButtonItem appearance];
    
    //设置普通状态下的文字属性
    NSMutableDictionary * normalDict = [NSMutableDictionary dictionary];
    normalDict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    normalDict[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    [itemAppearence setTitleTextAttributes:normalDict forState:UIControlStateNormal];
    
    //设置选中状态下的文字属性
    NSMutableDictionary * highlightedDict = [NSMutableDictionary dictionary];
    highlightedDict[NSForegroundColorAttributeName] = [UIColor redColor];
    highlightedDict[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    [itemAppearence setTitleTextAttributes:highlightedDict forState:UIControlStateHighlighted];
    
    //设置不可用状态下的文字属性
    NSMutableDictionary * disableDict = [NSMutableDictionary dictionary];
    disableDict[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    disableDict[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    [itemAppearence setTitleTextAttributes:disableDict forState:UIControlStateDisabled];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

#pragma mark 控制状态栏的样式

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

/**
 *  拦截所有push进来的子控制器
 *
 *  @param viewController 新的控制器
 *  @param animated       动画
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //不是navi的根（根是栈底的那个控制器），就隐藏底部tabbar导航
    if (self.viewControllers.count > 0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
        
        //全部是白色，根控制器在自己写，不然app一运行就全部加载了
        viewController.view.backgroundColor = [UIColor colorWithRed:1.000 green:0.963 blue:0.976 alpha:1];
    }
    
    //每一个vc的右边都是快捷联系
    //不想使用这个按钮，可在自己vc的viewDidLoad里重新设置
    //顺序是：先push，再viewDidLoad，才能有效
    //viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem buttonItemWithImageName:@"phone" andSelectedImageName:@"phone_hl" andTarget:self andAction:@selector(contactBUKACH)];
    
    
    [super pushViewController:viewController animated:animated];
}

- (void)contactBUKACH
{
    BKLog(@"contact");
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"拨打客服电话" message:@"拨打客服电话，立刻咨询课程详情。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alert show];
    
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        BKLog(@"取消");
    }
    else if (buttonIndex == 1)
    {
        BKLog(@"拨号");
        
        [BKCallTool callAtViewController:self withTelNO:@"10010"];
        
    }
}

@end
