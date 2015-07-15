//
//  XmppHelper.m
//  BusinessTalk
//
//  Created by WQY on 15-3-13.
//  Copyright (c) 2015年 WQY. All rights reserved.
//

#import "XmppHelper.h"
#import "LoginController.h"

NSString *const LoginStatusChangeNotification = @"LoginStatusChangeNotification";

/**
 
 1、登录流程：
 1.1、初始化xmppStream
 1.2、传一个Jid连接到服务器
 1.3、连接服务器成功后，再发送密码授权
 1.4、授权成功后，发送“在线”消息
 
 
 2、注销流程
 // 2.1. 发送 "离线" 消息"
 // 2.2. 与服务器断开连接
 // 2.3. 回到登录界面
 // 2.4. 更新用户的登录状态
 
 
 */


@interface XmppHelper ()<XMPPStreamDelegate>
{
    
    NSArray *_buddylistArry;
    //    NSError *_loginSuccStatus;
    //    NSError *_loginFailStatus;
    NSString                        *_loginName;
    NSString                        *_loginPwd;
    
    NSString                        *_registerName;
    NSString                        *_registerPwd;
    
    XMPPResultBlock                 _resultBlock;
    XMPPReconnect                   *_reconnectModule;         //自动连接模块
    XMPPvCardCoreDataStorage        *_vCardstorageModule;      //电子名片的数据存储
    XMPPMessageArchiving            *_msgArchModule;           //聊天模块
    
    
    
    
}

#pragma mark ----------------- 1、登录流程---------------
//1.1初始化XMPPStream
- (void)SetupXMPPStream;

//1.2连接到服务器
- (void)connectToServer;

//1.3连接服务器成功后，再发送密码进行验证
- (void)sendPwdTOServer;

//1.4验证成功后，发送“在线”消息
- (void)sendOnlindToServer;





@end
@implementation XmppHelper


static XmppHelper *sharedManager;

+ (XmppHelper *)allocWithZone:(struct _NSZone *)zone{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager=[super allocWithZone:zone];
        // [DDLog addLogger:[DDTTYLogger sharedInstance]];
    });
    
    return sharedManager;
}

+(XmppHelper*)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedManager=[[self alloc]init];
        
    });

    return sharedManager;
}

#
//--------------------------------------------------------------------------------------------------------------

#pragma mark ----------------------------------XMPPStream的代理-----------------------------

#pragma mark 与主机连接成功
- (void)xmppStreamDidConnect:(XMPPStream *)sender{
    
    MyLog(@"与服务器连接成功");
    
    //判断是登录，还是注册
    if (self.isRegisterOperation) {   //注册操作，发送注册的密码
#warning regiser
        NSString *pwd = _registerPwd;
        [_xmppStream registerWithPassword:pwd error:nil];
        
    }else{//登录操作
        
        // 主机连接成功后，发送密码进行授权
        [self sendPwdTOServer];
    }
    
}

#pragma mark  与主机断开连接
- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error{
    
    // 如果有错误，代表连接失败
    
    // 如果没有错误，表示正常的断开连接(人为断开连接)
    
    if (error && _resultBlock) {
        _resultBlock(XMPPResultTypeNetErr);
    }
    
    if (error) {
        
        //  [self postNotification:XMPPResultTypeNetErr];
        FCAlert(@"网络连接失败");
    }
    
}


#pragma mark 注册成功
- (void)xmppStreamDidRegister:(XMPPStream *)sender{
    MyLog(@"注册成功");
    
    if (_resultBlock) {
        _resultBlock(XMPPResultTypeRegisterSuccess);
    }
    
    //注册成功后，将用户名和密码保存起来
    Account *account = [[Account alloc]init];
    account.loginName = _registerName;
    account.loginPasswd = _registerPwd;
    [[AccountTools sharedAccountTools] saveAccount:account];
    
}

#pragma mark 注册失败
-(void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error{
    
    MyLog(@"注册失败");
    
    if (_resultBlock) {
        _resultBlock(XMPPResultTypeRegisterFailure);
    }
}

#pragma mark 认证授权成功
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    MyLog(@"认证授权成功");
    
    //发送在线消息
    [self sendOnlindToServer];
    
    
    //回调登录控制器
    if (_resultBlock) {
        _resultBlock(XMPPResultTypeLoginSuccess);
    }
    
    //发送认证状态（认证成功）
    [self postNotification:XMPPResultTypeLoginSuccess];
    
    //授权成功后，保存用户名、密码到单例中
    Account *account = [[Account alloc]init];
    account.loginName = _loginName;
    account.loginPasswd = _loginPwd;
    [[AccountTools sharedAccountTools] saveAccount:account];
}

