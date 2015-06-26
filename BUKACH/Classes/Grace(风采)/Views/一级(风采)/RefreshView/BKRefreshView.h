//
//  BKRefreshView.h
//  BUKACH
//
//  Created by Lynn on 15/6/25.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BKRefreshView : UIView

@property (nonatomic, strong) NSString * title;

@property (nonatomic, assign) BOOL refreshStatus;

+ (id)refreshView;

- (void)beginRefreshingWithTitle:(NSString *)title;

- (void)endRefreshingWithTitle:(NSString *)title;

@end
