//
//  PushSettingController.m
//  BussinessChat
//
//  Created by zhisheshe on 15-4-3.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "PushSettingController.h"

@implementation PushSettingController



- (void)viewDidLoad {
    [super viewDidLoad];
   
    //基本设置
    [self baseSetting];
    
    [self addItemGroup1];

    [self addItemGroup2];
  
}


#pragma mark 基本设置
- (void)baseSetting{
    
    [super baseSetting];
    
    self.isShowLeftItem = YES;
    
    self.title = @"提醒与通知";
//    self.view.backgroundColor = kGlobalBg;
    
    //leftNavItem
//    UIButton *backBartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBartBtn.frame = CGRectMake(0, 0, 22, 22);
//    [backBartBtn setBackgroundImage:[UIImage imageNamed:@"nav_icon_return"] forState:UIControlStateNormal];
//    [backBartBtn addTarget:self action:@selector(backPrev) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:backBartBtn];
//    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    _cellModelArry = [NSMutableArray array];
}

- (void)addItemGroup1{
    
    CellSwitchItem *audioItem = [CellSwitchItem itemWithTitle:@"声音"];
    audioItem.valueForKey = @"audioItem";
    
    CellSwitchItem *shakeItem = [CellSwitchItem itemWithTitle:@"震动"];
    shakeItem.valueForKey = @"shakeItem";
    
    CellSwitchItem *pushItem = [CellSwitchItem itemWithTitle:@"消息通知"];
    pushItem.valueForKey = @"pushItem";
    
    CellGroupItem *group1 = [[CellGroupItem alloc]init];
    group1.items = @[audioItem,shakeItem,pushItem];
    
    
    [_cellModelArry addObject:group1];
}


- (void)addItemGroup2{
    
    CellLableItem *logoffItem = [CellLableItem itemWithTitle:@"注销"];
    
    CellLableItem *updateItem = [CellLableItem itemWithTitle:@"检查更新"];
    
    
    CellGroupItem *group2 = [[CellGroupItem alloc]init];
    group2.items = @[logoffItem,updateItem];
    
    
    [_cellModelArry addObject:group2];
}
@end
