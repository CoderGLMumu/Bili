//
//  BiLiAllViewController.m
//  BiLiBil 二级展示界面
//
//  Created by sunny on 16/4/8.
//  Copyright © 2016年 sunny. All rights reserved.
//

#import "BiLiAllViewController.h"

#import "BaseCollectionViewCell.h"
static NSString * const reuseIdentifier = @"Cell";
@interface BiLiAllViewController ()

@end

@implementation BiLiAllViewController

#pragma mark <UICollectionViewDataSource>

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Register cell classes
//    [self.collectionView registerNib:[UINib nibWithNibName:@"BaseCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BaseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor greenColor];
    
    return cell;
}
@end
