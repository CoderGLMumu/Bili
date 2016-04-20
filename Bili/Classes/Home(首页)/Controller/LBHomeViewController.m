//
//  LBHomeViewController.m
//  Bili
//
//  Created by 林彬 on 16/3/31.
//  Copyright © 2016年 gl. All rights reserved.
//

/*
  基本思路不一样了.
  原先,是内容滚动区域中的view,切换哪个就添加哪个子控制器的View上去.由于添加动作是在滚动结束的时候做,会造成滚动的时候下一个view是空的情况.
  然而,根据B站项目需求,需要在切换视图,也就是滚动的时候就能看到下一个View的内容,所以,更改思路,一开始就把全部子控制器的View全塞到内容滚动视图中.
 */


#import "LBHomeViewController.h"
#import "LBLiveViewController.h" // 直播
#import "LBRecommedViewController.h" // 推荐
#import "LBDarmaViewController.h" // 番剧
#import "LBSubareaViewController.h" // 分区
#import "LBColorScale.h"

#define titleH 45

@interface LBHomeViewController () <UIScrollViewDelegate>
// 按钮数组
@property(nonatomic , strong)NSMutableArray *btnArr;

// 标题滚动条
@property(nonatomic , weak)UIScrollView *titleSCV;

// 内容滚动条
@property(nonatomic , weak)UIScrollView *mainSCV;

// 上一个选中的按钮
@property(nonatomic , strong)UIButton *preBtn;

// 判断这个类的子类是不是创建这个类对象
@property(nonatomic , assign)BOOL isInital;

// 下划线
@property(nonatomic , weak)UIView *underLineView;

@end

@implementation LBHomeViewController

#pragma mark -  懒加载数组
- (NSMutableArray *)btnArr
{
    if (_btnArr == nil) {
        _btnArr = [NSMutableArray array];
    }
    return _btnArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 取消系统自动为导航控制器预留的64高度,避免错位
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 隐藏导航栏
    self.navigationController.navigationBarHidden = YES;
    
    // 设置标题滚动栏
    [self setUpTitleScrollView];

    // 设置内容滚动栏
    [self setUpMainScrollView];
    
    // 设置子控制器
    [self setUpChildViewController];
    
   
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_isInital == NO) {
        // 设置标题按钮,确保子类调用的时候,只添加一次按钮,防止重复添加
        [self setUpTitleButton];
        
        // 设置下划线
        [self setUpUnderLine];
        
        // 添加需要提前显示的子控制器的View到内容滚动栏
        [self addCurrentChildView:0];
        [self addCurrentChildView:1];
        [self addCurrentChildView:2];
        [self addCurrentChildView:3];
        
        _isInital = YES;
    }
}


#pragma mark -  设置标题滚动条
- (void)setUpTitleScrollView
{
    UIScrollView *titleSCV = [[UIScrollView alloc] init];
    // 判断有没有隐藏导航栏,如果隐藏了导航栏,那么高度就是20.如果没有,那就是64.
    CGFloat y = self.navigationController.navigationBarHidden?20:64;
    titleSCV.frame = CGRectMake(0, y, ScreenW, titleH);
    titleSCV.backgroundColor = [UIColor whiteColor];
    self.titleSCV = titleSCV;
    [self.view addSubview:titleSCV];
}

#pragma mark -  设置内容滚动条
- (void)setUpMainScrollView
{
    UIScrollView *mainSCV = [[UIScrollView alloc] init];
    
    // 内容的y值是标题滚动条y值的最大值
    CGFloat y = CGRectGetMaxY(self.titleSCV.frame);
    
    // 设置内容滚动条的位置,再减49是底部tableBar
    mainSCV.frame = CGRectMake(0, y, ScreenW, ScreenH - y - 49);
    
    mainSCV.backgroundColor = [UIColor yellowColor];
    
    _mainSCV = mainSCV;
    
    [self.view addSubview:mainSCV];
    
    // 设置代理,用来调用滚动完毕触发的方法
    mainSCV.delegate = self;
}

