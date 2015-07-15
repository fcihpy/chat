//
//  ChatMessageModel.m
//  BussinessChat
//
//  Created by zhisheshe on 15-3-26.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "ChatListModel.h"

@implementation ChatListModel


- (ChatListModel *)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.name =dict[@"name"];
        self.detailMsg = dict[@"detailMsg"];
        self.time = dict[@"time"];
        self.unreadCount = [dict[@"unreadCount"] intValue];
        self.imageURL = dict[@"imageURL"];
    }
    return self;
}


@end
