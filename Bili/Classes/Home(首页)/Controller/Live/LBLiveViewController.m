//
//  LBLiveViewController.m
//  Bili
//
//  Created by 林彬 on 16/3/31.
//  Copyright © 2016年 gl. All rights reserved.
//

// 直播
#import "LBLiveViewController.h"
#import "LBEntranceButtonItem.h"

#import "BiLiLivePlayingViewController.h"//全部直播
@interface LBLiveViewController ()

@end

@implementation LBLiveViewController


#pragma mark -  界面加载
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getNetData];
    
    [self setUpHeaderView];
//    [self getBannerData];
    
    
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)setUpHeaderView
{
    
}



/*
 http://live.bilibili.com/AppIndex/home?actionKey=appkey&appkey=27eb53fc9058f8c3&build=3060&device=phone&platform=ios&scale=2&sign=13f053baf875521b0d1958c812a0f110&ts=1460106665
 */

#pragma mark -  获取网络数据
- (void)getNetData
{
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
        
    
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}






- (void)getBannerData
{
    /*
     http://app.bilibili.com/x/banner?build=3060&channel=appstore&plat=2
     */
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *dictM = @{
                            @"build":@"3060",
                            @"channel":@"appstore",
                            @"plat":@"2"
                            };
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:@"http://app.bilibili.com/x/banner" parameters:dictM progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
        [responseObject writeToFile:@"/Users/linbin/Desktop/xmg/bilibili/Plists/banner.plist" atomically:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
}

#warning 这是测试用的，请勿在这里写代码！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"test"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"test"];
    }
    return cell;
}
#warning 这是测试用的，请勿在这里写代码！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BiLiLivePlayingViewController *vc = [[BiLiLivePlayingViewController alloc]init];

    [self.navigationController pushViewController:vc animated:YES];
}

@end
