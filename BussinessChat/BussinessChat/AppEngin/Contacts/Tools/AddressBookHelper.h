//
//  AddressBookHelper.h
//  BussinessChat
//
//  Created by zhisheshe on 15-4-23.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "AddressModel.h"




@interface AddressBookHelper : NSObject



#pragma mark - 读取手机通讯录
+ (void)fetchContacts:(void (^)(NSArray *contacts))getSuccess failure:(void (^) (NSError *error))getfailure;

+ (void)getAddressBook:(void(^)(NSArray *contacts))completion;


+ (void)sortDataArry:(void(^)(NSArray *contacts))completion;


+ (BOOL)checkAddressBookAuthorizationStatus;

@end
