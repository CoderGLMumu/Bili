

//
//  LBEntranceButton.m
//  Bili
//
//  Created by 林彬 on 16/4/14.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "LBEntranceButton.h"
#import "LBEntranceButtonItem.h"
#import <MJExtension.h>
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>

@interface LBEntranceButton()



@end

@implementation LBEntranceButton

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.centerX = self.width * 0.5;
    self.imageView.y = 0;
    
    // 根据文字内容计算下label,设置好label尺寸
    [self.titleLabel sizeToFit];
    self.titleLabel.centerX = self.width * 0.5;
    self.titleLabel.y = self.height - self.titleLabel.height;
    
}

- (void)setButtonItem:(LBEntranceButtonItem *)buttonItem
{
    _buttonItem = buttonItem;
    
}




@end
