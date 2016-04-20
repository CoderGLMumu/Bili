//
//  BiLiTwoLevelAllPlayingItem.h
//  BiLiBil 二级展示界面
//
//  Created by sunny on 16/4/16.
//  Copyright © 2016年 sunny. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BiLiTwoLevelOwnerItem, BiLiTwoLevelCoverItem;
@interface BiLiTwoLevelAllPlayingItem : NSObject

/** 内容 */
@property (nonatomic,strong)NSString *title;

/** 数量 */
@property (nonatomic,assign)NSInteger online;

@property (nonatomic,strong)BiLiTwoLevelOwnerItem *owner;

@property (nonatomic,strong)BiLiTwoLevelCoverItem *cover;
@end
