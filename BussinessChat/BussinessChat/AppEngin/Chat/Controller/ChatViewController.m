//
//  ChatViewController.m
//  BussinessChat
//
//  Created by zhisheshe on 15-3-29.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatMessageCell.h"
#import "XMPP.h"

#import "XmppHelper.h"
#import "ChatMessageModel.h"
#import "ChatManager.h"
#import "MessageCell.h"

@interface ChatViewController ()<UITextFieldDelegate,ChatKeyBoardViewDelegate,NSFetchedResultsControllerDelegate,UITextViewDelegate>

{
    NSFetchedResultsController *_resultsContr;
    
}
@property (strong, nonatomic) UITableView       *tableView;
@property (strong, nonatomic) NSMutableArray    *chatRecords;
@property (strong ,nonatomic) ChatKeyBoardView  *toolBarView;

@end

@implementation ChatViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}


- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self baseSetting];
    
    [self loadMessage];
    
    [self loadSubViews];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    // 清除当前聊天人之前未读消息的数
    if ([ChatManager clearNotNumber:self.friendID])
    // 传人当前正在聊天人的ID给XMPP工具类
    [XmppHelper sharedInstance].xmppCurrentChatID = self.friendID;
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [XmppHelper sharedInstance].xmppCurrentChatID = nil;
    NSLog(@"%@",[XmppHelper sharedInstance].xmppCurrentChatID);
}

#pragma mark ------------------------------BaseSetting------------------
- (void)baseSetting{
    
    self.title = self.friendName;
    
    self.view.backgroundColor = COLOR(234, 238, 242, 1);
    
    //leftNavItem
    UIButton *backBartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBartBtn.frame = CGRectMake(0, 0, 22, 22);
    [backBartBtn setBackgroundImage:[UIImage imageNamed:@"nav_icon_return"] forState:UIControlStateNormal];
    [backBartBtn addTarget:self action:@selector(backPrev) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:backBartBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
}

#pragma mark ------------------------------BuildUI------------------

- (void)loadSubViews{
    
    [self.view addSubview:self.tableView];
    
    [self.view addSubview:self.toolBarView];
}

#pragma mark ------------------------------事件处理------------------

-(void)backPrev{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark 发送聊天消息
- (void)sendMessageWithText:(NSString *)text bodyType:(NSString *)bodyType{
    
    XMPPMessage *message = [XMPPMessage messageWithType:@"chat" to:self.friendJid];
    
    //发送回执
    NSXMLElement *receipt = [NSXMLElement elementWithName:@"request" xmlns:@"urn:xmpp:receipts"];
    [message addChild:receipt];
    
    //纯文本
    [message addBody:text];
    
    [[XmppHelper sharedInstance].xmppStream sendElement:message];
}

#pragma mark ----changeKeyBoardFrame

- (void)didChangeFrameToHeight:(CGFloat)toHeight{
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.tableView.frame;
        rect.size.height = toHeight;
        self.tableView.frame = rect;
    }];
    
    [self scrollToTableBottom];
}

#pragma mark 滚动到底部
- (void)scrollToTableBottom{
    
    if (_resultsContr.fetchedObjects.count > 0) {
        NSInteger lastRow = _resultsContr.fetchedObjects.count - 1;
        
        NSIndexPath *lastPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
        
        [self.tableView scrollToRowAtIndexPath:lastPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    
}

#pragma mark -----------------------------数据处理-------------------

#pragma mark - 加载消息列表
- (void)loadMessage{
    
    // 上下文
    NSManagedObjectContext *context = [XmppHelper sharedInstance].msgStorageModule.mainThreadManagedObjectContext;
    
    //请求对象
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"XMPPMessageArchiving_Message_CoreDataObject"];
    
    // 过滤、排序
    // 1.当前登录用户的JID的消息
    // 2.好友的Jid的消息
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"streamBareJidStr = %@ AND bareJidStr = %@",[AccountTools  sharedAccountTools].account.jid,self.friendJid.bare];
    request.predicate = pre;
    
    // 时间升序
    NSSortDescriptor *timeSort = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES];
    request.sortDescriptors = @[timeSort];
    
    // 查询
    _resultsContr = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    
    // 代理
    _resultsContr.delegate = self;
    
    NSError *error = nil;
    [_resultsContr performFetch:&error];
    
    [self scrollToTableBottom];
    
}



