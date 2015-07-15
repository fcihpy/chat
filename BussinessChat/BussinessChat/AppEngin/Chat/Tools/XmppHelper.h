//
//  XmppHelper.h
//  BusinessTalk
//
//  Created by WQY on 15-3-13.
//  Copyright (c) 2015年 WQY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPPFramework.h"
#import "XMPP.h"
#import <QuartzCore/QuartzCore.h>


//定义XMPP结果的枚举
typedef enum {
    
    XMPPResultTypeConnecting,       //连接中...
    XMPPResultTypeLoginSuccess,     //登录成功
    XMPPResultTypeLoginFailure,     //登录失败
    XMPPResultTypeNetErr,           //网络不给力
    XMPPResultTypeRegisterSuccess,  //注册成功
    XMPPResultTypeRegisterFailure   //注册失败
    
}XMPPResultType;


extern NSString *const LoginStatusChangeNotification;

typedef void(^XMPPResultBlock)(XMPPResultType type);  // XMPP请求结果的block
typedef void(^vCardBlock)(BOOL,XMPPvCardTemp *);  //电子名片block


@interface XmppHelper : NSObject

@property (nonatomic, strong,readonly)XMPPStream                            *xmppStream;
@property (nonatomic, strong,readonly)XMPPvCardTempModule                   *vCardModule;             //电子名片模块
@property (nonatomic, strong,readonly)XMPPvCardAvatarModule                 *vCardAvatarModule;
@property (nonatomic, strong,readonly)XMPPRoster                            *rosterModule;            //花名册模块
@property (nonatomic, strong,readonly)XMPPRosterCoreDataStorage             *rosterStorageModule;     //花名册数据存储
@property (nonatomic, strong,readonly)XMPPMessageArchivingCoreDataStorage   *msgStorageModule;        //聊天数据存储
@property (nonatomic,strong) NSMutableDictionary                            *friendVcardDic;          //用于记录出席列表
@property (nonatomic,strong) NSString                                       *xmppCurrentChatID;       //当前聊天人ID
/**
 *  注册标识 YES 注册 / NO 登录
 */
@property (nonatomic, assign,getter=isRegisterOperation) BOOL  registerOperation;//注册操作
@property (nonatomic,retain)NSMutableArray  *subscribeArray;
@property(nonatomic,copy)void(^friendType)(BOOL);


+(XmppHelper*)sharedInstance;


- (NSArray *)buddylist;

#pragma mark -----------------连接服务器----------
- (void)connectToServer;

#pragma mark ------------------上下线------------
- (void)sendOnlindToServer;


#pragma mark ------------------收发信息------------

- (void)sendMessage:(XMPPMessage *)aMessage;

- (void)addSomeBody:(NSString *)userId;



#pragma mark -------------------添加、删除好友----------

#pragma mark 是否是好友
/**
 判断是否为好友
 */
- (BOOL)isFriend:(NSString *)uid;

/**
    添加好友
 */
- (void)addFriendWithJidStr:(NSString *)jidStr;

/**
    同意好友添加请求
 */
- (void)agreedtAddFriendRequest:(NSString *)friendJidStr;


/**
    拒绝好友添加请求
*/
- (void)rejectAddFriendRequest:(NSString *)friendJidStr;

/**
    获取个人电子名片
 */
-(void)fetechMyVcardWithComplationBlock:(vCardBlock)Completion;

/**
  获得好友列表 如有新状态，通过block回调
 */
-(NSArray*)friendsList:(void(^)(BOOL))update;






////////////////////////////////////////////////////////////////////////////////////////


#pragma mark -------------------------------配置XMPPSream流---------------------
#pragma mark - register
- (void)asyncRegisterWithUsername:(NSString *)username Passwd:(NSString *)passwd
                    Completion:(XMPPResultBlock)completion
                       onQueue:(dispatch_queue_t)aQueue;


#pragma mark - login
- (void)asyncLoginWithUsername:(NSString *)username Passwd:(NSString *)passwd
                        Completion:(XMPPResultBlock)Completion
                        onQueue:(dispatch_queue_t)aQueue;


#pragma mark - logout
- (void)asyncLogoffWithCompletion:(XMPPResultBlock)Completion
                        onQueue:(dispatch_queue_t)aQueue;





@end
