//
//  ChatMessageModel.h
//  BussinessChat
//
//  Created by zhisheshe on 15-3-26.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface ChatListModel : BaseModel


@property (nonatomic, copy) NSString *imageURL;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *detailMsg;
@property (nonatomic, copy) NSString *time;
@property (nonatomic) NSInteger unreadCount;

- (ChatListModel *)initWithDict:(NSDictionary *)dict;  //将字典传进来进行初始化


@end
