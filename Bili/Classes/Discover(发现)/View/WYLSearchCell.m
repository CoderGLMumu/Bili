//
//  WYLSearchCell.m
//  Bili
//
//  Created by 王亚龙 on 16/4/8.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "WYLSearchCell.h"

@interface WYLSearchCell()

@property (weak, nonatomic) IBOutlet UIButton *button;


@end

@implementation WYLSearchCell
-(NSMutableArray *)buttonWithArray
{
    if (_buttonWithArray == nil) {
        _buttonWithArray = [NSMutableArray array];
    }
    return _buttonWithArray;
}

- (void)awakeFromNib {

    [self.button setTitle:@"item" forState:UIControlStateNormal];
    [self.button sizeToFit];
//    NSLog(@"%f",self.button.size.width);
    
    [self.buttonWithArray addObject:[NSNumber numberWithFloat:self.button.size.width]];
//    NSLog(@"%@",self.buttonWithArray[0]);

    
}

@end
