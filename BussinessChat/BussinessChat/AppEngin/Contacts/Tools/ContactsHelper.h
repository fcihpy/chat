//
//  ContactsHelper.h
//  BussinessChat
//
//  Created by zhisheshe on 15-4-30.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactsHelper : NSObject
singleton_interface(ContactsHelper)



+ (void)getPersoninfo:(void(^)(NSArray *personArry,NSArray *idArry))personArry;


#pragma mark - 对联系人进行分组排序
+ (void)sortDataArry:(void(^)(NSArray *contacts))completion;



+ (void)fetechBuddyList:(void(^)(NSArray *buddylist))buddylist;
@end
