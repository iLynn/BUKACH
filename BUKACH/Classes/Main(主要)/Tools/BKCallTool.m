//
//  BKCallTool.m
//  BUKACH
//
//  Created by Lynn on 15/6/14.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKCallTool.h"

@implementation BKCallTool

+ (void)callAtViewController:(UIViewController *)vc withTelNO:(NSString *)number
{
    
    UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, BKScreenWidth, BKScreenHeight)];
    
    NSURL * telUrl = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", number]];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:telUrl];
    
    [webView loadRequest:request];
    
#warning 怎样让此webView显示出来？退出出去？
    
    [vc.view addSubview:webView];
    
    
}

@end
