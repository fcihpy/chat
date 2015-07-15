//
//  FCNavigationController.m
//  pinchehui
//
//  Created by zhisheshe on 15-2-13.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "FCNavigationController.h"

@implementation FCNavigationController

#pragma mark 第一次使用这个类的使用调,并且只调用一次
+ (void)initialize{
    
    // 1.appearance方法返回一个导航栏的外观对象
    // 1.取出设置主题的对象,修改了这个外观对象，相当于修改了整个项目中继承了此类的tabbar外观
    UINavigationBar *navbar = [UINavigationBar appearance];

    
    // 2.设置导航栏的背景图片
    [navbar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];

    // 3.设置导航栏标题颜色
    [navbar setTitleTextAttributes:@{
                                  NSForegroundColorAttributeName:kLabelColor,
                                  NSFontAttributeName:kFont17
                                  }];
    
    // 4.修改所有UIBarButtonItem的外观
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    
    // 4.1、修改item的背景图片
    [barItem setBackButtonBackgroundImage:[UIImage imageNamed:@"nav_icon_return"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    
    
    // 4.2修改item上面的文字样式
    NSDictionary *dict = @{
                           NSForegroundColorAttributeName:kLabelColor,
                           NSFontAttributeName:kFont14
                        
                           };
    [barItem setTitleTextAttributes:dict forState:UIControlStateNormal];
    [barItem setTitleTextAttributes:dict forState:UIControlStateHighlighted];
    
    
    // 5.设置状态栏样式
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}


#pragma mark 控制状态栏的样式
/*
 状态栏的管理：
 1> iOS7之前：UIApplication
 2> iOS7开始：交给对应的控制器去管理
 */

- (UIStatusBarStyle)preferredStatusBarStyle{
    
    // 白色样式
    return UIStatusBarStyleLightContent;
}


//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    viewController.hidesBottomBarWhenPushed = YES;
//    [super pushViewController:viewController animated:animated];
//}

@end
