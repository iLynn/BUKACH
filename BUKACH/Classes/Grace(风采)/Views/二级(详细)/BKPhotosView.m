//
//  BKPhotosView.m
//  BUKACH
//
//  Created by Lynn on 15/6/24.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKPhotosView.h"
#import "BKPhotoView.h"

@interface BKPhotosView()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView * scrollView;
@property (nonatomic, weak) UIPageControl * pageControl;

@property (nonatomic, weak) BKPhotoView * currentView;
@property (nonatomic, weak) BKPhotoView * nextView;
@property (nonatomic, weak) BKPhotoView * preView;

@property (nonatomic, assign) NSInteger index;

@end

@implementation BKPhotosView

+(id)photosView
{
    return [[self alloc] initWithFrame:CGRectZero];
}

//只要是alloc方式创建的View,这个一定会被调用
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews
{
    //1.引入scrollview
    UIScrollView * scrollView = [[UIScrollView alloc] init];
    [self addSubview:scrollView];
    
    self.scrollView = scrollView;
    
    self.scrollView.delegate = self;
    
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    
    //2. 加入page control
    UIPageControl * pageControl = [[UIPageControl alloc]init];
    [self addSubview:pageControl];
    
    //设置初始值
    pageControl.currentPage = 0;
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    
    
    self.pageControl = pageControl;

    
}

-(void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    //BKLog(@"%@", photos);
    
    //此处设置numberOfPages才有效
    self.pageControl.numberOfPages = self.photos.count;
    
    //加载图片，布局
    [self loadImages];
    
}

#pragma mark - 布局方法

- (void)loadImages
{
    //1.给page control设置frame
    CGFloat pageW = 200;
    CGFloat pageH = 40;
    CGFloat pageX = (BKCurrentWidth - pageW)/2;
    CGFloat pageY = BKCurrentHeight - pageH;
    self.pageControl.frame = CGRectMake(pageX, pageY, pageW, pageH);
    
    //2.给scroll view设置frame
    self.scrollView.frame = self.bounds;
    //只需要3个image的size
    self.scrollView.contentSize = CGSizeMake(BKCurrentWidth * 3, 0);
    
    //3.无限轮播设定
    //3.1.当前图片的初始化处理
    BKPhotoView * currentView =[[BKPhotoView alloc] init];
    currentView.photo_url = self.photos[0];
    
    [self.scrollView addSubview:currentView];
    self.currentView = currentView;
    
    self.currentView.frame = CGRectMake(BKCurrentWidth, 0, BKCurrentWidth, BKCurrentHeight);
    self.currentView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    //3.2.初始化下一个视图
    BKPhotoView * nextView = [[BKPhotoView alloc] init];
    
    [self.scrollView addSubview:nextView];
    self.nextView = nextView;
    
    self.nextView.frame = CGRectMake(BKCurrentWidth * 2, 0, BKCurrentWidth, BKCurrentHeight);
    self.nextView.contentMode = UIViewContentModeScaleAspectFit;
    
    //3.3.初始化上一个视图
    BKPhotoView * preView = [[BKPhotoView alloc] init];
    
    [self.scrollView addSubview:preView];
    self.preView = preView;
    
    preView.frame = CGRectMake(0, 0, BKCurrentWidth, BKCurrentHeight);
    self.preView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    //4.默认先滚动一下
    self.scrollView.contentOffset = CGPointMake(BKCurrentWidth, 0);
    [self scrollViewDidScroll:self.scrollView];
    
}

#pragma mark scrollview的代理方法

//contentOffset变化时自动调用，根据偏移量可以计算出当前是第几页
//此方法主要用于用户手工拖动页面时
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //1.只有3个image的宽度，offset要细细计算，不能直接与page绑定了
    CGFloat offset = self.scrollView.contentOffset.x;
    
    //if (self.nextView.image == nil || self.preView.image == nil)
    if (self.nextView.photo_url== nil || self.preView.photo_url == nil)
    {
        // 加载下一个视图
        NSInteger nextIndex = (self.index == self.photos.count - 1) ? 0 : self.index + 1;
        _nextView.photo_url = self.photos[nextIndex];
        
        // 加载上一个视图
        NSInteger preIndex = (self.index == 0) ? self.photos.count - 1 : self.index - 1;
        _preView.photo_url = self.photos[preIndex];
        
    }
    
    if(offset == 0)
    {
        _currentView.photo_url = _preView.photo_url;
        
        scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);
        
        _preView.photo_url = nil;
        
        if (self.index == 0)
        {
            self.index = self.photos.count - 1;
        }
        else
        {
            self.index -= 1;
        }
    }
    if (offset == scrollView.bounds.size.width * 2)
    {
        _currentView.photo_url = _nextView.photo_url;
        
        scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);
        
        _nextView.photo_url = nil;
        
        if (self.index == self.photos.count - 1)
        {
            self.index = 0 ;
        }
        else
        {
            self.index += 1 ;
        }
    }
    
    //2.设置pageControl的显示
    self.pageControl.currentPage = self.index;
    
}


@end
