//
//  BKCourseController.m
//  BUKACH
//
//  Created by Lynn on 15/6/17.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKCourseController.h"
#import "BKCourseModel.h"

@interface BKCourseController ()

@end

@implementation BKCourseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setCourse:(BKCourseModel *)course
{
    _course = course;
    
    self.navigationItem.title = course.course_name;
    
}



@end
