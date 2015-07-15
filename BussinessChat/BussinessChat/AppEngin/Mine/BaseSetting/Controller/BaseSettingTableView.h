//
//  BaseSettingTableVIew.h
//  BussinessChat
//
//  Created by zhisheshe on 15-4-3.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import <UIKit/UIKit.h>



#import "BaseSettingTableCell.h"
#import "CellGroupItem.h"
#import "BaseCellItem.h"
#import "CellArrowItem.h"
#import "CellLabelWithArrowItem.h"
#import "CellImgWithArrowItem.h"
#import "CellSwitchItem.h"
#import "CellLableItem.h"
#import "CellTextFeildItem.h"
#import "CityInfoController.h"
#import "CellImgSubtitleItem.h"

@interface BaseSettingTableView : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray  *_cellModelArry;         //存储model数据
//    UITableView     *_tableView;
}


@property (nonatomic,strong) UITableView  *tableView;

@property (nonatomic,copy)   NSString     *title;                                 //提供给子类可修改的title

@property (nonatomic,assign) BOOL       isShowLeftItem;
@property (nonatomic,assign) BOOL       isShowRightItem;

#pragma mark 基本设置
- (void)baseSetting;

- (void)clickLeftBarItm;

- (void)clickRightBarItm;


@end