#pragma mark   --------- UITableViewDelegate----------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  _resultsContr.fetchedObjects.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    MessageCell *cell = (MessageCell*) [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.messageFrame.cellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    static NSString *ID = @"ChatCell";
//    ChatMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (!cell) {
//        cell = [[ChatMessageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//    }
//    
//    // 获取聊天消息对象
//    XMPPMessageArchiving_Message_CoreDataObject *model =  _resultsContr.fetchedObjects[indexPath.row];
//    cell.model = model;
    
    
    // 判断是图片还是纯文本
    //    NSString *chatType = [msg.message attributeStringValueForName:@"bodyType"];
    //    if ([chatType isEqualToString:@"image"]) {
    //
    //        //下图片显示
    //        [cell.imageView setImageWithURL:[NSURL URLWithString:msg.body] placeholderImage:[UIImage imageNamed:@"DefaultProfileHead_qq"]];
    //        cell.textLabel.text = nil;
    //
    //    }else if([chatType isEqualToString:@"text"]){
    //
    
    
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell)
    {
      cell = [[MessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    }

    XMPPMessageArchiving_Message_CoreDataObject *model =  _resultsContr.fetchedObjects[indexPath.row];
    NSDate *beforeDate = nil;
    if(indexPath.row)
    {
        // 传入上一个Model的时间进行判断
        XMPPMessageArchiving_Message_CoreDataObject *BeforeModel =  _resultsContr.fetchedObjects[indexPath.row-1];
        beforeDate = BeforeModel.timestamp;
    }
   
    [cell setCellModel:model andBeforeDate:beforeDate];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_toolBarView recoverKeyboard];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_toolBarView recoverKeyboard];
}

#pragma mark -------------------ResultController的代理----------------
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    
    // 刷新数据
    [self.tableView reloadData];
    [self scrollToTableBottom];

}




#pragma mark --------------ChatKeyBoardViewDelegate-------------------

- (void)didSendText:(NSString *)text{
    
    //    NSDictionary *messageDic = @{
    //                                 @"file":@"",
    //                                 @"messageType":[NSString stringWithFormat:@"%d",kWCMessageTypePlain],
    //                                 @"text":text
    //                                 };
    //
    //
    //    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:messageDic
    //                                                       options:NSJSONWritingPrettyPrinted
    //                                                       error:nil];
    //
    //    NSString * jsonString = nil;
    //
    //    if (jsonData) {
    //        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    //    }
    //
    //    MyLog(@"%@",self.friendName);
    //
    //    XMPPMessage *msg=[XMPPMessage messageWithType:@"chat" to:[XMPPJID jidWithUser:self.friendID domain:@"admin" resource:@"ios"]];
    //
    //    //发送回执
    //    NSXMLElement *receipt = [NSXMLElement elementWithName:@"request" xmlns:@"urn:xmpp:receipts"];
    //    [msg addChild:receipt];
    //
    //    [msg addChild:[DDXMLNode elementWithName:@"body" stringValue:jsonString]];
    
    //发送消息
    //    [[XmppHelper sharedInstance] sendMessage:msg];
    
    [self sendMessageWithText:text bodyType:@"text"];
    [self scrollToTableBottom];
}


#pragma mark TextView的代理
- (void)textViewDidChange:(UITextView *)textView{
    
    // 换行就等于点击了的send
    if ([textView.text rangeOfString:@"\n"].length != 0) {
        
        [self sendMessageWithText:textView.text bodyType:@"text"];
        
        //清空数据
        textView.text = nil;
    }else{
        
        MyLog(@"textView -- %@",textView.text);
    }
    
}




#pragma mark - ---------------------getter/setter---------------------

- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc ] initWithFrame:CGRectMake(0, 0, screenW , screenH -64 -46) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = COLOR(234, 238, 242, 1);
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    
    return _tableView;
}

-(ChatKeyBoardView *)toolBarView{
    if (_toolBarView == nil) {
        _toolBarView = [[ChatKeyBoardView alloc]initWithFrame:CGRectMake(0, screenH - 64-[ChatKeyBoardView toolBarHeight], screenW, [ChatKeyBoardView toolBarHeight]) andSuperVC:self];
        _toolBarView.layer.borderWidth = 0.5;
        _toolBarView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _toolBarView.delegate = self;
    }
    return _toolBarView;
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
@end
