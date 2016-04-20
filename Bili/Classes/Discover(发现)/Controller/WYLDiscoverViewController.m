//
//  WYLDiscoverViewController.m
//  Bili
//
//  Created by 王亚龙 on 16/4/7.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "WYLDiscoverViewController.h"
#import "WYLHeaderView.h"
#import "WYLGlobalViewController.h"
#import "WYLSettingViewController.h"

@interface WYLDiscoverViewController ()

@property (nonatomic ,weak)WYLHeaderView *headerView;
@property (nonatomic ,assign) CGFloat height;

@end

@implementation WYLDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置头部间距和尾部间距
    self.tableView.sectionFooterHeight = 10;
    self.tableView.sectionHeaderHeight = 0;
    
    //设置headerView
    [self setUpHeaderView];
    
    //监听高度改变
    [self.headerView addObserver:self forKeyPath:@"height" options:NSKeyValueObservingOptionNew context:nil];
}

//监听的值发生改变时调用
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    self.height = self.headerView.height;
    self.headerView.frame = CGRectMake(0, 20, ScreenW, self.height);
    self.tableView.tableHeaderView = self.headerView;
}

//添加headerView
-(void)setUpHeaderView
{
    //从xib中加载headerView
    WYLHeaderView *headerView = [WYLHeaderView headerView];
    _headerView = headerView;
    
    self.tableView.tableHeaderView = headerView;
    [self.tableView reloadData];
    
}

-(void)dealloc
{
    //移除监听
    [self.headerView removeObserver:self forKeyPath:@"height"];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //跳转控制器
    if (indexPath.section == 1 && indexPath.row == 1) {
        
        //隐藏底部条
        self.hidesBottomBarWhenPushed = YES;
        
        WYLGlobalViewController *globalVc = [[WYLGlobalViewController alloc] init];
        [self.navigationController pushViewController:globalVc animated:YES];
        
        
        //push后显示tabbar条
        self.hidesBottomBarWhenPushed = NO;
    }
    if (indexPath.section == 0 && indexPath.row == 0) {
        //隐藏底部条
        self.hidesBottomBarWhenPushed = YES;
        
        WYLSettingViewController *settingVc = [[WYLSettingViewController alloc] init];
        [self.navigationController pushViewController:settingVc animated:YES];
        
        
        //push后显示tabbar条
        self.hidesBottomBarWhenPushed = NO;
    }
}



@end
