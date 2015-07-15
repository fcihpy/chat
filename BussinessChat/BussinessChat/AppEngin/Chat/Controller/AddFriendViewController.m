//
//  AddFriendViewController.m
//  BussinessChat
//
//  Created by WQY on 15-5-5.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "AddFriendViewController.h"
#import "AddFriendView.h"
#import "AccountTools.h"
#import "Account.h"

@interface AddFriendViewController ()<UISearchBarDelegate>

@property (nonatomic,strong)UISearchBar *searchController;

@end

@implementation AddFriendViewController{
  
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.view = [[AddFriendView alloc ] initWithFrame:self.view.frame delegate:self];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self baseSetting];
    
    [self buildUI];
    
    
}


#pragma mark 基本设置
- (void)baseSetting{
    
    self.view.backgroundColor = kGlobalBg;
    self.title = @"添加好友";
    
    //leftNavItem
    UIButton *backBartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBartBtn.frame = CGRectMake(0, 0, 22, 22);
    [backBartBtn setBackgroundImage:[UIImage imageNamed:@"nav_icon_return"] forState:UIControlStateNormal];
    [backBartBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:backBartBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
 
}

#pragma mark -添加通讯录button
- (void)buildUI{
    
    UIButton *btn = [[UIButton alloc]init];
    [btn addTarget:self action:@selector(addContants) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"从通讯录添加" forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 100, 320,50);
    
//    [self.view addSubview:btn];
    
    
}


- (void)addContants{
    
    
}

#pragma mark --------------------------确定加为好友----------------------------------------

//点击对号走的方法
- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar{
    
    [[XmppHelper sharedInstance ] addFriendWithJidStr:searchBar.text];
}

//点击键盘的Search按钮走的方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [[XmppHelper sharedInstance ] addFriendWithJidStr:searchBar.text];
    
    [self back];
}


-(void)back{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewHidden:(UITapGestureRecognizer *)viewHidden{
    [viewHidden.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
