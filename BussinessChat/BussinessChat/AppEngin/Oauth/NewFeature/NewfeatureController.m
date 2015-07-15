//
//  NewfeatureController.m
//  bussinessChat
//
//  Created by zhisheshe on 15-3-25.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#define kImgCount 3

#import "NewfeatureController.h"
#import "MainController.h"
#import "LoginController.h"
#import "RegisterStep1.h"
#import "MainController.h"

@interface NewfeatureController ()<UIScrollViewDelegate>
{
    UIPageControl *_page;
    UIScrollView *_scroll;
    
    MainController *_mainController;
}
@end

@implementation NewfeatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 1.添加UIScrollView
    [self addScrollView];
    [self.view addSubview:_scroll];
    
    // 2.添加图片
    [self addScrollImages];
    
    // 3.添加UIPageControl
    [self addPageControl];
    
    
}
#pragma mark - --------------------------------基本设置-----------------------




#pragma mark - ---------------------------------buildUI--------------------------

#pragma mark - UI界面初始化
#pragma mark 添加滚动视图
- (UIScrollView *)addScrollView
{
    if (_scroll == nil) {
        UIScrollView *scroll = [[UIScrollView alloc] init];
        scroll.frame = self.view.frame;
        scroll.showsHorizontalScrollIndicator = NO; // 隐藏水平滚动条
        CGSize size = scroll.frame.size;
        scroll.contentSize = CGSizeMake(size.width * kImgCount, 0); // 内容尺寸
        scroll.pagingEnabled = YES; // 分页
        scroll.delegate = self;
        scroll.bounces = NO;
        
        _scroll = scroll;

    }
    return _scroll;
}

#pragma mark 添加滚动显示的图片
- (void)addScrollImages
{
    CGSize size = _scroll.frame.size;
    
    for (int i = 0; i<kImgCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        
        // 1.显示图片
        NSString *name = [NSString stringWithFormat:@"userGuide_%d", i + 1];
        imageView.image = [UIImage imageNamed:name];
    
        // 2.设置frame
        imageView.frame = CGRectMake(i * size.width, 0, size.width, size.height);
        [_scroll addSubview:imageView];

        UIButton *loginBtn = [self makeButtonWithTitle:@"登录" frame:CGRectMake(screenW * 0.15, screenH * 0.88, 100, 37) tag:1];
        loginBtn.layer.cornerRadius = 5;
        loginBtn.layer.borderColor = kButtonNorColor.CGColor;
        loginBtn.layer.borderWidth = 0.5;
        [loginBtn.layer setBorderWidth:1];
        [loginBtn setBackgroundColor:kLabelColor];
        [loginBtn setTitleColor:kButtonPreColor forState:UIControlStateNormal];
        
        UIButton *registerBtn = [self makeButtonWithTitle:@"注册" frame:CGRectMake(screenW * 0.55, screenH * 0.88, 100, 37) tag:2];
        registerBtn.layer.cornerRadius = 5;
        registerBtn.layer.borderColor = kButtonNorColor.CGColor;
        registerBtn.layer.borderWidth = 0.5;
        [registerBtn.layer setBorderWidth:1];
        
        UIButton *guestUser = [self makeButtonWithTitle:@"随便逛逛" frame:CGRectMake(screenW * 0.35, screenH * 0.78, 100, 37) tag:3];
        
        [self.view addSubview:loginBtn];
        [self.view addSubview:registerBtn];
//        [self.view addSubview:guestUser];
        
        imageView.userInteractionEnabled = YES;

    }
}

#pragma mark 添加分页指示器
- (void)addPageControl
{
    
    UIPageControl *page = [[UIPageControl alloc] init];
    page.center = CGPointMake(screenW * 0.5, screenH * 0.85);
    page.numberOfPages = kImgCount;

    page.currentPageIndicatorTintColor = kLabelColor;
    page.pageIndicatorTintColor = [UIColor lightGrayColor];
    
    page.bounds = CGRectMake(0, 0, 150, 0);
    [self.view addSubview:page];
    _page = page;
}

#pragma mark -快速创建btn
- (UIButton *)makeButtonWithTitle:(NSString *)title frame:(CGRect)frame tag:(int)tag{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    btn.tag = tag;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [btn.titleLabel setFont:kFont17];
    
    return btn;
}


#pragma mark ---------------------------事件处理--------------------------

#pragma mark - btn点击事件
- (void)btnClick:(UIButton *)btn{
    
    if (btn.tag == 1) {         //登录
//         FCNavigationController *nav = [[FCNavigationController alloc]initWithRootViewController:[[LoginController alloc]init]];
        
        [self presentViewController:[[LoginController alloc]init] animated:YES completion:nil];
        
    }else if (btn.tag == 2){    //注册
        FCNavigationController *nav = [[FCNavigationController alloc]initWithRootViewController:[[RegisterStep1 alloc]init]];
        [self presentViewController:nav animated:YES completion:nil];
//        [self.navigationController pushViewController:nav animated:YES];
        
    
    }else if (btn.tag == 3){    //随便逛
        
        FCNavigationController *nav = [[FCNavigationController alloc]initWithRootViewController:[[MainController alloc]init]];
        [self presentViewController:nav animated:YES completion:nil];
      
        
    }
    
    
}


#pragma mark - 监听按钮点击
#pragma mark 开始
- (void)start
{
    
//    [self logoff];  //版本更新后，要先登出
    
    // 显示状态栏
    [UIApplication sharedApplication].statusBarHidden = NO;
    
   
    UINavigationController *nav = nil;
    
    if (self.isAutoLogin || self.loginSuccess) {
//        [[ApplyViewController shareController] loadDataSourceFromLocalDB];
        
        if (_mainController == nil) {
            _mainController = [[MainController alloc] init];
            //                    [_mainController networkChanged:_connectionState];
            nav = [[UINavigationController alloc] initWithRootViewController:_mainController];
        }else{
            nav  = _mainController.navigationController;
        }
        [nav setNavigationBarHidden:NO];
        
    }else{
        _mainController = nil;
        
        //设置状态栏的样式
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        
        LoginController *loginController = [[LoginController alloc] init];
        nav = [[UINavigationController alloc] initWithRootViewController:loginController];
        
        nav.navigationBarHidden = YES;
    }
    self.view.window.rootViewController = nav;
    
    if ([UIDevice currentDevice].systemVersion.floatValue < 7.0){
        nav.navigationBar.barStyle = UIBarStyleDefault;
        [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleBar"]
                                forBarMetrics:UIBarMetricsDefault];
        
        [nav.navigationBar.layer setMasksToBounds:YES];
        [nav setNavigationBarHidden:YES];
    }
    
}


- (void)logoff{
//    [[EaseMob sharedInstance].chatManager asyncLogoffWithCompletion:^(NSDictionary *info, EMError *error) {
//        
//        if (error) {
//            
//        }
//        else{
//            [[ApplyViewController shareController] clear];
//            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
//        }
//    } onQueue:nil];
}



#pragma mark - 滚动代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _page.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
