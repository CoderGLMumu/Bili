//
//  WYLSearchCollectionView.m
//  Bili
//
//  Created by 王亚龙 on 16/4/7.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "WYLSearchCollectionView.h"
#import "WYLSearchCell.h"

static CGFloat margin = 1;//间距
static CGFloat cols = 4;//列数

static NSString * const ID = @"cell";

#define WYLScreenW [UIScreen mainScreen].bounds.size.width

#define itemW (WYLScreenW - (cols - 1) * margin) / cols
#define itemH 60

@interface WYLSearchCollectionView()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

/** 宽度数组*/
@property (nonatomic ,strong) NSMutableArray *withArray;

/** cell*/
@property (nonatomic ,weak) WYLSearchCell *cell;



@end

@implementation WYLSearchCollectionView

/** lanjiazai*/
-(NSMutableArray *)withArray
{
    if (_withArray == nil) {
        _withArray = [NSMutableArray array];
    }
    
    return _withArray;
}

-(void)awakeFromNib
{

    //1.创建流水布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    //设置布局参数
//    flowLayout.itemSize = CGSizeMake(itemW, itemH);
    flowLayout.minimumInteritemSpacing = margin;
    flowLayout.minimumLineSpacing = margin;
    
    //设置流水布局
    self.collectionViewLayout = flowLayout;
    
    //2.注册cell
    [self registerNib:[UINib nibWithNibName:@"WYLSearchCell" bundle:nil] forCellWithReuseIdentifier:ID];
    
    //3.设置数据源代理
    self.dataSource = self;
    self.delegate = self;
    
    self.withArray = _cell.buttonWithArray;
    
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WYLSearchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    _cell = cell;
    
    return cell;
}


#pragma mark - UICollectionViewDelegate
//点击item调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - UICollectionViewDelegateFlowLayout
/*
 遇到的问题:
    1.执行顺序,数组的值传不过来
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

//    NSLog(@"%@",self.subviews);
    
//    NSLog(@"%@, %@",collectionView, collectionViewLayout);
    return CGSizeMake(itemW, itemH);
}















@end
