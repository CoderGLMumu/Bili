//
//  BiLiRecent LivePlayingViewController.m
//  BiLiBil 二级展示界面
//
//  Created by sunny on 16/4/10.
//  Copyright © 2016年 sunny. All rights reserved.
//

#import "BiLiRecentLivePlayingViewController.h"
#import "BiLiTwoLevelAllPlayingItem.h"
#import "BaseCollectionViewCell.h"
static NSString *reuseIdentifier = @"Cell";

@interface BiLiRecentLivePlayingViewController ()
/** 模型数组 */
@property (nonatomic,strong)NSArray *itemArray;
@end

@implementation BiLiRecentLivePlayingViewController

- (NSArray *)itemArray
{
    if (_itemArray == nil) {
        _itemArray = [NSArray array];
    }
    return _itemArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    
    //    注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"BaseCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    //    请求数据
    [self loadData];
}

#pragma mark - 请求数据
- (void)loadData
{
    //    获取会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //    发送请求
    [manager GET:@"http://live.bilibili.com/mobile/rooms?_device=android&_hwid=16492aebc0d9175b&appkey=c1b107428d337928&area_id=0&build=415000&page=1&platform=android&sort=latest&sign=9c40c9c46689b8b18f3fc326a506b57e" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        BiLiAFNWriteToFileName(/Users/sunny/Desktop/recentData.plist)
        self.itemArray = [BiLiTwoLevelAllPlayingItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        //        刷新数据
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.itemArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BaseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    BiLiTwoLevelAllPlayingItem *item = self.itemArray[indexPath.row];
    cell.allPlayingItem = item;
    
    return cell;
}

@end
