//
//  HMXFanJuDetailController.m
//  Bili
//
//  Created by hemengxiang on 16/4/17.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "HMXFanJuDetailController.h"
#import "HMXFanJuDetailHeaderView.h"

@interface HMXFanJuDetailController ()

/** 头部视图 */
@property(weak,nonatomic)UIView *header;

@end

static NSString *const commentCellID = @"commentCell";

@implementation HMXFanJuDetailController

- (void)viewDidLoad {
    [super viewDidLoad];

    //注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:commentCellID];
    
    //创建tableView的头部视图
    HMXFanJuDetailHeaderView *header = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([HMXFanJuDetailHeaderView class]) owner:nil options:nil].firstObject ;
    header.frame = CGRectMake(0, 0, 0, 300);
    self.tableView.bounces = NO;
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(header.frame.size.height, 0, 0, 0);
    self.header = header;
    self.tableView.tableHeaderView = header;
    
    //根据模型的看到last_ep_index  和 total_count两个数据来添加collectionView
    
}


#pragma mark - Table view data source
//返回tableView每一组的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

//返回每行显示的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row];
    
    return cell;
}


@end
