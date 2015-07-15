//
//  BaseSettingTableVIew.m
//  BussinessChat
//
//  Created by zhisheshe on 15-4-3.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "BaseSettingTableView.h"


const int kCellSectionHeaderH1 = 20;

@implementation BaseSettingTableView


- (void)loadView{
  
    [self baseSetting];
    
    //添加tableView
    [self addTableView];
    self.view = _tableView;

}


#pragma mark --------------------------------------------基本设置-----------------------------------------------
#pragma mark 基本设置
- (void)baseSetting{
    
    self.title = self.title;
    
    //leftNavItem
    UIButton *backBartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBartBtn.frame = CGRectMake(0, 0, 22, 22);
    backBartBtn.hidden = !self.isShowLeftItem;
    [backBartBtn setBackgroundImage:[UIImage imageNamed:@"nav_icon_return"] forState:UIControlStateNormal];
    [backBartBtn addTarget:self action:@selector(clickLeftBarItm) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:backBartBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;

    
//    //rightBarItem
//    UIButton *rightBartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightBartBtn.frame = CGRectMake(0, 0, 22, 22);
//    rightBartBtn.hidden = !self.isShowRightItem;
//    [rightBartBtn setBackgroundImage:[UIImage imageNamed:@"nav_icon_mor"] forState:UIControlStateNormal];
//    [rightBartBtn addTarget:self action:@selector(clickRightBarItm) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightbarItem = [[UIBarButtonItem alloc]initWithCustomView:rightBartBtn];
//    self.navigationItem.rightBarButtonItem = rightbarItem;

    
}



#pragma mark -返回
- (void)clickLeftBarItm{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)clickRightBarItm{
    
}

#pragma mark - ------------------------------------------buildBUI---------------------------------------

#pragma mark  添加tableView
- (UITableView *)addTableView
{
    if (_tableView == nil)
    {
        UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame style:UITableViewStyleGrouped];
        
        tableView.delegate = self;
        tableView.dataSource = self;
        
        // 设置背景
        tableView.backgroundView = nil;
        
        
        //group状态下
        tableView.sectionFooterHeight = 0;
        tableView.sectionHeaderHeight = kCellSectionHeaderH1;
        
        
        // 隐藏分隔线
        
        _tableView = tableView;
    }
    return _tableView;
}




#pragma mark - ---------tableView delegate


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _cellModelArry.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CellGroupItem *group = _cellModelArry[section];
    return group.items.count;
}

#pragma mark 每当有一个cell进入视野范围内就会调用，返回当前这行显示的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建一个ILSettingCell
    BaseSettingTableCell *cell = [BaseSettingTableCell settingCellWithTableView:tableView];
    
    // 2.取出这行对应的模型（ILSettingItem）
    CellGroupItem *group = _cellModelArry[indexPath.section];
    cell.cellitem = group.items[indexPath.row];
    cell.indexPath = indexPath;
    
    return cell;
}

#pragma mark 点击了cell后的操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 去除选中时的背景
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 0.取出这行对应的模型
    CellGroupItem *group = _cellModelArry[indexPath.section];
    BaseCellItem *item = group.items[indexPath.row];
    
    
    // 1.取出这行对应模型中的block代码
    if (item.operation) {
        // 执行block
        item.operation();
        return;
    }
    __weak typeof(self) weakSelf = self;
    // 2.检测有没有要跳转的控制器
    if ([item isKindOfClass:[CellArrowItem class]]) {
        CellArrowItem *arrowItem = (CellArrowItem *)item;
        if (arrowItem.pushVCClass) {
            UIViewController *vc = [[arrowItem.pushVCClass alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }

    }
    
    if ([item isKindOfClass:[CellLabelWithArrowItem class]]) {
        CellLabelWithArrowItem *arrowItem = (CellLabelWithArrowItem *)item;
        if (arrowItem.pushVCClass) {
            UIViewController *vc = [[arrowItem.pushVCClass alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
    if ([item isKindOfClass:[CellImgSubtitleItem class]]) {
//        CellImgSubtitleItem *arrowItem = (CellImgSubtitleItem *)item;
//        if (arrowItem.pushVCClass) {
//            UIViewController *vc = [[arrowItem.pushVCClass alloc] init];
//            [weakSelf.navigationController pushViewController:vc animated:YES];
//        }
    }
    
}

#pragma mark 返回每一组的header标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    CellGroupItem *group = _cellModelArry[section];
    
    return group.header;
}

#pragma mark 返回每一组的footer标题
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    CellGroupItem *group = _cellModelArry[section];
    
    return group.footer;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 0.取出这行对应的模型
    CellGroupItem *group = _cellModelArry[indexPath.section];
    BaseCellItem *item = group.items[indexPath.row];
    
    if ([item isKindOfClass:[CellImgWithArrowItem class]]) {
        return 66;
        
    }else if ([item isKindOfClass:[CellImgSubtitleItem class]]){
        return 72;
        
    }else{
        return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}



@end
