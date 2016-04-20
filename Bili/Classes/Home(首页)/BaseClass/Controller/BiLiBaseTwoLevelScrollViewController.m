//
//  BiLiBaseScrollViewController.m
//  BiLiBil 二级展示界面
//
//  Created by sunny on 16/4/7.
//  Copyright © 2016年 sunny. All rights reserved.
//

#import "BiLiBaseTwoLevelScrollViewController.h"
#define scrollViewH 70
#define rightButtonW 80
@interface BiLiBaseTwoLevelScrollViewController ()
@property (weak, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) UIView *contenView;

@property (nonatomic,strong)NSMutableArray *buttonsArray;
@property (nonatomic,strong)UIButton *lastSelectBtn;

@property (nonatomic,assign)BOOL isInitial;
@end

@implementation BiLiBaseTwoLevelScrollViewController

#pragma mark - 懒加载buttonsArray
- (NSMutableArray *)buttonsArray
{
    if (_buttonsArray == nil) {
        _buttonsArray = [NSMutableArray array];
    }
    return _buttonsArray;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    创建顶部的文本scrollView
    [self setupScrollView];
    
//    创建下面的占位视图
    [self setupContenView];
    
//    创建右上角的按钮
    [self setupTopRightButton];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //    2添加按钮
    if (_isInitial == NO) {
        
        [self addButtons];
        
        _isInitial = YES;
    }

    
}

#pragma mark - 创建顶部文本的scrollView
- (void)setupScrollView
{
    CGFloat y = self.navigationController.navigationBarHidden ? 20 : 64;
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, y, ScreenW - rightButtonW,scrollViewH);
    
    [self.view addSubview:scrollView];
    _scrollView = scrollView;

}

#pragma mark - 创建下面的占位视图
- (void)setupContenView
{
    CGFloat y = CGRectGetMaxY(_scrollView.frame);
    UIView *contenView = [[UIView alloc] initWithFrame:CGRectMake(0, y, ScreenW, ScreenH - y)];
    [self.view addSubview:contenView];
    _contenView = contenView;
}

#pragma mark - 创建右上角的按钮
- (void)setupTopRightButton
{
    CGFloat btnW = rightButtonW;
    UIButton *rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightbtn.frame = CGRectMake(ScreenW - btnW, _scrollView.bili_y, btnW, _scrollView.bili_height);
    rightbtn.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:rightbtn];
}


#pragma mark - 添加所有的按钮
- (void)addButtons
{
    NSInteger count = self.childViewControllers.count;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 100;
    CGFloat h = self.scrollView.bili_height;
    for (int i = 0; i < count; i++) {
        x = i * w;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(x, y, w, h);
        [btn setTitle:self.childViewControllers[i].title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        //        绑定标识
        btn.tag = i;
        
        //        监听按钮的点击
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.scrollView addSubview:btn];
        
        if (i == 0) {
            [self btnClick:btn];
        }
        
        [self.buttonsArray addObject:btn];
    }
    
    //    设置scrollView的滚动范围
    self.scrollView.contentSize = CGSizeMake(w * count, self.scrollView.bili_height);
}

#pragma mark - 监听按钮的点击
- (void)btnClick:(UIButton *)btn
{
//        选中按钮
    [self selectBtn:btn];
    
//    移除其他的控制器的view
    for (UIView *view in self.contenView.subviews) {
        [view removeFromSuperview];
    }
    
    NSInteger i = btn.tag;
//    将对应子控制器的view添加上去
    [self setupOneChildViewController:i];
    
}
#pragma mark -把子控制器的view添加
- (void)setupOneChildViewController:(NSInteger)i
{
    UIViewController *vc = self.childViewControllers[i];
    if (vc.isViewLoaded) return;
    // 设置vc的view的位置
    vc.view.frame = self.contenView.bounds;
    [self.contenView addSubview:vc.view];
    
}

- (void)selectBtn:(UIButton *)btn
{
    self.lastSelectBtn.selected = NO;
    btn.selected = YES;
    self.lastSelectBtn = btn;
    
//    让按钮在最左边
    NSInteger count = self.childViewControllers.count;
    CGFloat max = btn.bili_width * count - self.scrollView.bili_width;
    if (btn.bili_x >= max) {
        [self.scrollView setContentOffset:CGPointMake(max, 0) animated:YES];
        return;
    }
    [self.scrollView setContentOffset:CGPointMake(btn.bili_x, 0) animated:YES];
    
}
@end
