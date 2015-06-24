//
//  BKGracePhotoModel.h
//  BUKACH
//
//  Created by Lynn on 15/6/24.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKGracePhotoModel : NSObject

@property (nonatomic, assign) CGFloat img_height;

@property (nonatomic, assign) CGFloat img_width;

@property (nonatomic, strong) NSString * img_location;

+(id)gracePhotoWithDict:(NSDictionary *)dict;
-(id)initWithDict:(NSDictionary *)dict;

@end
