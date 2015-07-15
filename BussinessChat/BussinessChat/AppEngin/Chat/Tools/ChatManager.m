//
//  ChatManager.m
//  BussinessChat
//
//  Created by zhisheshe on 15-4-13.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "ChatManager.h"
#import "FMDatabase.h"
#import "FMResultSet.h"


@interface ChatManager ()

@end
@implementation ChatManager



#pragma mark - ------------------------增删改查
+ (BOOL) save:(ChatMessageModel *)aMessage{
    
    FMDatabase *db = [[FMDatabase alloc]initWithPath:DATABASE_PATH];
    if (![db open]) {
        MyLog(@"数据库打开失败");

        return NO;
    };
    
    NSString *createStr=@"create table MessageInfo (messageFrom text,messageTo text,messageContent text,messageDate text,messageType text,messageNotNumber text)";

    BOOL worked = [db executeUpdate:createStr];
    if(worked)
    {
        NSLog(@"创建成功");
    }
    
    NSString * insertStr=@"insert into MessageInfo values (?,?,?,?,?,?)";
    NSString *upDateStr=@"update MessageInfo set messageContent=?, messageDate=?,messageType=?,messageNotNumber=? where messageTo=? and messageFrom=?";
    
    FMResultSet *call=[db executeQuery:@"select * from MessageInfo where messageFrom=? and messageTo=?",aMessage.messageFrom,aMessage.messageTo];
    BOOL isData=NO;
    while ([call next]) {
        aMessage.messageNotNumber = [call stringForColumn:@"messageNotNumber"];
        isData=YES;
    }
    if (!isData) {
        
        call=[db executeQuery:@"select * from MessageInfo where messageFrom=? and messageTo=?",aMessage.messageTo,aMessage.messageFrom];//反查一次
        while ([call next]) {
            aMessage.messageNotNumber = [call stringForColumn:@"messageNotNumber"];
            isData=YES;
        }
    }
    
    
    if (!isData) {
        //如果表内没有数据，就插入数据
        isData=  [db executeUpdate:insertStr,aMessage.messageFrom,aMessage.messageTo,aMessage.messageContent,aMessage.messageDate,aMessage.messageType,aMessage.messageNotNumber];
    }else{
        //如果表内有数据，就更新数据
        if(aMessage.isCurrent)
        {
          // 如果为当前聊天人，未读消息清零
          aMessage.messageNotNumber = [NSString stringWithFormat:@"%d",0];
        }
        else{
        aMessage.messageNotNumber = [NSString stringWithFormat:@"%d",[aMessage.messageNotNumber intValue]+1];
            
        }
        isData=  [db executeUpdate:upDateStr,aMessage.messageContent,aMessage.messageDate,aMessage.messageType,aMessage.messageNotNumber,aMessage.messageTo,aMessage.messageFrom];//更新数据
        
        [db executeUpdate:upDateStr,aMessage.messageContent,aMessage.messageDate,aMessage.messageType,aMessage.messageNotNumber,aMessage.messageFrom,aMessage.messageTo];
    }
    
    [db close];
    return isData;
}

+(BOOL)clearNotNumber:(NSString *)aMessageID
{
    FMDatabase *db = [[FMDatabase alloc]initWithPath:DATABASE_PATH];
    if(![db open])
    {
        NSLog(@"数据库打开失败");
    }
    NSString *upDateStr=@"update MessageInfo set messageNotNumber=? where messageTo=? and messageFrom=?";
    BOOL isData = [db executeUpdate:upDateStr,@"0",USER_NAME,aMessageID];//更新数据
    [db close];
    return isData;
}

+(BOOL)deleteMessageID:(NSString *)aMessageID
{
    FMDatabase *db = [[FMDatabase alloc]initWithPath:DATABASE_PATH];
    if(![db open])
    {
        NSLog(@"数据库打开失败");
    }
    NSString *deletDateStr=@"delete from MessageInfo where messageTo=? and messageFrom=?";
    BOOL isData = [db executeUpdate:deletDateStr,USER_NAME,aMessageID]; // 删除数据
    [db close];
    return isData;

}

#pragma mark 获取最近联系人
+ (NSMutableArray *)fetchRecentChatByPage:(int)pageIndex{
    
    NSMutableArray *messageList=[NSMutableArray arrayWithCapacity:0];
    
    FMDatabase *db = [[FMDatabase alloc]initWithPath:DATABASE_PATH];
    if (! [db open]) {
        
        MyLog(@"数据库打开失败");
        return NULL;
    }
    
    NSString *queryString=@"select *from MessageInfo where  messageFrom=? or messageTo=? order by messageDate desc limit ?";
    FMResultSet *result = [db executeQuery:queryString,USER_NAME,USER_NAME,[NSString stringWithFormat:@"%d",pageIndex]];
    while ([result next]) {
        ChatMessageModel *model = [[ChatMessageModel alloc]init];
        [model setMessageContent:[result stringForColumn:kMESSAGE_CONTENT]];
        [model setMessageDate:[result dateForColumn:kMESSAGE_DATE]];
        [model setMessageFrom:[result stringForColumn:kMESSAGE_FROM]];
        [model setMessageTo:[result stringForColumn:kMESSAGE_TO]];
        [model setMessageType:[result stringForColumn:kMESSAGE_TYPE]];
        [model setMessageNotNumber:[result stringForColumn:@"messageNotNumber"]];
        [messageList addObject:model];
    }
    
    return messageList;
}

@end
