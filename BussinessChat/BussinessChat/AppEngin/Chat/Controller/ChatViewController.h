//
//  ChatViewController.h
//  BussinessChat
//
//  Created by zhisheshe on 15-3-29.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPPJID.h"
#import "ChatKeyBoardView.h"


@interface ChatViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>



@property (nonatomic,copy) NSString             *friendName;
@property (nonatomic,copy) NSString             *friendID;
@property (nonatomic, strong) XMPPJID           *friendJid;


@end
