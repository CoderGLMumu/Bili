//
//  WYLHeaderView.m
//  Bili
//
//  Created by 王亚龙 on 16/4/7.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "WYLHeaderView.h"

@interface WYLHeaderView()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeight;
@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation WYLHeaderView

+(WYLHeaderView *)headerView
{
    return [[NSBundle mainBundle] loadNibNamed:@"WYLHeaderView" owner:nil options:nil][0];
}


- (IBAction)moreBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.collectionViewHeight.constant = self.collectionViewHeight.constant == 182 ? 280 : 182;
    
    //headerView的高度
    self.height = self.topView.height + self.bottomView.height + self.collectionViewHeight.constant;
    
}

@end
