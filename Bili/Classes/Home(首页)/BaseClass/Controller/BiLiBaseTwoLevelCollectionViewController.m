//
//  BiLiBaseTwoLevelCollectionViewController.m
//  BiLiBil 二级展示界面
//
//  Created by sunny on 16/4/8.
//  Copyright © 2016年 sunny. All rights reserved.
//

#import "BiLiBaseTwoLevelCollectionViewController.h"
#import "BaseCollectionViewCell.h"
@interface BiLiBaseTwoLevelCollectionViewController ()

@end

@implementation BiLiBaseTwoLevelCollectionViewController


static NSString * const reuseIdentifier = @"Cell";

+ (instancetype)viewController
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(168, 150);
    layout.sectionInset = UIEdgeInsetsMake(10,12, 0, 12);
    BiLiBaseTwoLevelCollectionViewController *vc = [[self alloc] initWithCollectionViewLayout:layout];
    
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"BaseCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
}





@end
