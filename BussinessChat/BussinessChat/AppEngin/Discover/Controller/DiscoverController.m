//
//  DiscoverController.m
//  bussinessChat
//
//  Created by zhisheshe on 15-3-25.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "DiscoverController.h"
#import "FriendCircleContrller.h"


@implementation DiscoverController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //基本设置
    [self baseSetting];
    
    [self addItemGroup1];
    
    [self addItemGroup2];
    
}

#pragma mark --------------------------------------------基本设置-----------------------------------------------
#pragma mark 基本设置
- (void)baseSetting{
    
    self.title = @"发现";
 
    _cellModelArry = [NSMutableArray array];
  
}

- (void)addItemGroup1{
    
    CellLabelWithArrowItem *friendCircle = [CellLabelWithArrowItem itemWithIcon:@"discover_friendCircle_icon" title:@"朋友圈"];
    friendCircle.pushVCClass = [FriendCircleContrller class];
    
    //section1
    CellGroupItem *group1 = [[CellGroupItem alloc]init];
    group1.items = @[friendCircle];
    [_cellModelArry addObject:group1];
   
}


- (void)addItemGroup2{
    
    
    CellLabelWithArrowItem *app1 = [CellLabelWithArrowItem itemWithIcon:@"discover_app_icon1" title:@"住房圈"];
    CellLabelWithArrowItem *app2 = [CellLabelWithArrowItem itemWithIcon:@"discover_app_icon2" title:@"车商圈"];
    CellLabelWithArrowItem *app3 = [CellLabelWithArrowItem itemWithIcon:@"discover_app_icon3" title:@"海淘圈"];
    
    //section2
    CellGroupItem *group2 = [[CellGroupItem alloc]init];
    group2.items = @[app1,app2,app3];
    [_cellModelArry addObject:group2];
    
}


- (void)loadModelData{
   
    
}



@end
