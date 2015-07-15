//
//  SuperBaseTableView.m
//  BussinessChat
//
//  Created by 郑南 on 15-7-7.
//  Copyright (c) 2015年 firstChedai. All rights reserved.
//

#import "SuperBaseTableView.h"
#import "SuperBaseCell.h"
#import "EditPersonInfoController.h"
@interface SuperBaseTableView ()
{
    NSMutableArray *_cellModelArry;
}

@end

@implementation SuperBaseTableView

- (void)viewDidLoad {
    
    [super viewDidLoad];
    _cellModelArry = [[NSMutableArray alloc]init];
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
    backBartBtn.hidden = self.isShowLeftItem;
    [backBartBtn setBackgroundImage:[UIImage imageNamed:@"nav_icon_return"] forState:UIControlStateNormal];
    [backBartBtn addTarget:self action:@selector(clickLeftBarItm) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:backBartBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
}

- (void)clickLeftBarItm
{
    [self.navigationController popViewControllerAnimated:YES];
}

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
        tableView.sectionHeaderHeight = 5;
        
        // 隐藏分隔线
        _tableView = tableView;
        
    }
    return _tableView;
}

- (void)baseTableViewAddCellElementGroup:(BaseCellGroup *)cellGroup
{
    [_cellModelArry addObject:cellGroup];
}

- (void)baseTableViewRevampCellElementTitle:(NSString *)elementTitle andElementValue:(id)elementValue
{
    for (int groupI = 0; groupI< _cellModelArry.count; groupI++)
    {
        BaseCellGroup *group = [_cellModelArry objectAtIndex:groupI];
        for (int subGroupI = 0; subGroupI< group.groupMemberArray.count; subGroupI ++)
        {
            BaseCellModel *cellModel = [group.groupMemberArray objectAtIndex:subGroupI];
            if ([elementTitle isEqualToString:cellModel.cellTitle])
            {
                switch (cellModel.cellType) {
                    case cellTypeItemImageIcno:
                        cellModel.cellContentIcon = elementValue;
                        break;
                        
                    case cellTypeItemImagePhoto:
                        cellModel.cellContentPhoto = elementValue;
                        break;
                        
                    case cellTypeItemLabel:
                        cellModel.cellContent = elementValue;
                        break;
                        
                    default:
                        break;
                }
                NSIndexPath *path = [NSIndexPath indexPathForRow:subGroupI inSection:groupI];
                [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
                break;
            }
        }
    }
}

#pragma mark  ---------------------tableView代理------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _cellModelArry.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BaseCellGroup *group = [_cellModelArry objectAtIndex:section];
    return group.groupMemberArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SuperBaseCell *cell = [[SuperBaseCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    BaseCellGroup *group = [_cellModelArry objectAtIndex:indexPath.section];
    cell.cellModel = [group.groupMemberArray objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseCellGroup *group = [_cellModelArry objectAtIndex:indexPath.section];
    BaseCellModel *cellModel = [group.groupMemberArray objectAtIndex:indexPath.row];
    SuperBaseCell *cell = (id)[tableView cellForRowAtIndexPath:indexPath];
    if(cellModel.cellPustVC!=nil)
    {
        if([cellModel.cellPustVC isKindOfClass:[EditPersonInfoController class]])
        {
            EditPersonInfoController *edit =(id) cellModel.cellPustVC;
            edit.editText = cell.cellCotentLabel;
        }
        [self.navigationController pushViewController:cellModel.cellPustVC animated:YES];
        return ;
    }
    if(cellModel.cellClick)
    {
        cellModel.cellClick();
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    BaseCellGroup *group = [_cellModelArry objectAtIndex:section];
    return group.groupHeadTitle;
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    BaseCellGroup *group = [_cellModelArry objectAtIndex:section];
    return group.groupFootTitle;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseCellGroup *group = [_cellModelArry objectAtIndex:indexPath.section];
    BaseCellModel *cellModel = [group.groupMemberArray objectAtIndex:indexPath.row];
    
    switch (cellModel.cellType)
    {
        case cellTypeItemLabel:
            return 44;
            break;
            
        case cellTypeItemImageIcno:
            
            return 60;
            break;
            
        case cellTypeItemImagePhoto:
            
            return 70;
            break;
        default:
            break;
    }
   
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}



@end
