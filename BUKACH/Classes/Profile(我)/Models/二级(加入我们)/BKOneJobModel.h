//
//  BKOneJobModel.h
//  BUKACH
//
//  Created by Lynn on 15/6/25.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKOneJobModel : NSObject

@property (nonatomic, strong) NSString * job_quota;

@property (nonatomic, strong) NSString * job_type;

@property (nonatomic, strong) NSString * job_detail;

@property (nonatomic, strong) NSString * job_deadline;

@property (nonatomic, strong) NSString * job_name;

/** 快速创建 */
+(id)oneJobWithDict:(NSDictionary *)dict;
-(id)initWithDict:(NSDictionary *)dict;

@end
