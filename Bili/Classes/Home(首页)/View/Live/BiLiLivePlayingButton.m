//
//  BiLiLivePlayingButton.m
//  BiLiBil 二级展示界面
//
//  Created by sunny on 16/4/10.
//  Copyright © 2016年 sunny. All rights reserved.
//

#import "BiLiLivePlayingButton.h"

@implementation BiLiLivePlayingButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    return self;
}

//取消高亮状态
- (void)setHighlighted:(BOOL)highlighted {}
@end
