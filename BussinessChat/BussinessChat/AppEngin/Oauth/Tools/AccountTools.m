//
//  AccountTools.m
//  车商官家
//
//  Created by Apple on 14-10-21.
//  Copyright (c) 2014年 Apple. All rights reserved.
//



#define  fileMgr [NSFileManager defaultManager]

#import "AccountTools.h"
#import "Account.h"

#define IsLoginKey @"isLogin"
#define IsAutoLoginEnabledKey @"isAutoLoginEnabled"



@implementation AccountTools
//singleton_implementation(AccountTools)

static AccountTools *accountShared = nil;

+(AccountTools*)sharedAccountTools
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        accountShared = [[AccountTools alloc]init];
    });
    return accountShared;

}

//- (instancetype)init{
//    
//    if (self =[super init]) {
//        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:kAccountFile];
//    }
//    return self;
//}


- (void)saveAccount:(Account *)account{
    
    _account = account;
    [NSKeyedArchiver archiveRootObject:account toFile:kAccountFile ];

}

- (Account *)getAccount
{
    _account = [NSKeyedUnarchiver unarchiveObjectWithFile:kAccountFile];
    return _account;
}


- (void)deletAccount{

    if ([AccountTools isExitFile:kAccountFile]) {
        
        [fileMgr removeItemAtPath:kAccountFile error:nil];
    }
}

+ (BOOL)isExitFile:(NSString *)filePath{

    return [fileMgr fileExistsAtPath:filePath];
    
}



#pragma mark ------------getter/setter----

- (void)setIsLogin:(BOOL)isLogin{
    
    [FCUitility setBool:isLogin forKey:IsLoginKey];
}

- (BOOL)isLogin{
    
    return [FCUitility boolForKey:IsLoginKey];
    
}


- (void)setIsAutoLoginEnabled:(BOOL)isAutoLoginEnabled{
    
    [FCUitility setBool:isAutoLoginEnabled forKey:IsAutoLoginEnabledKey];
}

- (BOOL)isAutoLoginEnabled{
    
   return  [FCUitility boolForKey:IsAutoLoginEnabledKey];
}

//- (void)setIsAutoLoginEnabled:(BOOL)isAutoLoginEnabled{
//
//    
//    [FCUitility setBool:isAutoLoginEnabled forKey:IsAutoLoginEnabledKey];
//}
//
//- (BOOL)isAutoLoginEnabled{
//    
//    return [FCUitility boolForKey:IsAutoLoginEnabledKey];
//}
//
//
//- (void)setIsLogin:(BOOL)isLogin{
//    
//    [FCUitility setBool:isLogin forKey:IsLoginKey];
//}
//
//- (BOOL)isLogin{
//    
//    return [FCUitility boolForKey:IsLoginKey];
//}



@end
