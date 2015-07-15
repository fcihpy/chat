//
//  SettingController.m
//  BussinessChat
//
//  Created by zhisheshe on 15-4-8.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "SettingController.h"
#import "PushSettingController.h"
#import "LoginController.h"

@interface SettingController ()
{
    
    
}

@property (strong, nonatomic) UIView *footerView;

@property (nonatomic, strong)UIButton *logoButton;

@end

@implementation SettingController

- (void)viewDidLoad {
    
    [super viewDidLoad];
  
    //基本设置
    [self baseSetting];
    
    [self addItemGroup1];
    
    [self addItemGroup2];
    
    [self addItemGroup3];
    
    self.tableView.tableFooterView = self.footerView;
    
//    XMPPvCardTemp *myVcard = [XmppHelper sharedInstance].vCardModule.myvCardTemp;
//    
//    MyLog(@"agaefag %@--%@",myVcard.nickname,myVcard.photo);
    
    
}



#pragma mark --------------------------------------------基本设置-----------------------------------------------
#pragma mark 基本设置
- (void)baseSetting{
    
    
    _cellModelArry = [NSMutableArray array];

    self.title = @"设置";
    
    
//    leftNavItem
    UIButton *backBartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBartBtn.frame = CGRectMake(0, 0, 22, 22);
    [backBartBtn setBackgroundImage:[UIImage imageNamed:@"nav_icon_return"] forState:UIControlStateNormal];
    [backBartBtn addTarget:self action:@selector(backPrev) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:backBartBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    

}


- (void)addItemGroup1{
    
    CellLabelWithArrowItem *account = [CellLabelWithArrowItem itemWithIcon:@"mine_setup_safety" title:@"帐号与安全"];
    
    
    //section1
    CellGroupItem *group1 = [[CellGroupItem alloc]init];
    group1.items = @[account];
    [_cellModelArry addObject:group1];

}
- (void)addItemGroup2{
    
    
    
    CellLabelWithArrowItem *notif = [CellLabelWithArrowItem itemWithIcon:@"mine_setup_notify" title:@"提醒与通知"];
    notif.pushVCClass = [PushSettingController class];
    
    //section1
    CellGroupItem *group2 = [[CellGroupItem alloc]init];
    group2.items = @[notif];
    [_cellModelArry addObject:group2];
    
}

- (void)addItemGroup3{
    
    CellLabelWithArrowItem *secret = [CellLabelWithArrowItem itemWithIcon:@"mine_setup_secret" title:@"隐私"];
    
    
    //section1
    CellGroupItem *group3 = [[CellGroupItem alloc]init];
    group3.items = @[secret];
    [_cellModelArry addObject:group3];
}



#pragma mark - -------------------------事件处理---------------
- (void)backPrev{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (UIView *)footerView{
    
    if (_footerView == nil) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80)];
        _footerView.backgroundColor = [UIColor clearColor];
        
        UIButton *logoutButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 300, 40)];
        [logoutButton setBackgroundColor:kButtonPreColor];
        logoutButton.layer.cornerRadius = 5;
        NSString *logoutButtonTitle = [NSString stringWithFormat:@"退出登录%@",[AccountTools sharedAccountTools].account.loginName ];
        [logoutButton setTitle:logoutButtonTitle forState:UIControlStateNormal];
        [logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [logoutButton addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:logoutButton];
    }
    
    return _footerView;

}


#pragma mark -退出登录
- (void)logoutAction
{

    [self showHudInView:self.view hint:@"正在退出..."];
//    [[EaseMob sharedInstance].chatManager asyncLogoffWithCompletion:^(NSDictionary *info, EMError *error) {
//        [weakSelf hideHud];
//        if (error) {
//            [weakSelf showHint:error.description];
//        }
//        else{
//            [[ApplyViewController shareController] clear];
//            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
//        }
//    } onQueue:nil];
    
    NSString *username = [AccountTools sharedAccountTools].account.loginName;
    NSString *passwd = [AccountTools sharedAccountTools].account.loginPasswd;
    
    Account *account = [[Account alloc]init];
    account.loginName = username;
    account.loginPasswd = passwd;
    [[AccountTools sharedAccountTools] saveAccount:account];
    
//    [[AccountTools sharedAccountTools] clear];

    __weak SettingController *weakSelf = self;
    [self showHudInView:self.view hint:@"正在退出..."];

    [[XmppHelper sharedInstance] asyncLogoffWithCompletion:^(XMPPResultType type) {
        
         [weakSelf hideHud];
        
        
        [AccountTools sharedAccountTools].isLogin = NO;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
//            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
            LoginController *login = [[LoginController alloc] init];
            
            FCNavigationController *nav = [[FCNavigationController alloc]initWithRootViewController:login];
            
            [self.navigationController pushViewController:nav animated:YES];
            

        });
        
        
    } onQueue:(nil)];
    
    
   
    
}

@end
