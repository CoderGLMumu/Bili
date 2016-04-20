//
//  BiLiBaseTwoLevelViewController.m
//  BiLiBil 二级展示界面
//
//  Created by sunny on 16/4/8.
//  Copyright © 2016年 sunny. All rights reserved.
//

#import "BiLiBaseTwoLevelViewController.h"
#define topViewH 70
#define topBtnW 60
@interface BiLiBaseTwoLevelViewController ()
@property (nonatomic,strong)UIView *topView;

@property (nonatomic,strong)UIView *contenView;

@property (nonatomic,strong)UIButton *lastSelectBtn;

@property (nonatomic,strong)NSMutableArray *buttonsArray;

//view是否初始化过
@property (nonatomic,assign)BOOL isInitial;
@end

@implementation BiLiBaseTwoLevelViewController

#pragma mark - 懒加载buttonsArray
- (NSMutableArray *)buttonsArray
{
    if (_buttonsArray == nil) {
        _buttonsArray = [NSMutableArray array];
    }
    return _buttonsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    创建上面的view
    [self setupTopView];
    
//    创建下面的占位视图
    [self setupContenView];
    
//    添加右边的按钮
    [self setupRightButton];
    
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

- (void)setupRightButton
{
    CGFloat btnW = 80;
    UIButton *rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightbtn.frame = CGRectMake(ScreenW - btnW, _topView.bili_y, btnW, _topView.bili_height);
    rightbtn.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:rightbtn];
}

#pragma mark - 添加所有的按钮
- (void)addButtons
{
    NSInteger count = self.childViewControllers.count;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = topBtnW;
    CGFloat h = self.topView.bili_height;
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
        
        [self.topView addSubview:btn];
        
        if (i == 0) {
            [self btnClick:btn];
        }
        
        [self.buttonsArray addObject:btn];
    }
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

#pragma mark - 选中按钮
- (void)selectBtn:(UIButton *)btn
{
    self.lastSelectBtn.selected = NO;
    btn.selected = YES;
    self.lastSelectBtn = btn;
    
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

#pragma mark - 创建上面的view
- (void)setupTopView
{
    CGFloat y = self.navigationController.navigationBarHidden ? 20 : 64;
    UIView *view = [[UIView alloc ] initWithFrame:CGRectMake(0, y,ScreenW,topViewH)];
    
    view.backgroundColor = [UIColor grayColor];
    _topView = view;
    [self.view addSubview:view];
}

#pragma mark - 创建下面的占位视图
- (void)setupContenView
{
    CGFloat y = CGRectGetMaxY(_topView.frame);
    UIView *contenView = [[UIView alloc] initWithFrame:CGRectMake(0, y, ScreenW, ScreenH - y)];
    [self.view addSubview:contenView];
    _contenView = contenView;
}
@end