#pragma mark 认证授权失败
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error{
    
    MyLog(@"认证授权失败");
    
    //回调登录控制器
    if (_resultBlock) {
        _resultBlock(XMPPResultTypeLoginFailure);
    }
    
    //发送通知状态（认证失败）
    //    [self postNotification:XMPPResultTypeLoginFailure];
}


- (void)xmppStreamDidSecure:(XMPPStream *)sender{
    
    
}


#pragma mark 接收到好友消息
- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message{
    
 
    /*
     如果程序不在前台，发送一个本地通知,注册IOS7\8的区别
     
     IOS7 直接发送通知
     
     IOS8需要先注册，在appdelegate中 如果需要挂起时，也能接收到通知 ，需在plist加请求操作。同时在socket程序中启用后台服务
     
     需要需要在程序没运行时，也能收到离线消息，则需要启用推送通知
     
     推送服务器一般是json数据，{"aps":{'alert':"zhangsan\n have dinner":'sound':'default',badge:'12'}}
     
     */
    
    
    [self sendMessage:message];
    
    //如果当前程序不在前台，发出一个本地通知
    if([UIApplication sharedApplication].applicationState != UIApplicationStateActive){
        MyLog(@"进入在后台了");
        
        //本地通知
        UILocalNotification *localNoti = [[UILocalNotification alloc] init];
        
        // 设置内容
        localNoti.alertBody = [NSString stringWithFormat:@"您有一条新的消息:%@\n%@",message.fromStr,message.body];
        
        // 设置通知执行时间
        localNoti.fireDate = [NSDate date];
        
        //声音
        localNoti.soundName = @"default";
        
        //执行
        [[UIApplication sharedApplication] scheduleLocalNotification:localNoti];
        
    }
}

#pragma mark 发送聊天消息
- (void)xmppStream:(XMPPStream *)sender didSendMessage:(XMPPMessage *)message
{
    [self sendMessage:message];
  
}

- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence
{
    NSString *presenceType = [presence type];
    
    NSLog(@"好友状态更新   user--%@   type---%@  status--%@ ",[[presence from] user],presenceType,[presence status]);
//    XMPPJID *jid = [XMPPJID jidWithUser:[presence from].user domain:XMPP_DOMAIN resource:@"ios"];
    if ([presenceType isEqualToString:@"subscribe"])
    {
        if (self.subscribeArray.count==0)
        {
            [self.subscribeArray addObject:presence];
        }else
        {
            BOOL isExist=NO;
            for (XMPPPresence*pre in self.subscribeArray)
            {
                if ([pre.from.user isEqualToString:presence.from.user])
                {
                    isExist=YES;
                }
            }
            if (!isExist)
            {
                [self.subscribeArray addObject:presence];
            }
        }
    }
    if (self.friendType) {
        self.friendType(YES);
    }

}

#pragma mark 别人是否同意好友请求,以及上线下线更新
- (void)xmppRoster:(XMPPRoster *)sender didReceivePresenceSubscriptionRequest:(XMPPPresence *)presence{
    
    NSString *presenceType = [NSString stringWithFormat:@"%@", [presence type]];
    XMPPJID *jid = [XMPPJID jidWithUser:[presence from].user domain:XMPP_DOMAIN resource:@"ios"];
    
    if ([presenceType isEqualToString:@"unsubscribed"]) {
        
        [_rosterModule rejectPresenceSubscriptionRequestFrom:jid];//拒绝
    }
    
    if ([presenceType isEqualToString:@"subscribed"]) {
        
        [_rosterModule acceptPresenceSubscriptionRequestFrom:jid andAddToRoster:YES];//同意
    }
    
    
}

#pragma mark - ------------------------- 1、添加好友、删除好友流程 ---------------

#pragma mark 是否是好友
- (BOOL)isFriend:(NSString *)uid{
    
    NSManagedObjectContext *context = [_rosterStorageModule mainThreadManagedObjectContext];
    
    //请求数据
    // 2.FetchRequest【查哪张表】
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"XMPPUserCoreDataStorageObject"];
    
    
    // 3.设置过滤和排序
    // 过滤当前登录用户的好友
    NSEntityDescription*entity=[NSEntityDescription entityForName:@"XMPPUserCoreDataStorageObject" inManagedObjectContext:context];
    
