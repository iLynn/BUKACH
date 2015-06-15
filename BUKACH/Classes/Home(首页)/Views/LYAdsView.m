//
//  LYAdsView.m
//  重构-豆果美食
//
//  Created by qianfeng on 15-4-27.
//  Copyright (c) 2015年 李颖. All rights reserved.
//

#import "LYAdsView.h"
//#import "UIImageView+WebCache.h"

@interface LYAdsView()<UIScrollViewDelegate>
@property(nonatomic,weak)UIScrollView * scrollView;
@property(nonatomic,weak)UIPageControl * pageControl;
@property(nonatomic,strong)NSTimer * timer;
@end

@implementation LYAdsView

+(id)adsView
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
    //在构造方法中，一般去创建子控件对象
    UIScrollView * scrollView = [[UIScrollView alloc] init];
    [self addSubview:scrollView];
    //保存全局变量，设置一些常用属性
    self.scrollView = scrollView;
    //设置自己是子控件scrollView的代理
    self.scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    //加入page control
    UIPageControl * pageControl = [[UIPageControl alloc]init];
    [self addSubview:pageControl];
    //设置初始值
    pageControl.currentPage = 0;
    pageControl.pageIndicatorTintColor = [UIColor redColor];
    self.pageControl = pageControl;
    
    [self startTimer];
}

-(void)setAds:(NSArray *)ads
{
    _ads = ads;
    self.pageControl.numberOfPages = self.ads.count;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //给page control设置frame
    CGFloat pageW = 200;
    CGFloat pageH = 20;
    CGFloat pageX = (self.bounds.size.width - pageW)/2;
    CGFloat pageY = self.bounds.size.height - pageH;
    self.pageControl.frame = CGRectMake(pageX, pageY, pageW, pageH);
    
    //给scroll view设置frame
    self.scrollView.frame = self.bounds;
    self.scrollView.contentSize = CGSizeMake(self.bounds.size.width * _ads.count, 0);
    //添加UIImageView到scrollView中去
    for (int i = 0; i < _ads.count; i++)
    {
#warning ads中取出来的是字典：字典是=，模型重写description方法是:
        //先转一次模型
//        LYFindHomeSlide * ads = [LYFindHomeSlide slideWithDict:self.ads[i]];
//        
//        NSURL * url = [NSURL URLWithString:ads.host_pic];
        UIImageView * imageView = [[UIImageView alloc] init];
//        [imageView setImageWithURL:url];
        imageView.image = self.ads[i];
        [self.scrollView addSubview:imageView];
        
        CGFloat imageViewW = self.bounds.size.width;
        CGFloat imageViewH = self.bounds.size.height;
        CGFloat imageViewX = i * imageViewW;
        CGFloat imageViewY = 0;
        imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    }
}

//当self即将被添加到父亲视图的时候会被自动调用
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat h = 160;
    CGFloat w = newSuperview.frame.size.width;
    self.frame = CGRectMake(x, y, w, h);
}

//谁拥有pagecontrol，谁就负责它的实现
//timer里负责调用自动滚动
-(void)startTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)autoScroll
{
    NSInteger page = self.pageControl.currentPage;
    page = (page >= self.ads.count - 1)?0:page+1;
    
    CGFloat offSetX = page * self.scrollView.frame.size.width;
    self.scrollView.contentOffset = CGPointMake(offSetX, 0);
}

#pragma mark scrollview的代理方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //重新再启动一个timer
    [self startTimer];
}
//contentOffset变化时自动调用，根据偏移量可以计算出当前是第几页
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint contentOffSet = scrollView.contentOffset;
    
    //过半就算下一张啦！
    int page = (contentOffSet.x + scrollView.frame.size.width * 0.5) /scrollView.frame.size.width;
    self.pageControl.currentPage = page;
}

@end

