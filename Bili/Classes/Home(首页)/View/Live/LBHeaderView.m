//
//  LBHeaderView.m
//  Bili
//
//  Created by 林彬 on 16/4/14.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "LBHeaderView.h"
#import "LBEntranceButton.h"
#import "LBEntranceButtonItem.h"
#import "LBHeaderItem.h"
#import <MJExtension.h>
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>

@interface LBHeaderView()
// headerView中7个按钮的模型数组
@property (nonatomic , strong)NSMutableArray *entranceButtomItems;
@end

@implementation LBHeaderView

#pragma mark -  各个懒加载
-(NSMutableArray *)entranceButtomItems
{
    if (_entranceButtomItems == nil) {
        _entranceButtomItems = [NSMutableArray array];
    }
    return _entranceButtomItems;
}

-(void)awakeFromNib
{
    [self getNetData];
}

- (void)getNetData
{
    
}

- (void)getButtonData
{
    // 在plist文件里遇到和系统关键字重名的属性,将它重命名.
    [LBEntranceButtonItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID":@"id",
                 };
    }];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *dictM = @{
                            @"actionKey":@"appkey",
                            @"appkey":@"27eb53fc9058f8c3",
                            @"build":@"3060",
                            @"device":@"phone",
                            @"platform":@"ios",
                            @"scale":@"2",
                            @"sign":@"13f053baf875521b0d1958c812a0f110",
                            @"ts":@"1460106665"
                            };
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:@"http://live.bilibili.com/AppIndex/home" parameters:dictM progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
        [responseObject writeToFile:@"/Users/linbin/Desktop/xmg/bilibili/Plists/Lives/live.plist" atomically:YES];
        
        // 获得按钮字典数组
        NSArray *entranceIcons = responseObject[@"data"][@"entranceIcons"];
        [entranceIcons writeToFile:@"/Users/linbin/Desktop/xmg/bilibili/Plists/Lives/entranceIcons.plist" atomically:YES];
        
        _entranceButtomItems = [LBEntranceButtonItem mj_objectArrayWithKeyValuesArray:entranceIcons];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

@end