//    NSString *currenjid = [AccountTools sharedAccountTools].account.jid;
//    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"streamBareJidStr = %@",currenjid];
//    
//    request.predicate = predicate;
    request.entity = entity;
    
    NSError *error = nil;
    
    NSArray*friends=[context executeFetchRequest:request error:&error];//从数据库中取出数据
    
    //friends每个元素是 XMPPUserCoreDataStorageObject
    
    BOOL isSucceed=NO;
    
    for (XMPPUserCoreDataStorageObject*object in friends) {
        
        //  object.jid.user  只有账号，没有后面的@1000phone.net
        //object.jidStr 是完整的一个账号，带@1000phone.net
        
        if ([object.jidStr isEqualToString:uid]) {
            isSucceed=YES;
        }
    }
    return isSucceed;
}

#pragma mark - 添加、删除好友----------
#pragma mark 添加好友
- (void)addFriendWithJidStr:(NSString *)jidStr{

    //判断这个账号是否为手机号码
    if (![jidStr isValidateMobile] ) {
        FCAlert(@"请输入正确的手机号");
        return;
    }
    
    //判断是否是加自己
    if ([jidStr isEqualToString:[AccountTools sharedAccountTools].account.loginName]) {
        
        FCAlert(@"不能添加自己");
        return;
    }
    
    //组装JID
    XMPPJID *friendJid = [XMPPJID jidWithString:[NSString stringWithFormat:@"%@@%@",jidStr,XMPP_DOMAIN]];
    
    //判断好友是否已经存在
    if ([[XmppHelper sharedInstance].rosterStorageModule userExistsWithJID:friendJid xmppStream:_xmppStream]) {
        
        FCAlert(@"当前好友已经存在");
        return;
        
    }
    // 2.发送好友添加的请求， xmpp中添加好友,叫订阅
    [[XmppHelper sharedInstance].rosterModule subscribePresenceToUser:friendJid];
    
    FCAlert(@"添加成功");

    
}


#pragma mark 同意好友添加请求
- (void)agreedtAddFriendRequest:(NSString *)friendJidStr{
    
    //组装JID
    XMPPJID *friendJid = [XMPPJID jidWithUser:friendJidStr domain:XMPP_DOMAIN resource:@"ios"];
    [_rosterModule acceptPresenceSubscriptionRequestFrom:friendJid andAddToRoster:YES];
    
    XMPPPresence *tempPresence = nil;
    for (XMPPPresence *presence in self.subscribeArray) {
        if ([presence.from.user isEqualToString:friendJidStr]) {
            tempPresence = presence;
        }
    }
    
    if (tempPresence) {
        [self.subscribeArray removeObject:tempPresence];
    }
    
}



 #pragma mark 拒绝好友添加请求
- (void)rejectAddFriendRequest:(NSString *)friendJidStr{
    
    //组装JID
    XMPPJID *friendJid = [XMPPJID jidWithUser:friendJidStr domain:XMPP_DOMAIN resource:@"ios"];
    [_rosterModule rejectPresenceSubscriptionRequestFrom:friendJid];
    [_rosterModule removeUser:friendJid];

    XMPPPresence *tempPresence = nil;
    for (XMPPPresence *presence in self.subscribeArray) {
        if ([presence.from.user isEqualToString:friendJidStr]) {
            tempPresence = presence;
        }
    }
    
    if (tempPresence) {
        [self.subscribeArray removeObject:tempPresence];
    }
  
}




#pragma mark - -----------------------------好友信息------------------
#pragma mark 好友列表
-(NSArray*)friendsList:(void(^)(BOOL))update{
    
    if(_loginName==nil || _loginName.length==0) return nil;
    
    self.friendType=update;
    NSString *currentJid= [XMPPJID jidWithUser:_loginName domain:XMPP_DOMAIN resource:@"ios"].bare;
    NSManagedObjectContext*context=[_rosterStorageModule mainThreadManagedObjectContext];
    NSEntityDescription*entity=[NSEntityDescription entityForName:@"XMPPUserCoreDataStorageObject" inManagedObjectContext:context];
    NSPredicate*predicate=[NSPredicate predicateWithFormat:@"streamBareJidStr==%@",currentJid];
    NSFetchRequest*request=[[NSFetchRequest alloc]init];
    [request setEntity:entity];
    [request setPredicate:predicate];//筛选条件
    NSError*error;
    NSArray*friends=[context executeFetchRequest:request error:&error];//从数据库中取出数据
    NSMutableArray*haoyou=[NSMutableArray arrayWithCapacity:0];
    
    for (XMPPUserCoreDataStorageObject*object in friends) {
    
       if ([object.subscription isEqualToString:@"both"])
       {
           [haoyou addObject:object];
           
       }
    }
    
    return haoyou;
    
}




