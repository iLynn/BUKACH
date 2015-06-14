//
//  BKCallTool.h
//  BUKACH
//
//  Created by Lynn on 15/6/14.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKCallTool : NSObject

/** 打电话给谁 */
+ (void)callAtViewController:(UIViewController *)vc withTelNO:(NSString *)number;

@end
