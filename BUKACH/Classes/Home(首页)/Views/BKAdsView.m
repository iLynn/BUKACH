//
//  BKAdsView.m
//  BUKACH
//
//  Created by Lynn on 15/6/15.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKAdsView.h"
#import "BKAdView.h"
//#import "UIImageView+WebCache.h"
#import "BKAdsModel.h"

#define BKCurrentWidth self.bounds.size.width
#define BKCurrentHeight self.bounds.size.height

@interface BKAdsView()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView * scrollView;
@property (nonatomic, weak) UIPageControl * pageControl;
@property (nonatomic, strong) NSTimer * timer;

@property (nonatomic, weak) BKAdView * currentAdView;
@property (nonatomic, weak) BKAdView * nextAdView;
@property (nonatomic, weak) BKAdView * preAdView;

@property (nonatomic, assign) NSInteger index;

@end


@implementation BKAdsView

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
    pageControl.pageIndicatorTintColor = [UIColor redColor];
    
    self.pageControl = pageControl;
    
    
    //3.为自动轮播设置定时器
    [self startTimer];
    
}

-(void)setAds:(NSArray *)ads
{
    _ads = ads;
    
    //此处设置numberOfPages才有效
    self.pageControl.numberOfPages = self.ads.count;
    
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
    BKAdView * currentAdView =[[BKAdView alloc] init];
    currentAdView.ad = self.ads[0];
    
    [self.scrollView addSubview:currentAdView];
    self.currentAdView = currentAdView;
    
    self.currentAdView.frame = CGRectMake(BKCurrentWidth, 0, BKCurrentWidth, BKCurrentHeight);
    self.currentAdView.contentMode = UIViewContentModeScaleAspectFill;
    
    //添加响应事件
    [currentAdView addTarget:self action:@selector(adTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //3.2.初始化下一个视图
    BKAdView *nextAdView = [[BKAdView alloc] init];
    
    [self.scrollView addSubview:nextAdView];
    self.nextAdView = nextAdView;
    
    self.nextAdView.frame = CGRectMake(BKCurrentWidth * 2, 0, BKCurrentWidth, BKCurrentHeight);
    self.nextAdView.contentMode = UIViewContentModeScaleAspectFill;
    
    //3.3.初始化上一个视图
    BKAdView *preAdView = [[BKAdView alloc] init];
    
    [self.scrollView addSubview:preAdView];
    self.preAdView = preAdView;
    
    preAdView.frame = CGRectMake(0, 0, BKCurrentWidth, BKCurrentHeight);
    self.preAdView.contentMode = UIViewContentModeScaleAspectFill;
    
    
    //4.默认先滚动一下
    self.scrollView.contentOffset = CGPointMake(BKCurrentWidth, 0);
    [self scrollViewDidScroll:self.scrollView];

}


-(void)adTouch:(BKAdView *)adView
{
    //通知代理响应操作
    if ([self.delegate respondsToSelector:@selector(jumpToAdsWithModel:)])
    {
        [self.delegate jumpToAdsWithModel:adView.ad];
    }
}


#pragma mark - 定时器的方法

-(void)startTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

//此方法用于定时器自动滚动页面时
-(void)autoScroll
{
    NSInteger page = self.pageControl.currentPage;
    page = (page >= self.ads.count - 1) ? 0 : page + 1;

    //只有3个image的宽度，offset要细细计算，不能直接与page绑定了
    CGPoint offSet = self.scrollView.contentOffset;
    offSet.x += offSet.x;
    [self.scrollView setContentOffset:offSet animated:YES];
    
    //offset在最左边时，自动移动offset为在中间的效果
    if (offSet.x >= self.frame.size.width * 2)
    {
        offSet.x = self.frame.size.width;
    }
    
}

#pragma mark scrollview的代理方法

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //用户拖动时，暂停自动轮播
    [self.timer invalidate];
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //用户不拖时，重新再启动一个timer
    [self startTimer];
    
}

//contentOffset变化时自动调用，根据偏移量可以计算出当前是第几页
//此方法主要用于用户手工拖动页面时
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //1.只有3个image的宽度，offset要细细计算，不能直接与page绑定了
    CGFloat offset = self.scrollView.contentOffset.x;
    
    //if (self.nextAdView.image == nil || self.preAdView.image == nil)
    if (self.nextAdView.ad == nil || self.preAdView.ad == nil)
    {
        // 加载下一个视图
        NSInteger nextIndex = (self.index == self.ads.count - 1) ? 0 : self.index + 1;
        _nextAdView.ad = self.ads[nextIndex];
        
        // 加载上一个视图
        NSInteger preIndex = (self.index == 0) ? self.ads.count - 1 : self.index - 1;
        _preAdView.ad = self.ads[preIndex];
        
    }
    
    if(offset == 0)
    {
        _currentAdView.ad = _preAdView.ad;

        scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);

        _preAdView.ad = nil;
        
        if (self.index == 0)
        {
            self.index = self.ads.count - 1;
        }
        else
        {
            self.index -= 1;
        }
    }
    if (offset == scrollView.bounds.size.width * 2)
    {
        _currentAdView.ad = _nextAdView.ad;

        scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);

        _nextAdView.ad = nil;
        
        if (self.index == self.ads.count - 1)
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