#pragma mark   获取个人电子名片
-(void)fetechMyVcardWithComplationBlock:(vCardBlock)completion{
    
    XMPPvCardTemp *vCard = [_vCardModule myvCardTemp];
    
    if (vCard) {
        if (completion) {
            completion(YES,vCard);
            completion = nil;
        }
    }
}



#pragma mark ----------------- 1、收发消息流程（近段联系人数据） ---------------
- (void)sendMessage:(XMPPMessage *)aMessage{

    
    NSString *body = aMessage.body;
    NSString *meesageFrom = aMessage.from.bare;
    NSString *meesageTo = aMessage.to.bare;
    
    if(meesageFrom == nil)
    {
        meesageFrom = meesageTo;
        meesageTo = USER_NAME;
    }
     if (![NSString isBlank:body]) {
         
         //创建message对象
         ChatMessageModel *msg=[[ChatMessageModel alloc]init];
         [msg setMessageDate:[NSDate date]];
         [msg setMessageContent:body];
         [msg setMessageTo:meesageTo];
         [msg setMessageFrom:meesageFrom];
         [msg setMessageNotNumber:@"1"];
         if([body hasPrefix:@"Img:"])
         {
             msg.messageType = @"[图片]";
         }else if ([body hasPrefix:@"Voice"])
         {
             msg.messageType = @"[语言]";
         }else
         {
             msg.messageType = body;
         }
         if([self.xmppCurrentChatID isEqualToString:meesageFrom])
         {
             // 接收消息来自当前聊天人发送
             msg.isCurrent = YES;
         }
         else
         {
           msg.isCurrent = NO;
         }
         //存储
         if ([ChatManager save:msg]) {
             
             [[NSNotificationCenter defaultCenter] postNotificationName:@"ChatList" object:nil];
         }
     }
}


#pragma mark - ----------------------------------publice method------------------------
#pragma mark - register
- (void)asyncRegisterWithUsername:(NSString *)username
                           Passwd:(NSString *)passwd
                       Completion:(XMPPResultBlock)completion
                          onQueue:(dispatch_queue_t)aQueue
{
    // 先把block存起来
    _resultBlock = completion;
    
    self.registerOperation = YES;
    
    //保存用户名密码到变量中
    _registerName = username;
    _registerPwd = passwd;
    
    
    // 如果以前连接过服务，要断开
    if (_xmppStream.isConnected) {
        [_xmppStream disconnect];
    }
    
    // 连接主机 成功后发送注册密码
    [self connectToServer];
    
}


#pragma mark - login
- (void)asyncLoginWithUsername:(NSString *)username
                        Passwd:(NSString *)passwd
                    Completion:(XMPPResultBlock)Completion
                       onQueue:(dispatch_queue_t)aQueue
{
    
    // 先把block存起来
    _resultBlock = Completion;
    
    //保存用户名密码到变量中
    _loginName = username;
    _loginPwd = passwd;
    
    self.registerOperation = NO;
    
    
    // 如果以前连接过服务，要断开
    if (_xmppStream.isConnected) {
        [_xmppStream disconnect];
    }
    
    // 连接主机 成功后发送登录密码
    [self connectToServer];
    

}



#pragma mark - logout
- (void)asyncLogoffWithCompletion:(XMPPResultBlock)Completion
                          onQueue:(dispatch_queue_t)aQueue{
    
    // 1." 发送 "离线" 消息"
    XMPPPresence *offline = [XMPPPresence presenceWithType:@"unavailable"];
    [_xmppStream sendElement:offline];
    
    // 2. 与服务器断开连接
    [_xmppStream disconnect];
    
    // 3. 回到登录界面
    LoginController *login = [[LoginController alloc]init];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = login;
    
    // 4.删除用户信息归档文件
    Account *account = [[Account alloc]init];
    account.loginName = nil;
    account.loginPasswd = nil;
    [[AccountTools sharedAccountTools]saveAccount:account];
    
    
}