#pragma mark -  设置子控制器
- (void)setUpChildViewController
{
    // 添加直播子控制器
    LBLiveViewController *liveVC = [[LBLiveViewController alloc] init];
    liveVC.title = @"直播";
    liveVC.view.backgroundColor = [UIColor blueColor];
    [self addChildViewController:liveVC];
    
    // 添加推荐子控制器
    LBRecommedViewController *recommedVC = [[LBRecommedViewController alloc] init];
    recommedVC.title = @"推荐";
    recommedVC.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:recommedVC];
    
    // 添加番剧子控制器
    LBDarmaViewController *darmaVC = [[LBDarmaViewController alloc] init];
    darmaVC.title = @"番剧";
    darmaVC.view.backgroundColor = [UIColor blueColor];
    [self addChildViewController:darmaVC];
    
    // 添加分区子控制器
    LBSubareaViewController *subareaVC = [[LBSubareaViewController alloc] init];
    subareaVC.title = @"分区";
    subareaVC.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:subareaVC];
}

#pragma mark -  设置标题按钮
- (void)setUpTitleButton
{
    // 多少个子控制器?
    NSInteger count = self.childViewControllers.count;
    
    // 设置按钮的frame
    CGFloat btnW = ScreenW / 4;  // 暂时就4个.由于平分,暂时没有滚动效果.
    CGFloat btnH = titleH;
    
    CGFloat btnY = 0;
    for (int i = 0; i < count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        // 设置按钮角标
        btn.tag = i;
        
        CGFloat btnX = i * btnW;
        // 按钮尺寸
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [btn setTitleColor:[UIColor colorWithRed:213/255.0 green:213/255.0 blue:213/255.0 alpha:1] forState:UIControlStateNormal];
        [btn setTitle:self.childViewControllers[i].title forState:UIControlStateNormal];
        
        // 选中状态的颜色要放到按钮点击事件里面做,不然无法实现按钮颜色的渐变.(被选中的按钮会一直是粉红色)
        //[btn setTitleColor:[UIColor colorWithRed:242/255.0 green:98/255.0 blue:140/255.0 alpha:1] forState:UIControlStateSelected];
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleSCV addSubview:btn];
        
        // 把按钮放到数组中,是为了让按钮有序地排位,方便在外面通过脚标获取对应按钮
        [self.btnArr addObject:btn];
        
        // 默认按钮选中 "直播"
        if (i == 0) {
            [self btnClick:btn];
        }
    }
    
#pragma mark -  设置标题滚动区域的滚动范围,尺寸
    // 知道了多少个btn,才能设置scrollView的滚动范围
    self.titleSCV.contentSize = CGSizeMake(count * btnW, 0);
    self.titleSCV.showsHorizontalScrollIndicator = NO;
    
#pragma mark -  设置内容滚动区域的滚动范围,尺寸
    // 既然是一个btn对应一个界面,那么内容界面的滚动范围也可以在这设置了.
    self.mainSCV.contentSize = CGSizeMake(count * ScreenW, 0);
    // 设置为可翻页
    self.mainSCV.pagingEnabled = YES;
    //清空水平滚动指示条
    self.mainSCV.showsHorizontalScrollIndicator = NO;
    //取消弹簧效果
    self.mainSCV.bounces = NO;
    
}

#pragma mark -  标题按钮点击事件
- (void)btnClick:(UIButton *)currentButton
{
    // 恢复上一个按钮选中标题
    [_preBtn setTitleColor:[UIColor colorWithRed:213/255.0 green:213/255.0 blue:213/255.0 alpha:1] forState:UIControlStateNormal];
    _preBtn.transform = CGAffineTransformIdentity;
    [currentButton setTitleColor:[UIColor colorWithRed:242/255.0 green:98/255.0 blue:140/255.0 alpha:1] forState:UIControlStateNormal];
    self.preBtn = currentButton;
    
    // 点击的时候,对文字也进行缩放
    // 标题缩放 -> 如何让标题缩放 改形变
    currentButton.transform = CGAffineTransformMakeScale(1.3, 1.3);
   
    
    // 角标最好从tag取,性能好过遍历数组
    NSInteger index = currentButton.tag;
    
    [UIView animateWithDuration:0.25 animations:^{
        // 按钮点击的时候,下划线位移
        // 做下划线的滑动动画
        self.underLineView.width = currentButton.titleLabel.width + 10;
//        self.underLineView.centerX = currentButton.centerX;
        // 点击按钮,切换对应角标的子控制器的view
        [self changeChildVCInMainSCV:index];
        // 让内容滚动条滚动对应位置,就是"直播"出现在第一个位置
        CGFloat x = index * ScreenW;
        // 获得偏移量
        self.mainSCV.contentOffset = CGPointMake(x, 0);
        
    } completion:^(BOOL finished) {
        // 动画结束的时候,加载控制器(方便实现懒加载)
        [self addCurrentChildView:index];
    }];
}

