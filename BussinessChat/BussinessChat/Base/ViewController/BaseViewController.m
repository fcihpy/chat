//
//  BaseViewController.m
//  bussinessChat
//
//  Created by zhisheshe on 15-3-25.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController

-(void)viewDidLoad{
    
    
    [super viewDidLoad];

    //基本设置
    [self baseSetting];
    
}


#pragma mark --------------------------------------------基本设置-----------------------------------------------
#pragma mark 基本设置
- (void)baseSetting{
    
    
    self.view.backgroundColor = kGlobalBg;
    
    //leftNavItem
    UIButton *leftBartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBartBtn.frame = CGRectMake(0, 0, 22, 22);
    leftBartBtn.hidden = !self.isShowLeftItem;
    [leftBartBtn setBackgroundImage:[UIImage imageNamed:@"nav_icon_return"] forState:UIControlStateNormal];
    [leftBartBtn addTarget:self action:@selector(clickLeftBarItm) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:leftBartBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    
    //rightBarItem
    UIButton *rightBartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBartBtn.frame = CGRectMake(0, 0, 22, 22);
    rightBartBtn.hidden = !self.isShowRightItem;
    [rightBartBtn setBackgroundImage:[UIImage imageNamed:@"nav_icon_mor"] forState:UIControlStateNormal];
    [rightBartBtn addTarget:self action:@selector(clickRightBarItm) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightbarItem = [[UIBarButtonItem alloc]initWithCustomView:rightBartBtn];
    self.navigationItem.rightBarButtonItem = rightbarItem;

    
}



#pragma mark - 事件处理

- (void)clickLeftBarItm{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)clickRightBarItm{
    
    
}


@end
