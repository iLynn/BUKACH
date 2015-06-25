//
//  BKAboutModel.h
//  BUKACH
//
//  Created by Lynn on 15/6/25.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKAboutModel : NSObject

@property (nonatomic, strong) NSString * about_us_detail;

/** 快速创建 */
+(id)aboutWithDict:(NSDictionary *)dict;
-(id)initWithDict:(NSDictionary *)dict;

@end
