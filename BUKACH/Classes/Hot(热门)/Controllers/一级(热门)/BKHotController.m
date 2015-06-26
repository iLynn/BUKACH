//
//  BKHotController.m
//  BUKACH
//
//  Created by Lynn on 15/6/13.
//  Copyright (c) 2015年 Lynn. All rights reserved.
//

#import "BKHotController.h"
#import "BKHttpTool.h"
#import "BKHotResponse.h"
#import "BKHotCell.h"
#import "BKHotTypeModel.h"
#import "BKOneHotModel.h"
#import "BKSectionHeaderView.h"
#import "BKHotDetailController.h"

@interface BKHotController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) UICollectionView * contentView;

@property (nonatomic, strong) NSArray * hotArray;

@end

@implementation BKHotController

//懒加载
- (NSArray *)hotArray
{
    if (_hotArray == nil)
    {
        _hotArray = [NSArray array];
    }
    return _hotArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //有这两行代码，navVC下的view才不会跑偏
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;

    
    //1.添加collectionView
    //1.1.定义collectionView的布局
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.sectionInset = UIEdgeInsetsMake(0, BKCustomMargin, BKCustomMargin, BKCustomMargin);
    
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    //1.2.创建collectionView
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, BKScreenWidth, BKScreenHeight - 20 - 44 - 49) collectionViewLayout:flowLayout];
    
    self.view = collectionView;
    
    //1.3.collectionView的基础设置
    collectionView.backgroundColor = [UIColor colorWithWhite:0.910 alpha:1.000];
    
    //1.4.collectionView的代理们
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    //1.5.保存到全局
    self.contentView = collectionView;
    
    
    //2.获得热门信息
    [self getHotInfo];

    
}

- (void)getHotInfo
{
    //1.封装请求参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    //2.发送请求
    NSString * urlStr = [NSString stringWithFormat:@"%@get_hot_summary", BKUrlStr];
    
    [BKHttpTool post:urlStr params:params success:^(NSDictionary * hotResponse) {

        // 字典转模型
        BKHotResponse * response = [BKHotResponse hotResponseWithDict:hotResponse];
        
        self.hotArray = response.data;
        
        //加载数据
        [self.contentView reloadData];

        
    } failure:^(NSError * error)
     {
         BKLog(@"请求失败-------%@", error);
         
     }];
}

#pragma mark - 数据源代理方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.hotArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    BKHotTypeModel * type = self.hotArray[section];
    
    //moreFlag是YES
    if (type.moreFlag)
    {
        return type.type_content.count;
    }
    else
    {
        return 2;
    }

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * ID = @"hot";
    
    //注册cell：几个section都用一样的cell，也是一样的高度
    [self.contentView registerClass:[BKHotCell class] forCellWithReuseIdentifier:ID];
    
    BKHotCell * cell = [BKHotCell cellWithCollectionView:collectionView atIndexPath:indexPath andIdentifier:ID];
    
    BKHotTypeModel * type = self.hotArray[indexPath.section];
    BKOneHotModel * hot = type.type_content[indexPath.row];
    
    cell.hot = hot;
    
    return cell;
    
}

#pragma mark - 设置cell的大小以及边距

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(BKHalfWidth, BKHalfWidth * 0.8);
}

#pragma mark - 设置section的header的大小

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(BKScreenWidth, 50);
}

#pragma mark - 设置section的header

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    static NSString * ID = @"header";
    
    //注册header
    [collectionView registerClass:[BKSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ID];
    
    BKSectionHeaderView * header = [BKSectionHeaderView viewWithCollectionView:collectionView atIndexPath:indexPath andIdentifier:ID andSupplementaryKind:UICollectionElementKindSectionHeader];
    
    BKHotTypeModel * type = self.hotArray[indexPath.section];
    
    //当前是展开状态的
    if (type.moreFlag)
    {
        header.statusStr = @"收起";
        header.imageName = @"hide";
    }
    else
    {
        header.statusStr = @"展开";
        header.imageName = @"more";
    }
    
    header.type = type;
    
    //加个手势
    UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderTouch:)];
    [gesture setNumberOfTapsRequired:1];
    [header addGestureRecognizer:gesture];
    
    return header;
    
}

#pragma mark - header的点击响应

- (void)sectionHeaderTouch:(UITapGestureRecognizer *)gesture
{
    BKSectionHeaderView * header = (BKSectionHeaderView *)gesture.view;
    
    if ([header.statusStr isEqualToString:@"展开"])
    {
        for (BKHotTypeModel * hot in self.hotArray)
        {
            if (hot.hot_type_id == header.type.hot_type_id)
            {
                hot.moreFlag = YES;
            }
        }

    }
    else if ([header.statusStr isEqualToString:@"收起"])
    {
        for (BKHotTypeModel * hot in self.hotArray)
        {
            if (hot.hot_type_id == header.type.hot_type_id)
            {
                hot.moreFlag = NO;
            }
        }
    }
    
    //重新加载一次数据
    [self.contentView reloadData];
    
}

#pragma mark - UICollectionViewDelegate的代理方法

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BKHotTypeModel * type = self.hotArray[indexPath.section];
    BKOneHotModel * hot = type.type_content[indexPath.row];
    
    BKHotDetailController * vc = [[BKHotDetailController alloc] init];
    
    vc.hot = hot;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end





