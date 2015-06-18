//
//  BKTeacherController.m
//  BUKACH
//
//  Created by Lynn on 15/6/18.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKTeacherController.h"
#import "BKTeacherModel.h"
#import "BKHttpTool.h"

@interface BKTeacherController ()

@end

@implementation BKTeacherController

- (void)viewDidLoad
{
    [super viewDidLoad];
   

    
}

- (void)setTeacher:(BKTeacherModel *)teacher
{
    _teacher = teacher;
    
    self.navigationItem.title = teacher.teacher_name;
    
    NSString * str = teacher.teacher_id;
    
    [self getTeacherWithID:str];
    
}


- (void)getTeacherWithID:(NSString *)ID
{
    //1.封装请求参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"teacher_id"] = ID;
    
    //2.发送请求
    NSString * urlStr = [NSString stringWithFormat:@"%@get_teacher_info", BKUrlStr];
    
    [BKHttpTool post:urlStr params:params success:^(NSDictionary * teacherResponse) {
        
        BKLog(@"%@", teacherResponse);
        
//        BKOneCourseResponse * response = [BKOneCourseResponse oneCourseResponseWithDict:courseResponse];
//        
//        self.courseArray = response.data;
//        
//        BKLog(@"%@", self.courseArray);
        
    } failure:^(NSError * error) {
        
        BKLog(@"请求失败-------%@", error);
        
    }];
    
}


@end
