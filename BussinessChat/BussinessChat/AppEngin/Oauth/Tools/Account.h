//
//  Account.h
//  车商官家
//
//  Created by Apple on 14-10-21.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject <NSCoding>

@property (nonatomic,copy) NSString *uid;
@property (nonatomic,copy) NSString *loginName;
@property (nonatomic,copy) NSString *loginPasswd;

@property (nonatomic,copy) NSString *registerUser;      //注册用户
@property (nonatomic,copy) NSString *registerpwd;       //注册用户密码





-(NSString *)jid;

@end
