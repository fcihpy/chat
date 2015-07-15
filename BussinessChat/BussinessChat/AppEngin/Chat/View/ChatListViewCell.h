//
//  ChatListViewCell.h
//  BussinessChat
//
//  Created by zhisheshe on 15-3-26.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatListModel.h"
#import "ChatMessageModel.h"
@interface ChatListViewCell : UITableViewCell


@property (nonatomic,strong) ChatMessageModel *chatModel;
+ (id)cellShow;
+ (UINib *)loadNib;
    
@end
