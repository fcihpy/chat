//
//  FriendCircleContrller.m
//  BussinessChat
//
//  Created by zhisheshe on 15-4-9.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "FriendCircleContrller.h"
#import "FriendCircleCell.h"
#import "FriendCircleCellFrameModel.h"
#import "FriendCircleModel.h"


@interface FriendCircleContrller()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    UIImageView *_headImgView;
}

@property(nonatomic,strong) NSMutableArray *cellModelArry;

@end

@implementation FriendCircleContrller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //基本设置
    [self baseSetting];
    
    [self addHeadImg];
//    [self addItemGroup1];
//    
//    [self addItemGroup2];
    [self loadModelData];
    
    //添加tableView
    [self addTableView];
    [self.view addSubview:_tableView];
}

#pragma mark --------------------------------------------基本设置-----------------------------------------------
#pragma mark 基本设置
- (void)baseSetting{
    
    self.title = @"朋友圈";
    
    self.view.backgroundColor = kGlobalBg;
    
    //leftNavItem
    UIButton *backBartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBartBtn.frame = CGRectMake(0, 0, 22, 22);
    [backBartBtn setBackgroundImage:[UIImage imageNamed:@"nav_icon_return"] forState:UIControlStateNormal];
    [backBartBtn addTarget:self action:@selector(backPrev) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:backBartBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    
    //rightBarItem
    
    UIButton *addBartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBartBtn.frame = CGRectMake(0, 0, 22, 22);
    [addBartBtn setBackgroundImage:[UIImage imageNamed:@"discover_friendCircle_carmera"] forState:UIControlStateNormal];
    [addBartBtn addTarget:self action:@selector(moreInfo) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightbarItem = [[UIBarButtonItem alloc]initWithCustomView:addBartBtn];
    self.navigationItem.rightBarButtonItem = rightbarItem;
    
}

#pragma mark - ---------------------------------buildUI--------------------------

- (void)addHeadImg{
    
    _headImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"discover_friendCircle_headico"]];
    [self.view addSubview:_headImgView];
}

#pragma mark  添加tableView
- (UITableView *)addTableView
{
    if (_tableView == nil)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_headImgView.frame), screenW, screenH - 64- 190) style:UITableViewStylePlain];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = kGlobalBg;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}

- (void)loadModelData{
    _cellModelArry = [NSMutableArray array];
    
    FriendCircleModel *model1 = [[FriendCircleModel alloc]init];
    model1.username = @"张三";
    model1.content = @"社会义好啊社会义好啊社会义好啊社会义好啊社会义好啊社会义好啊社会义好啊社会义好啊社会义好啊社会义好啊社会义好啊社会义好啊社会义好啊社会义好啊社会义好啊社会义好啊社会义好啊社会义好啊社会义好啊社会义好啊社会义好啊社会义好啊";
    model1.publishTime = @"10分钟前";
    FriendCircleCellFrameModel *cmodel1 = [[FriendCircleCellFrameModel alloc]init];
    cmodel1.cellModel = model1;
    
    FriendCircleModel *model2 = [[FriendCircleModel alloc]init];
    model2.username = @"李四";
    model2.content = @"这是真的这是真的这是真的这是真的这真的";
    model2.publishTime = @"2天前";
    FriendCircleCellFrameModel *cmodel2 = [[FriendCircleCellFrameModel alloc]init];
    cmodel2.cellModel = model2;
    
    [_cellModelArry addObject:cmodel1];
    [_cellModelArry addObject:cmodel2];
    
    [_tableView reloadData];
}


#pragma mark - -------------------------事件处理---------------
- (void)backPrev{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)moreInfo{
    UIViewController *view1 = [[UIViewController alloc]init];
    view1.view.backgroundColor = [UIColor greenColor];
    UIPopoverController *popover = [[UIPopoverController alloc]initWithContentViewController:view1];
    popover.popoverContentSize = CGSizeMake(320, 400);
    [popover presentPopoverFromRect:self.view.bounds inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

#pragma mark - ---------------------------------------Table view data source------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _cellModelArry.count;
}

#pragma mark 每当有一个cell进入视野范围内就会调用，返回当前这行显示的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建一个ILSettingCell
    FriendCircleCell *cell = [FriendCircleCell settingCellWithTableView:tableView];

//    cell.backgroundColor = [UIColor yellowColor];
    cell.CellFrameModel = _cellModelArry[indexPath.row];

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return [self.cellModelArry[indexPath.row] cellHeight];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
