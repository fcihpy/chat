//
//  BaseViewWithTableViewController.m
//  bussinessChat
//
//  Created by zhisheshe on 15-3-25.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "BaseSettingTableCell.h"
#import "CellGroupItem.h"
#import "BaseCellItem.h"
#import "CellArrowItem.h"
#import "CellLabelWithArrowItem.h"
#import "CellImgWithArrowItem.h"

#import "BaseViewWithTableViewController.h"

const int kCellSectionHeaderH = 20;

@implementation BaseViewWithTableViewController

- (void)loadView{
    
    [super loadView];
    
    _cellModelArry = [NSMutableArray array];
    
}


-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    //基本设置
    [self baseSetting];


    //添加tableView
//    [self addTableView];
    [self.view addSubview:_tableView];
    
    //添加刷新控件
    [self addRefresh];
   
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


#pragma mark - ------------------------------------------buildBUI---------------------------------------

#pragma mark  添加tableView
- (UITableView *)tableView{
    
    if (_tableView == nil)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenH- 64) style:UITableViewStylePlain];
        
        //  _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    
    return _tableView;

}

#pragma mark 添加刷新控件
- (void)addRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(CarResourceHeaderRereshing)];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(CarResourceFooterRereshing)];
    
    [self.tableView headerBeginRefreshing];
    
}


#pragma mark-  -------------------------------------------数据处理-----------------------------------------
#pragma mark 开始进入刷新状态
- (void)CarResourceHeaderRereshing
{
    [self showHudInView:self.view hint:@"正在进行数据刷新....."];
    _isHeadRefresh = YES;
    
    self.page = 1;
    [self refreshBeginRefreshing];
    
    [self.tableView setFooterHidden:NO];
}

#pragma mark  - 上拉加载
- (void)CarResourceFooterRereshing
{
    
    _isHeadRefresh = NO;
    self.page ++;
    [self refreshBeginRefreshing];
    
}

#pragma mark - 网络请求

#pragma mark 网络数据处理
- (void)refreshBeginRefreshing{
    
//    [CarResourceTool filter:self.searchCarParameterDict Page:self.page filterSuccess:^(NSMutableArray *CarResourceModelArry, int totalCount) {
//        
//        if (_isHeadRefresh == YES) {  // 下拉刷新
//            //赋值数据
//            self.cellModelArry = [NSMutableArray array];
//        }
//        
//        // 1.添加数据
//        [self.cellModelArry addObjectsFromArray:CarResourceModelArry];
//        
//        // 2.刷新表格
//        [self.tableView reloadData];
//        
//        //3.恢复刷新状态
//        if (_isHeadRefresh == YES) {
//            //恢复头部刷新状态
//            [self.tableView headerEndRefreshing];
//        }else{
//            //刷新尾部状态
//            [self.tableView footerEndRefreshing];
//        }
//        
//        // 4.根据数量判断是否需要隐藏上拉控件
//        if (self.cellModelArry.count >= totalCount) {
//            [self.tableView setFooterHidden:YES];
//            [self showHint:@"已经是最后一页了"];
//        }
//        
//        //显示搜索车辆总数
//        self.totalCount = totalCount;
//        
//    } failure:^(NSError *error) {
//        
//        
//    }];
//    
//
    [self.tableView headerEndRefreshing];
    [self hideHud];
}



#pragma mark - 事件处理

- (void)clickLeftBarItm{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)clickRightBarItm{
    
    
}


#pragma mark - ---------tableView delegate


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    CellGroupItem *group = _cellModelArry[section];
    return _cellModelArry.count;
}

#pragma mark 每当有一个cell进入视野范围内就会调用，返回当前这行显示的cell
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // 1.创建一个ILSettingCell
//    BaseSettingTableCell *cell = [BaseSettingTableCell settingCellWithTableView:tableView];
//    
//    // 2.取出这行对应的模型（ILSettingItem）
//    CellGroupItem *group = _cellModelArry[indexPath.section];
//    cell.cellitem = group.items[indexPath.row];
//    cell.indexPath = indexPath;
//    
//    return cell;
//}

#pragma mark 点击了cell后的操作
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // 去除选中时的背景
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    // 0.取出这行对应的模型
//    CellGroupItem *group = _cellModelArry[indexPath.section];
//    BaseCellItem *item = group.items[indexPath.row];
//    
//    // 1.取出这行对应模型中的block代码
//    if (item.operation) {
//        // 执行block
//        item.operation();
//        return;
//    }
//    
//    // 2.检测有没有要跳转的控制器
//    if ([item isKindOfClass:[CellArrowItem class]]) {
//        CellArrowItem *arrowItem = (CellArrowItem *)item;
//        if (arrowItem.pushVCClass) {
//             UIViewController *vc = [[arrowItem.pushVCClass alloc] init];
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//    }
//    
//    if ([item isKindOfClass:[CellLabelWithArrowItem class]]) {
//        CellLabelWithArrowItem *arrowItem = (CellLabelWithArrowItem *)item;
//        if (arrowItem.pushVCClass) {
//            UIViewController *vc = [[arrowItem.pushVCClass alloc] init];
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//    }
//    
//}

#pragma mark 返回每一组的header标题
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    CellGroupItem *group = _cellModelArry[section];
//    
//    return group.header;
//}
//
//#pragma mark 返回每一组的footer标题
//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
//{
//    CellGroupItem *group = _cellModelArry[section];
//    
//    return group.footer;
//}
//
//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    // 0.取出这行对应的模型
//    CellGroupItem *group = _cellModelArry[indexPath.section];
//    BaseCellItem *item = group.items[indexPath.row];
//    
//    if ([item isKindOfClass:[CellImgWithArrowItem class]]) {
//        return 66;
//    }else{
//        return 44;
//    }
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 10;
//}



//#pragma mark - -----------------Table view data source------------------
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    
//    return _cellModelArry.count;
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *reuse = @"cell";
//    
//    BOOL nibsRegistered = NO;
//    if (!nibsRegistered) {
//        //        UINib *nib = [UINib nibWithNibName:[ChatListViewCell loadNib] bundle:nil];
//        [tableView registerNib:[ChatListViewCell loadNib] forCellReuseIdentifier:reuse];
//        nibsRegistered = YES;
//    }
//    
//    ChatListViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:reuse];
//    
//    cell.messageListModel = _cellModelArry[indexPath.row];
//    
//    return cell;
//}
//
//
//
//
//#pragma  mark  heightForRow
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 62;
//    
//}


@end
