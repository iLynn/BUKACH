//
//  BKTeachersView.h
//  BUKACH
//
//  Created by Lynn on 15/6/18.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BKTeacherModel;

@protocol BKTeachersViewDelegate <NSObject>

- (void)jumpToTeacherWithModel:(BKTeacherModel *)teacher;

@end

@interface BKTeachersView : UIScrollView

@property (nonatomic, strong) NSArray * teachers;

@property (nonatomic, strong) id <BKTeachersViewDelegate> BKDelegate;

+ (id)teachersView;

@end