#pragma mark -  设置下划线
- (void)setUpUnderLine
{
    // 获取第一个按钮.因为一开始就是选中的第一个按钮.要的是这个按钮的颜色,文字宽度
    UIButton *firstButton = self.btnArr.firstObject;
    
    UIView *underLineView = [[UIView alloc] init];
    CGFloat underLineH = 2;
    CGFloat underLineY = self.titleSCV.height - underLineH;
    underLineView.frame = CGRectMake(0, underLineY, 0, underLineH);
    underLineView.backgroundColor = [firstButton titleColorForState:UIControlStateNormal];
    [self.titleSCV addSubview:underLineView];
    self.underLineView = underLineView;
    
    //    // 新点击的按钮 -> 红色
    //    firstButton.selected = YES;
    //    self.preButton = firstButton;
    
    // 下划线
    [firstButton.titleLabel sizeToFit];
    self.underLineView.width = firstButton.titleLabel.width + 10;
    self.underLineView.centerX = firstButton.centerX;
}


#pragma mark - 切换内容滚动区域中的View
- (void)changeChildVCInMainSCV:(NSInteger) i
{
    
    // 让内容滚动条滚动对应位置,就是"直播"出现在第一个位置
    CGFloat x = i * ScreenW;
    // 获得偏移量
    self.mainSCV.contentOffset = CGPointMake(x, 0);
}

#pragma mark - 内容滚动区域滚动完毕调用的代理方法,用来把子控制器添加到内容滚动区域中
// 其实滚动切换mainSCV中的内容,和点击标题按钮切换内容是一样的.不如做成滚动完毕的时候,就相当于点击了对应角标的标题按钮
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 获取当前偏移量和屏幕宽度的商,就是角标
    NSInteger i = scrollView.contentOffset.x / ScreenW;
    
    // 根据对应的角标,获得对应的按钮
    UIButton *btn = self.btnArr[i];
    
    // 调用按钮选中方法.
    // 就相当于滚动完毕后,调用了标题的按钮点击事件.
    [self btnClick:btn];

    
}

#pragma mark -  开始滚动的时候,对按钮文字进行缩放,对颜色进行渐变
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 对字体和颜色进行渐变
    [LBColorScale scaleColor:scrollView withButtonArray:self.btnArr];
    [LBColorScale scaleTitle:scrollView withButtonArray:self.btnArr];
    
    
    // 下划线随内容scrollView的滚动而滚动,发生位移
    // CGAffineTransformMakeTranslation 方法
    // 左滑: 0到1;
    // 右滑: 0到-1;
    
    CGFloat offset = scrollView.contentOffset.x / ScreenW;

    //NSLog(@"%lf",offset);
    
    
    UIButton *btn = self.btnArr.firstObject;
    
    self.underLineView.transform = CGAffineTransformMakeTranslation(offset * btn.width, 0);
    
    
}

#pragma mark -  添加所有子控制器的View到内容滚动区域
- (void)addCurrentChildView:(NSInteger)index
{
    
        // 根据角标获得对应的子控制器
        UIViewController *vc = self.childViewControllers[index];
        
        // 判断下有没有父控件,防止重复调用这个方法.
        if (vc.view.superview) return;
        
        // 设置frame
        CGFloat x = index * ScreenW;
        vc.view.frame = CGRectMake(x, 0, ScreenW, self.mainSCV.height);
        
        // 这个子view加载到父view中调用多次也是没关系的
        [self.mainSCV addSubview:vc.view];
    
}


@end
