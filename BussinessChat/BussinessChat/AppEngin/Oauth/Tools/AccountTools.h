//
//  AccountTools.h
//  车商官家
//
//  Created by Apple on 14-10-21.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"
#import "Singleton.h"

@interface AccountTools : NSObject


//singleton_interface(AccountTools)

@property (nonatomic,strong) Account *account;          //帐号对象
@property (nonatomic,assign) BOOL isAutoLoginEnabled;  //自动登录开关
@property (nonatomic,assign) BOOL isAllowAutoLogin;


/**
 *  登录的状态 YES 登录过/NO 注销
 */

@property (nonatomic,assign) BOOL isLogin;                     //是否已经登录

+ (AccountTools *)sharedAccountTools;
- (void)deletAccount;
- (void)saveAccount:(Account *)account;
- (Account *)getAccount;
+ (BOOL)isExitFile:(NSString *)filePath;

@end
