//
//  MainController.m
//  bussinessChat
//
//  Created by zhisheshe on 15-3-25.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//



#import "MainController.h"
#import "ChatListController.h"
#import "DiscoverController.h"
#import "ContactsController.h"
#import "MineController.h"
#import "UIBarButtonItem+FC.h"


@interface MainController ()<TabbarViewDelegate>
{
    TabbarView *_customTabbarView;
}

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //基本设置
    [self baseSetting];
    
    // 添加子控制器
    [self addAllChildControllers];
    
    //添加底标签控制器
    [self addCustomTabbar];   

}

#pragma mark - ---------------------------------基本设置-----------------------------
- (void)baseSetting{
    
//   self.view.backgroundColor = [UIColor greenColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    for (UIViewController *vc in self.childViewControllers)
    {
        vc.edgesForExtendedLayout = UIRectEdgeNone;
        
    }
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - --------------------------------buildUI------------------------------

#pragma mark -添加底标签控制器
- (void)addCustomTabbar{
    
    self.tabBar.hidden = YES;
    _customTabbarView = [[TabbarView alloc]init];
    _customTabbarView.frame = CGRectMake(0, screenH - 49- 64, screenW, 49);
    _customTabbarView.delegate = self;
    [self.view addSubview:_customTabbarView];
    
}


#pragma mark - 添加子控制器
- (void)addAllChildControllers
{
    // 1.车源
    ChatListController *chatVC = [[ChatListController alloc] init];

    [self addChildViewController:chatVC];
    
    //2.商圈
    ContactsController *contacts = [[ContactsController alloc]init];
    [self addChildViewController:contacts];
    
    // 3.首页
    DiscoverController *discoverVC = [[DiscoverController alloc] init];
    [self addChildViewController:discoverVC];
    
    // 4.我的
    MineController *mineVC = [[MineController alloc] init];
    

    [self addChildViewController:mineVC];
    
    //默认选中的item
    [self TabbarView:_customTabbarView fromBarItem:0 toBarItem:0];
    
}


#pragma mark - --------------------------------tabbarView Delegate----------------------------------
- (void)TabbarView:(TabbarView *)TabbarView fromBarItem:(NSUInteger)fromBarItem toBarItem:(NSUInteger)toBarItem{
    
    //根据点击位置，确定某个控制器的显示
    self.selectedIndex = toBarItem;
    
    //取出将要显示的控制器
    UIViewController *newVC = self.childViewControllers[toBarItem];
    
    //将新控制器的Item移值给本tabar的navgationitem
    self.navigationItem.leftBarButtonItem = newVC.navigationItem.leftBarButtonItem;
    self.navigationItem.leftBarButtonItems = newVC.navigationItem.leftBarButtonItems;
    self.navigationItem.rightBarButtonItem = newVC.navigationItem.rightBarButtonItem;
    self.navigationItem.rightBarButtonItems = newVC.navigationItem.rightBarButtonItems;
    self.navigationItem.titleView = newVC.navigationItem.titleView;
    self.navigationItem.title = newVC.navigationItem.title;
    self.title = newVC.title;
    
}



#pragma mark - --------------------------------事件处理------------------------------


- (void)dealloc
{
//    [self unregisterNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
