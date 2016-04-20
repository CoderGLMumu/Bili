//
//  LBTabBarController.m
//  Bili
//
//  Created by 林彬 on 16/3/31.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "LBTabBarController.h"
#import "WYLDisNavigationController.h"
#import "LBHomeViewController.h"
#import "LBMineViewController.h"
#import "LBRegardViewController.h"

#import "GLMotiveSealViewController.h"


@interface LBTabBarController ()

@end

@implementation LBTabBarController

+ (void)load
{
    
    // 获取全局的tabbaritem
    UITabBarItem *item = [UITabBarItem appearance];
    
    // 设置字体颜色(在UIKIT框架中的NSAttributedString.h文件中找字典的key值)
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:attr forState:UIControlStateSelected];
    
    // 设置字体大小,只能通过nomal状态来设置.
    NSMutableDictionary *attrNomal = [NSMutableDictionary dictionary];
    attrNomal[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:attrNomal forState:UIControlStateNormal];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置自己的所有子控制器.
    [self setUpAllChildVC];
    
    // 设置自己身上的按钮
    [self setUpButtons];
    
}

#pragma mark -  设置子控制器
-(void)setUpAllChildVC
{
    // 首页  (林彬)
    LBHomeViewController *homeVC = [[LBHomeViewController alloc] init];
    UINavigationController *homeNAV = [[UINavigationController alloc] initWithRootViewController:homeVC];
    [self addChildViewController:homeNAV];
    
    
    
    
    #pragma mark -  高林
    // 关注  (高林修改)
    LBRegardViewController *regardVC = [[LBRegardViewController alloc] init];
    UINavigationController *regardNAV = [[UINavigationController alloc] initWithRootViewController:regardVC];
    [self addChildViewController:regardNAV];
    
    
    
    #pragma mark -  王亚龙
    // 发现 (要不要用UINavigationController?)  (王亚龙修改)
    WYLDisNavigationController *disNav = [[WYLDisNavigationController alloc] init];
    //UINavigationController *disNAV = [[UINavigationController alloc] initWithRootViewController:disVC];
    [self addChildViewController:disNav];
    
    
    
    #pragma mark -  王亚龙
    // 我的  (王亚龙修改)
    LBMineViewController *mineVC = [[LBMineViewController alloc] init];
    [self addChildViewController:mineVC];
}

#pragma mark -  设置按钮
- (void)setUpButtons
{
    // 设置"首页"按钮样式
    UINavigationController *nav1 = self.childViewControllers[0];
    nav1.tabBarItem.title = @"首页";
    nav1.tabBarItem.image = [UIImage imageOriRenderNamed:@"hd_home"];
    nav1.tabBarItem.selectedImage = [UIImage imageOriRenderNamed:@"hd_home_hover"];
    
    // 设置"关注"按钮样式
    UINavigationController *nav2 = self.childViewControllers[1];
    nav2.tabBarItem.title = @"关注";
    nav2.tabBarItem.image = [UIImage imageOriRenderNamed:@"hd_attention"];
    nav2.tabBarItem.selectedImage = [UIImage imageOriRenderNamed:@"hd_attention_hover"];
    
    // 设置"发现"按钮样式
    WYLDisNavigationController *disNav = self.childViewControllers[2];
    disNav.tabBarItem.title = @"发现";
    disNav.tabBarItem.image = [UIImage imageOriRenderNamed:@"hd_search"];
    disNav.tabBarItem.selectedImage = [UIImage imageOriRenderNamed:@"hd_search_hover"];
    
    // 设置"我的"按钮样式
    LBMineViewController *mineV = self.childViewControllers[3];
    mineV.tabBarItem.title = @"我的";
    mineV.tabBarItem.image = [UIImage imageOriRenderNamed:@"hd_mine"];
    mineV.tabBarItem.selectedImage = [UIImage imageOriRenderNamed:@"hd_mine_hover"];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
