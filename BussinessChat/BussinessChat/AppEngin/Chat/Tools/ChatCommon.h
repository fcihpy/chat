//
//  ChatCommon.h
//  BussinessChat
//
//  Created by zhisheshe on 15-4-13.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#ifndef BussinessChat_ChatCommon_h
#define BussinessChat_ChatCommon_h



#endif


#import "ChatManager.h"
#import "XmppHelper.h"

//XMPP

#define XMPP_USER_LOGINNAME @"loginUserName"
#define XMPP_USER_PASSWORD @"loginUserPassword"
#define XMPP_HOST @"123.57.132.102"
#define XMPP_DOMAIN @"admin"
#define XMPP_NewMsgNotifaction @"xmppNewMsgNotifaction"

#define USER_ID @"wangqiyan"
#define USER_ID1 @"wangqiyan1"

static NSString *host = @"teacher.local";


//FMDB
#define FMDBQuickCheck(SomeBool) { if (!(SomeBool)) { NSLog(@"Failure on line %d", __LINE__); abort(); } }
#define USER_NAME     [XmppHelper sharedInstance].xmppStream.myJID.bare
#define DATABASE_PATH [NSString stringWithFormat:@"%@/Library/Caches/MessageInfo.sqlite",NSHomeDirectory()]
