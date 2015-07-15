//
//  FriendInformationController.m
//  BussinessChat
//
//  Created by 郑南 on 15-7-9.
//  Copyright (c) 2015年 firstChedai. All rights reserved.
//

#import "FriendInformationController.h"
#import "PersonInfoModel.h"
#import "BaseCellModel.h"
#import "SuperBaseCell.h"
#import "ChatViewController.h"
#import "ChatListController.h"
@interface FriendInformationController ()<UITableViewDataSource,UITableViewDelegate>
{
    PersonInfoModel *_personInfo;
    NSMutableArray *_cellModelArray;
    
}

@property (nonatomic,strong) UITableView *tableView;
@end

@implementation FriendInformationController
- (void)viewDidLoad {
    
    [super viewDidLoad];
    _personInfo = [[PersonInfoModel alloc]initWithVcarJid:[XMPPJID jidWithString:_friendJID]];
    [self baseSetting];
    [self loadTabelViewData];
    [self.view addSubview:self.tableView];
    
}

- (void)baseSetting
{
    self.title = @"详细资料";
    self.view.backgroundColor = COLOR(234, 238, 242, 1);
    
    //leftNavItem
    UIButton *backBartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBartBtn.frame = CGRectMake(0, 0, 22, 22);
    [backBartBtn setBackgroundImage:[UIImage imageNamed:@"nav_icon_return"] forState:UIControlStateNormal];
    [backBartBtn addTarget:self action:@selector(backPrev) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:backBartBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;

}

- (void)backPrev
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadTabelViewData
{
    _cellModelArray = [[NSMutableArray alloc]init];
    for (int i=0; i<3; i++) {
        BaseCellModel *cellModel = [[BaseCellModel alloc]init];
        cellModel.cellAccessoryView = [[UIView alloc]init];
        if(i==0)
        {
            cellModel.cellType = cellTypeItemImagePhoto;
            cellModel.cellContentPhoto = _personInfo.personPhoto;
            cellModel.cellTitle =[NSString stringWithFormat:@"昵称：%@", _personInfo.prsonName];
            cellModel.cellSubTitle = _personInfo.prsonPhone;
        }
        else if(i==1)
        {
            cellModel.cellType = cellTypeItemLabel;
            cellModel.cellTitle = @"地区:";
            if([_personInfo.prsonFamilyAddresses isEqualToString:@""])
            {
              cellModel.cellContent = @"他在一个比较神秘的地方";
            }
            else{
              cellModel.cellContent = _personInfo.prsonFamilyAddresses;
            }
            
        }
        else if (i==2)
        {
            cellModel.cellType = cellTypeItemLabel;
            cellModel.cellTitle = @"个性签名:";
            if([_personInfo.prsonTitle isEqualToString:@""]||_personInfo.prsonTitle ==nil)
            {
                cellModel.cellContent = @"他太懒了，什么都没写";
            }
            else
            {
                cellModel.cellContent = _personInfo.prsonTitle;
            }
        }
        [_cellModelArray addObject:cellModel];
    }
    UIButton *chatBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 15, screenW - 40, 30)];
    [chatBtn setTitle:@"发消息" forState:UIControlStateNormal];
    [chatBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [chatBtn setBackgroundColor:[UIColor greenColor]];
    [chatBtn addTarget:self action:@selector(openChat) forControlEvents:UIControlEventTouchUpInside];
    [_cellModelArray addObject:chatBtn];
}

- (void)openChat
{
    ChatViewController *chatView = [[ChatViewController alloc]init];
    chatView.friendJid = [XMPPJID jidWithString:self.friendJID];
    chatView.friendID =  self.friendJID;
    chatView.friendName = [self.friendJID componentsSeparatedByString:@"@"][0];
    
    [self.navigationController pushViewController:chatView animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cellModelArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row ==0)
    {
        return 80;
    }
    else if (indexPath.row ==3)
    {
        return 60;
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SuperBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell)
    {
        cell = [[SuperBaseCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    if(indexPath.row == 3)
    {
        UIButton *btn = [_cellModelArray objectAtIndex:indexPath.row];
        [cell.contentView addSubview:btn];
    }
    else
    {
        cell.cellModel = [_cellModelArray objectAtIndex:indexPath.row];

    }
    
    return cell;

}

#pragma mark - ---------------------getter/setter---------------------

- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc ] initWithFrame:CGRectMake(0, 0, screenW , screenH -64 -46) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = COLOR(234, 238, 242, 1);
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}



@end
