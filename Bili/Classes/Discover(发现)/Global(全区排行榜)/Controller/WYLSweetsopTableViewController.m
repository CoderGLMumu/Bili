//
//  WYLSweetsopTableViewController.m
//  Bili
//
//  Created by 王亚龙 on 16/4/3.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "WYLSweetsopTableViewController.h"
#import "WYLSweetsopCell.h"
#import <AFNetworking.h>
#import "WYLSweetsopItem.h"
#import <MJExtension.h>

static NSString *ID = @"cell";

@interface WYLSweetsopTableViewController ()<UITableViewDataSource, UITableViewDelegate>

/** 模型数组*/
@property (nonatomic ,strong) NSMutableArray *itemArray;




@end

@implementation WYLSweetsopTableViewController

/*
 遇到问题:字典转模型,数据没过来
 */

-(NSMutableArray *)itemArray
{
    if (_itemArray == nil) {
        _itemArray = [NSMutableArray array];
    }
    
    return _itemArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor yellowColor];
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"WYLSweetsopCell" bundle:nil] forCellReuseIdentifier:ID];
    
    //请求数据
    [self loadData];
    
    //设置数据源
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}


-(void)loadData
{
    /*
     http://api.bilibili.com/list?_device=iphone&_hwid=4dc791b793a01fe3&_ulv=5000&access_key=fff31e88a011097d502f65c403a36bac&appkey=27eb53fc9058f8c3&appver=3060&build=3060&ios=0&order=hot&page=0&pagesize=20&platform=ios&tid=13&type=json&sign=3098b1116e6c9c09db8115f435a8cb75
     
     
     http://api.bilibili.com/list?_device=iphone&_hwid=4dc791b793a01fe3&_ulv=5000&access_key=fff31e88a011097d502f65c403a36bac&appkey=27eb53fc9058f8c3&appver=3060&build=3060&ios=0&order=hot&page=0&pagesize=20&platform=ios&tid=1&type=json&sign=a97b8c338bcd64422e9b0f5ff34d9117
     
     */
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];

    [mgr GET:@"http://api.bilibili.com/list?_device=iphone&_hwid=4dc791b793a01fe3&_ulv=5000&access_key=fff31e88a011097d502f65c403a36bac&appkey=27eb53fc9058f8c3&appver=3060&build=3060&ios=0&order=hot&page=0&pagesize=20&platform=ios&tid=13&type=json&sign=3098b1116e6c9c09db8115f435a8cb75" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
        //获取字典
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:responseObject[@"list"]];

        //移除多余的key
        [dict removeObjectForKey:@"num"];
        
        NSMutableArray *array = [NSMutableArray array];
        
        for (int i = 0; i < 20; i++) {
            NSDictionary *tempDict = dict[[NSString stringWithFormat:@"%d",i]];
            [array addObject:tempDict];
        }
        
        //字典数组-->模型数组
        self.itemArray = [WYLSweetsopItem mj_objectArrayWithKeyValuesArray:array];
        
        //刷新数据
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    

}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WYLSweetsopCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    WYLSweetsopItem *item = self.itemArray[indexPath.row];
    
    //设置数据
    cell.item = item;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
}


@end
