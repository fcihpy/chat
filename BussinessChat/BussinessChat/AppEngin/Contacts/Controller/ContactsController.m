//
//  ContactsController.m
//  bussinessChat
//
//  Created by zhisheshe on 15-3-25.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "ContactsController.h"
#import <AddressBook/AddressBook.h>
#import "AddressBookHelper.h"
#import "AddressModel.h"
#import "AddressCell.h"
#import "ChatViewController.h"
#import "MJRefresh.h"

#import "XmppHelper.h"

#import "ContactsHelper.h"
#import "PersonInfoModel.h"
#import "SuperBaseCell.h"
#import "BaseCellModel.h"
#import "FriendInformationController.h"
@interface ContactsController ()<UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate>
{
    
    NSMutableArray      *_cellModelArry;
    NSString            * _userID;
    BOOL                _isHeadRefresh;
    NSMutableArray      * _rosterListArray;
    NSFetchedResultsController *_resultsContrl;
    
    NSMutableArray             *_friendArr;
}

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation ContactsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //基本设置
    [self baseSetting];
    
    [self loadFriendList];

 
}


- (void)loadFriendList
{
    NSArray *arr = [[XmppHelper sharedInstance]friendsList:^(BOOL isSucceed){
        [self loadFriendList];
    }];
    _friendArr = [NSMutableArray arrayWithArray:arr];
    [self.tableView reloadData];

}

#pragma mark 基本设置
- (void)baseSetting{
    
    self.title = @"联系人";
    [self.view addSubview:self.tableView];
}


- (UITableView *)tableView{
    
    if (_tableView == nil)
    {
        UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
    
        // 设置背景
        tableView.backgroundView = nil;
        _tableView = tableView;
        
        // 隐藏分隔线
    }
    return _tableView;
}

#pragma mark-  -------------------------------------------数据处理-----------------------------------------


#pragma mark - ---------------------XMPP DELEGATE--------------------

#pragma mark 当数据的内容发生改变后，会调用 这个方法
-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    
    //刷新表格
    [_tableView reloadData];
}





#pragma mark - --------------------事件处理-------------
-(void)addFriendButton{
    [[XmppHelper sharedInstance ] agreedtAddFriendRequest:_userID];
}


//添加好友，及接受
-(void)friendRequest:(NSNotification * )notification{
    
    [self showHint:[NSString stringWithFormat:@"%@请求加你为好友",notification.object]];
    _userID = notification.object;
}




#pragma mark - ---------tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return _friendArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    return 10;
}

#pragma mark 每当有一个cell进入视野范围内就会调用，返回当前这行显示的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建一个ILSettingCell
    static NSString *reuse = @"cell";
    
    SuperBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];

    if (!cell) {
        cell = [[SuperBaseCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuse];
    }
    XMPPUserCoreDataStorageObject *friend = [_friendArr objectAtIndex:indexPath.row];
    PersonInfoModel *personInfo = [[PersonInfoModel alloc]initWithVcarJid:friend.jid];
    BaseCellModel *cellModel = [[BaseCellModel alloc]initWithTitle:personInfo.prsonName];
    cellModel.cellType = cellTypeItemImagePhoto;
    cellModel.cellAccessoryView = [[UIView alloc]init];
    cellModel.cellSubTitle = [friend.jidStr componentsSeparatedByString:@"@"][0];
    cellModel.cellContentPhoto = personInfo.personPhoto;
    cell.cellModel = cellModel;

    return cell;
}

#pragma mark 点击了cell后的操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 去除选中时的背景
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    //获取好友
    XMPPUserCoreDataStorageObject *friend = _friendArr[indexPath.row];
    FriendInformationController *frienInfo = [[FriendInformationController alloc]init];
    frienInfo.friendJID = friend.jid.bare;
    [self.navigationController pushViewController:frienInfo animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //要删除好友了
        XMPPUserCoreDataStorageObject *friend = _resultsContrl.fetchedObjects[indexPath.row];
        
        XMPPJID *friendJid = friend.jid;
        [ChatManager deleteMessageID:friend.jidStr];
        [[XmppHelper sharedInstance].rosterModule removeUser:friendJid];
    }
}





@end









