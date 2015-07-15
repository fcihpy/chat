//
//  ChatManager.h
//  BussinessChat
//
//  Created by zhisheshe on 15-4-13.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatMessageModel.h"

@interface ChatManager : NSObject

//数据库增删改查
+(BOOL)save:(ChatMessageModel *)aMessage;
+(BOOL)clearNotNumber:(NSString *)aMessageID;
+(BOOL)deleteMessageID:(NSString*)aMessageID;
//+(BOOL)merge:(ChatMessageModel *)aMessage;

//获取好友列表

//获取最近联系人
+(NSMutableArray *)fetchRecentChatByPage:(int)pageIndex;



@end
