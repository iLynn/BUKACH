//
//  BKTeachersView.m
//  BUKACH
//
//  Created by Lynn on 15/6/18.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKTeachersView.h"
#import "BKTeacherModel.h"
#import "BKTeacherView.h"


@implementation BKTeachersView

+ (id)teachersView
{
    return [[self alloc] initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame
{
    return [super initWithFrame:frame];
}

- (void)setTeachers:(NSArray *)teachers
{
    _teachers = teachers;
    
    [self createSubviews];
    
}

- (void)createSubviews
{
    NSInteger count = self.teachers.count;
    
    CGFloat baseH = BKCurrentHeight - 2 * BKMargin;
    CGFloat baseW = baseH;
    CGFloat baseY = BKMargin;
    
    self.contentSize = CGSizeMake((baseW + BKMargin) * count + BKMargin, BKCurrentHeight);
    
    for (int i = 0; i < count; i++)
    {
        CGFloat viewX = ( BKMargin + baseW ) * i + BKMargin;
        
        BKTeacherView * view = [[BKTeacherView alloc] initWithFrame:CGRectMake(viewX, baseY, baseW, baseH)];
        
        view.backgroundColor = [UIColor redColor];
        
        [view addTarget:self action:@selector(teacherBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:view];

    }
    
}


- (void)teacherBtnTouch:(BKTeacherView *)view
{
    BKLog(@"touch");
    
    //通知代理响应操作
    if ([self.BKDelegate respondsToSelector:@selector(jumpToTeacherWithModel:)])
    {
        [self.BKDelegate jumpToTeacherWithModel:view.teacher];
    }
    
}

@end
