//
//  BiLiLivePlayingViewController.m
//  BiLiBil 二级展示界面
//
//  Created by sunny on 16/4/9.
//  Copyright © 2016年 sunny. All rights reserved.
//

#import "BiLiLivePlayingViewController.h"
#import "BiLiHotestLivePlayingViewController.h"
#import "BiLiRecentLivePlayingViewController.h"
#import "BiLiLivePlayingButton.h"
@interface BiLiLivePlayingViewController () <UIScrollViewDelegate>
/** 标题栏 */
@property (nonatomic,weak)UIView *titlesView;
/** 上一个选中的按钮 */
@property (nonatomic,weak)BiLiLivePlayingButton *previousClickedButton;
/** 下划线 */
@property (nonatomic,weak)UIView *underlineView;
/** scrollView */
@property (nonatomic,weak)UIScrollView *scrollView;
@end

@implementation BiLiLivePlayingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"全部直播";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    添加子控制器
    [self setupChildVc];
    
//    添加标题栏
    [self setupTitlesView];
    
//    添加scrollView
    [self setupScrollView];
    
    [self titleButtonClick:self.titlesView.subviews[0]];
    
}

#pragma mark - 添加子控制器
- (void)setupChildVc
{
    //    最热
    BiLiHotestLivePlayingViewController *allVc = [BiLiHotestLivePlayingViewController viewController];
    allVc.title = @"最热";
    [self addChildViewController:allVc];
    
    //    最新
    BiLiRecentLivePlayingViewController *newVc = [BiLiRecentLivePlayingViewController viewController];
    newVc.title = @"最新";
    [self addChildViewController:newVc];
}

#pragma mark - 添加标题栏
- (void)setupTitlesView
{
    self.navigationController.navigationBarHidden = NO;
    CGFloat y = self.navigationController.navigationBarHidden ? 20 : 64;
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = [UIColor whiteColor];
    titleView.frame = CGRectMake(0, y,ScreenW , 44);
    self.titlesView = titleView;
    [self.view addSubview:titleView];
    
//    添加标题按钮
    [self setupTitleButtons];
    
//    添加下划线
    [self setupUnderline];
}
#pragma mark - 添加标题按钮
- (void)setupTitleButtons
{
    NSInteger count = self.childViewControllers.count;
    CGFloat titleButtonX = 0;
    CGFloat titleButtonW = ScreenW / count;
    for (int i = 0; i < count ; i++) {
        titleButtonX = i * titleButtonW;
        BiLiLivePlayingButton *titleButton = [[BiLiLivePlayingButton alloc] init];
        titleButton.frame = CGRectMake(titleButtonX, 0, titleButtonW, self.titlesView.bili_height);
        [titleButton setTitle:self.childViewControllers[i].title forState:UIControlStateNormal];
        titleButton.tag = i;
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titlesView addSubview:titleButton];
    }
}

#pragma mark - 添加下划线
- (void)setupUnderline
{
    BiLiLivePlayingButton *titleButton = self.titlesView.subviews.firstObject;
    CGFloat underlineH = 3;
    CGFloat underlineW = ScreenW / self.childViewControllers.count;
    CGFloat y = self.titlesView.bili_height - underlineH;
    UIView *underlineView = [[UIView alloc] init];
    underlineView.frame = CGRectMake(0, y,underlineW , underlineH);
    underlineView.backgroundColor = [titleButton titleColorForState:UIControlStateSelected];
    self.underlineView = underlineView;
    [self.titlesView addSubview:underlineView];
}

#pragma mark - 添加scrollView
- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    CGFloat scrollViewY = CGRectGetMaxY(self.titlesView.frame) + 10;
    CGFloat scrollViewH = ScreenH - scrollViewY;
    scrollView.frame = CGRectMake(0, scrollViewY, ScreenW, scrollViewH);
    self.scrollView = scrollView;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
//    其他设置
    NSInteger count = self.childViewControllers.count;
    scrollView.contentSize = CGSizeMake(count * self.scrollView.bili_width, 0);
    scrollView.pagingEnabled = YES;
}

#pragma mark - 标题按钮的点击事件
- (void)titleButtonClick:(BiLiLivePlayingButton *)titleButton
{
//    选中按钮
    self.previousClickedButton.selected = NO;
    titleButton.selected = YES;
    self.previousClickedButton = titleButton;
    

    [UIView animateWithDuration:0.25 animations:^{
        //    改变下划线的位置
        self.underlineView.bili_centerX = titleButton.bili_centerX;
        
//        滑动scrollView
        self.scrollView.contentOffset = CGPointMake(titleButton.tag * self.scrollView.bili_width, self.scrollView.contentOffset.y);
    }];
    
//    将对应子控制器的view添加上去
    [self setupOneChileView:titleButton];
}

#pragma mark - 将对应子控制器的view添加上去
- (void)setupOneChileView:(BiLiLivePlayingButton *)titleButton
{
    UIViewController *vc = self.childViewControllers[titleButton.tag];
    if (vc.isViewLoaded) return;
    vc.view.frame = CGRectMake(titleButton.tag * self.scrollView.bili_width, 0, self.scrollView.bili_width, self.scrollView.bili_height);
    [self.scrollView addSubview:vc.view];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / ScreenW;
    BiLiLivePlayingButton *titleButton = self.titlesView.subviews[index];
    [self titleButtonClick:titleButton];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pointX = scrollView.contentOffset.x * self.underlineView.bili_width / scrollView.bili_width;
    self.underlineView.bili_x = pointX;
}
@end
