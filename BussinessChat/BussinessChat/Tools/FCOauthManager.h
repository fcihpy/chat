//
//  FCOauthManager.h
//  BussinessChat
//
//  Created by zhisheshe on 15-5-12.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FCManagerBase.h"


/*!
 @protocol
 @brief 本协议包括：登录、退出、修改密码等方法
 @discussion 所有不带Block回调的异步方法, 需要监听回调时, 需要先将要接受回调的对象注册到delegate中, 示例代码如下:
 [[[FCMob sharedInstance] Manager] addDelegate:self delegateQueue:dispatch_get_main_queue()]
 */

@protocol FCOauthManager <FCManagerBase>


#pragma mark - properties

/*!
 @property
 @brief 当前登录的用户信息
 */
@property (nonatomic, strong, readonly) NSDictionary *loginInfo;


/*!
 @property
 @brief 当前是否已有登录的用户
 */
@property (nonatomic, readonly) BOOL isLoggedIn;



#pragma mark - register
/*!
 @method
 @brief 异步方法, 在聊天服务器上创建账号
 @discussion
 @param username 用户名
 @param password 密码
 @param completion 回调
 @param aQueue 回调时的线程
 @result
 */
- (void)asyncRegisterNewAccount:(NSString *)username
                       password:(NSString *)password
                 withCompletion:(void (^)(NSString *username,
                                          NSString *password,
                                          NSError *error))completion
                        onQueue:(dispatch_queue_t)aQueue;




#pragma mark - login
/*!
 @method
 @brief 异步方法, 使用用户名密码登录聊天服务器
 @discussion
 @param username 用户名
 @param password 密码
 @param completion 回调
 @param aQueue 回调时的线程
 @result
 */
- (void)asyncLoginWithUsername:(NSString *)username
                      password:(NSString *)password
                    completion:(void (^)(NSDictionary *loginInfo, NSError *error))completion
                       onQueue:(dispatch_queue_t)aQueue;




#pragma mark - logoff

/*!
 @method
 @brief 异步方法, 注销当前登录用户
 @discussion 当接收到【didLoginFromOtherDevice】和【didRemovedFromServer】的回调时，调用此方法，isUnbind传NO
 @param completion 回调
 @param aQueue     回调时的线程
 @result
 */
- (void)asyncLogoffWithUnbindDeviceToken:(BOOL)isUnbind
                              completion:(void (^)(NSDictionary *info, NSError *error))completion
                                 onQueue:(dispatch_queue_t)aQueue;

@end