#pragma mark - ----------------------------------private method------------------------
#pragma mark 初始化XMPPStream
- (void)SetupXMPPStream{
    
    NSAssert(_xmppStream == nil, @"Method setupStream invoked multiple times");
    
    self.subscribeArray = [NSMutableArray arrayWithCapacity:0];
    
    _xmppStream = [[XMPPStream alloc]init];
    
    //添加自动连接模块并激活
    _reconnectModule = [[XMPPReconnect alloc]init];
    [_reconnectModule activate:_xmppStream];
    
    //添加电子名片模块并激活
    _vCardstorageModule = [XMPPvCardCoreDataStorage sharedInstance];
    _vCardModule = [[XMPPvCardTempModule alloc]initWithvCardStorage:_vCardstorageModule];
    _vCardAvatarModule = [[XMPPvCardAvatarModule alloc]initWithvCardTempModule:_vCardModule];
    [_vCardModule activate:_xmppStream];
    [_vCardAvatarModule activate:_xmppStream];
    
    // 添加花名册模块【获取好友列表并激活
    _rosterStorageModule = [[XMPPRosterCoreDataStorage alloc]init];
    _rosterModule = [[XMPPRoster alloc]initWithRosterStorage:_rosterStorageModule];
    [_rosterModule activate:_xmppStream];
    
    // 添加聊天模块并激活
    _msgStorageModule  = [[XMPPMessageArchivingCoreDataStorage alloc]init];
    _msgArchModule = [[XMPPMessageArchiving alloc]initWithMessageArchivingStorage:_msgStorageModule];
    [_msgArchModule activate:_xmppStream];
    
    //允许程序在后台运行，挂起后已然可以接收到消息
    _xmppStream.enableBackgroundingOnSocket = YES;
    
    
    //设置代理
    [_xmppStream addDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    
#if !TARGET_IPHONE_SIMULATOR
    {
        _xmppStream.enableBackgroundingOnSocket = YES;
    }
#endif
    
    
}

#pragma mark 连接到服务器
- (void)connectToServer{
    
    MyLog(@"开始连接到服务器");
    
    if (!_xmppStream) {
        [self SetupXMPPStream];
    }
    
    // 发送通知【正在连接】
    [self postNotification:XMPPResultTypeConnecting];
    
    
    // 从单例获取用户名
    NSString *user = nil;
    Account *account = [AccountTools sharedAccountTools].getAccount;
    if(account.loginName.length >0 && account.loginPasswd.length >0)
    {
        user = account.loginName;
        _loginName = account.loginName;
        _loginPwd = account.loginPasswd;
        NSLog(@"直接登入");
        
    }else{
        
        NSLog(@"输入登入");
      if (self.isRegisterOperation) {  //注册用户
        user = _registerName;
      }else{                          //登录用户
        
         user = _loginName;
      }
    }
   
    // 设置登录用户JID
    //resource 标识用户登录的客户端 iphone android
    NSLog(@"%@:%@",user,_loginPwd);
    XMPPJID *myJid = [XMPPJID jidWithUser:user domain:XMPP_DOMAIN resource:@"ios"];
    _xmppStream.myJID = myJid;
    
    
    // 设置服务器域名
    _xmppStream.hostName =  XMPP_HOST;
    
    // 设置端口 如果服务器端口是5222，可以省略
    _xmppStream.hostPort = 5222;
    
    // 连接
    NSError *error = nil;
    if(![_xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error]){
        MyLog(@"连接服务器错误信息---%@",error);
    }
}


#pragma mark 连接到服务成功后，再发送密码授权
- (void)sendPwdTOServer{
    
    MyLog(@"发送密码认证....");
    
    NSError *error = nil;
    [_xmppStream authenticateWithPassword:_loginPwd error:&error];
    
    if (error) {
        
        MyLog(@"密码认证失败--%@",error);
        
    }else{
        
        MyLog(@"密码认证成功-");
    }
}


#pragma mark  授权成功后，发送"在线" 消息
- (void)sendOnlindToServer{
    
    XMPPPresence *presence = [XMPPPresence presence];
    
    [_xmppStream sendElement:presence];
}


#pragma mark 释放xmppStream相关的资源
- (void)teardownXmpp{
    
    // 移除代理
    [_xmppStream removeDelegate:self];
    
    // 停止模块
    [_reconnectModule deactivate];
    [_vCardModule deactivate];
    [_vCardAvatarModule deactivate];
    [_rosterModule deactivate];
    [_msgArchModule deactivate];
    
    // 断开连接
    [_xmppStream disconnect];
    
    // 清空资源
    _reconnectModule = nil;
    _vCardModule = nil;
    _vCardstorageModule = nil;
    _vCardAvatarModule = nil;
    _rosterModule = nil;
    _rosterStorageModule = nil;
    _msgArchModule = nil;
    _msgStorageModule = nil;
    _xmppStream = nil;
    
}

/**
 * 通知 WCHistoryViewControllers 登录状态
 *
 */

- (void)postNotification:(XMPPResultType)resultType{
    
    // 将登录状态放入字典，然后通过通知传递
    NSDictionary *userInfo = @{@"loginStatus":@(resultType)};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE
                                                        object:nil
                                                      userInfo:userInfo];
}

- (void)dealloc{
    
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ChatList" object:nil];
    [self teardownXmpp];
    
}





@end
