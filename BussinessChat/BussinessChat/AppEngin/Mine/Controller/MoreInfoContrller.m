//
//  MoreInfoContrller.m
//  BussinessChat
//
//  Created by zhisheshe on 15-4-3.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "MoreInfoContrller.h"

@implementation MoreInfoContrller



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //基本设置
    [self baseSetting];
    
    [self addItemGroup1];
    
    [self addItemGroup2];
    
    
     [self addItemGroup3];
}


#pragma mark 基本设置
- (void)baseSetting{
    
    [super baseSetting];
    
    self.title = @"更多资料";
    
    self.isShowLeftItem = YES;
    

    
    _cellModelArry = [NSMutableArray array];
}



- (void)addItemGroup1{
    
    CellLabelWithArrowItem *jobItem = [CellLabelWithArrowItem itemWithTitle:@"工作经历"];
  
    CellGroupItem *group1 = [[CellGroupItem alloc]init];
    group1.items = @[jobItem];
    
    
    [_cellModelArry addObject:group1];
}


- (void)addItemGroup2{
    
    CellLabelWithArrowItem *trainItem = [CellLabelWithArrowItem itemWithTitle:@"教育经历"];
    
    CellGroupItem *group2 = [[CellGroupItem alloc]init];
    group2.items = @[trainItem];
    
    
    [_cellModelArry addObject:group2];
}

- (void)addItemGroup3{
    
    CellLabelWithArrowItem *secretItem = [CellLabelWithArrowItem itemWithTitle:@"隐私"];

    
    
    CellGroupItem *group3 = [[CellGroupItem alloc]init];
    group3.items = @[secretItem];
    
    
    [_cellModelArry addObject:group3];
}


- (void)clickLeftBarItm{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
