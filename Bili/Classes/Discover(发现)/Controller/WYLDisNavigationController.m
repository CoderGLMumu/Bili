//
//  WYLDisNavigationController.m
//  Bili
//
//  Created by 王亚龙 on 16/4/3.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "WYLDisNavigationController.h"
#import "WYLDiscoverViewController.h"

@implementation WYLDisNavigationController



-(instancetype)init
{
    //从stroyboard中加载控制器
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"WYLDiscoverViewController" bundle:nil];
    WYLDiscoverViewController *discoverVc = [storyboard instantiateInitialViewController];
    
    //设置导航控制器的跟控制器
    WYLDisNavigationController *disNav = [[WYLDisNavigationController alloc] initWithRootViewController:discoverVc];
    
    return disNav;
}


-(void)viewDidLoad
{
    //隐藏导航条
    self.navigationBar.hidden = YES;
}

@end
