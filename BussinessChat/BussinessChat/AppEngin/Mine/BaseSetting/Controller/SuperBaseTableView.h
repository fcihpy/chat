//
//  SuperBaseTableView.h
//  BussinessChat
//
//  Created by 郑南 on 15-7-7.
//  Copyright (c) 2015年 firstChedai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCellGroup.h"

@interface SuperBaseTableView : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,assign) BOOL isShowLeftItem; // 显示左导航栏按钮
@property (nonatomic,assign) BOOL isShowRightItem; // 显示右导航栏按钮

- (void)baseSetting;

/**
 *  添加tableView元素
 *
 *  @param cellGroup 按照数组的单位进行添加
 */
- (void)baseTableViewAddCellElementGroup:(BaseCellGroup *)cellGroup;

/**
 *  修改tableView元素
 *
 *  @param elementTitle 要修改的标题
 *  @param elementValue 要修改的值
 */
- (void)baseTableViewRevampCellElementTitle:(NSString *)elementTitle andElementValue:(id)elementValue;

@end
