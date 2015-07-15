//
//  ChatController.m
//  bussinessChat
//
//  Created by zhisheshe on 15-3-25.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "ChatListController.h"
#import "ChatListViewCell.h"

#import "BaseViewController.h"
#import "MineController.h"
#import "ChatMessageController.h"
#import "ChatViewController.h"
#import "AddFriendCoverView.h"
#import "AddFriendViewController.h"
#import "AppDelegate.h"

#import "SuperBaseCell.h"
#import "BaseCellModel.h"
#import "PersonInfoModel.h"
@interface ChatListController()<NSFetchedResultsControllerDelegate>
{
    NSFetchedResultsController *_resultsContr;

    UIView              *_networkStateView;         //网络状态指示器
    
    UIWindow            *_keyWindow;
    AddFriendCoverView  *_addFriendCover;
    NSArray             *_dataArr;
    UIButton            *_notNumber;
    UIView              *_addFriendBaseView;
    UIButton            *_agreedtFriendBtn;
    UIButton            *_rejectFriendBtn;
    NSString            *_addFriendJid;
}


@property (retain, nonatomic)  UIActivityIndicatorView *indicatorView;

@end

@implementation ChatListController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //基本设置
    [self baseSetting];
    
    [self loadData];

    //加载网络状态
    [self networkStateView];
    
    [self.view addSubview:_indicatorView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTableView) name:@"ChatList" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStatusChange:) name:LoginStatusChangeNotification object:nil];
    
    

    
}

#pragma mark --------------------------------------------基本设置-----------------------------------------------

#pragma mark 基本设置
- (void)baseSetting{
    
    [super baseSetting];
    
    self.title = @"聊天";
    self.isShowLeftItem = NO;
    self.isShowRightItem = YES;
    
    
}

- (void)loadData
{
    _dataArr = [ChatManager fetchRecentChatByPage:10];
    NSLog(@"%ld",[XmppHelper sharedInstance].subscribeArray.count);
    [self.tableView reloadData];
   
}


#pragma mark -加载网络状态
- (UIView *)networkStateView{
    
    if (_networkStateView == nil) {
        _networkStateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        _networkStateView.backgroundColor = kAlertColor;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (_networkStateView.frame.size.height - 20) / 2, 20, 20)];
        imageView.image = [UIImage imageNamed:@"netAlert"];
        [_networkStateView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 5, 0, _networkStateView.frame.size.width - (CGRectGetMaxX(imageView.frame) + 15), _networkStateView.frame.size.height)];
        label.font = kFont13;
        label.textColor = kValueColor;
        label.backgroundColor = kClearColor;
        label.text = @"当前网络不可用,请检查你的网络设置";
        [_networkStateView addSubview:label];
    }
    
    return _networkStateView;
}

#pragma mark ---------------------------事件处理--------------------------

- (void)clickRightBarItm{

    if (_addFriendCover == nil) {
        
        _keyWindow = [UIApplication sharedApplication].keyWindow;
        _addFriendCover = [[AddFriendCoverView alloc ] initWithFrame:_keyWindow.frame delegate:self window:_keyWindow];
        [self.view addSubview:_addFriendCover];
    }
}


- (void)addFriends{
    
    AddFriendViewController * addFriend = [[AddFriendViewController alloc ] init];
    UINavigationController * nav = [[UINavigationController alloc ] initWithRootViewController:addFriend];
    [self presentViewController:nav animated:YES completion:nil];
    [self viewHidden];
}

-(void)loginStatusChange:(NSNotification *)noti{
    
    //通知是在子线程被调用，刷新UI在主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        MyLog(@"aaaaaaa--%@",noti.userInfo);
        // 获取登录状态
        int status = [noti.userInfo[@"loginStatus"] intValue];
        
        switch (status) {
            case XMPPResultTypeConnecting://正在连接
                [self.indicatorView startAnimating];
                break;
            case XMPPResultTypeNetErr://连接失败
                [self.indicatorView stopAnimating];
                break;
            case XMPPResultTypeLoginSuccess://登录成功也就是连接成功
                [self.indicatorView stopAnimating];
                break;
            case XMPPResultTypeLoginFailure://登录失败
                [self.indicatorView stopAnimating];
                break;
            default:
                break;
        }
    });
    
}

- (void)viewHidden{
    
    [_addFriendCover removeFromSuperview];
    _addFriendCover = nil;
}



#pragma mark - -----------------Table view data source------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ChatListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell)
    {
        cell = [ChatListViewCell cellShow];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ChatMessageModel *model = [_dataArr objectAtIndex:indexPath.row];
    cell.chatModel = model;
    
    return cell;
}


#pragma  mark  heightForRow
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

#pragma  mark  didSelectRow
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatMessageModel *model = [_dataArr objectAtIndex:indexPath.row];
    ChatViewController *chatView = [[ChatViewController alloc]init];
    chatView.friendJid = [XMPPJID jidWithString:model.messageFrom];
    chatView.friendID =  model.messageFrom;
    chatView.friendName = [model.messageFrom componentsSeparatedByString:@"@"][0];
    [self.navigationController pushViewController:chatView animated:YES];

}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
   if(editingStyle == UITableViewCellEditingStyleDelete)
   {
       ChatMessageModel *model = [_dataArr objectAtIndex:indexPath.row];
        NSLog(@"%@",model.messageFrom);
       if([ChatManager deleteMessageID:model.messageFrom])
       {
           NSLog(@"删除成功");
       }
       else
       {
           NSLog(@"不成功");
       }
       [self loadData];
   }
}
- (void)updateTableView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self loadData];
    });
   
}

- (void)viewWillAppear:(BOOL)animated
{
    [self loadData];
}

@end
