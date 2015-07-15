//
//  ChatMessageCell.h
//  BusinessTalk
//
//  Created by WQY on 15-3-18.
//  Copyright (c) 2015年 WQY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatMessageModel.h"

#define TextLabel_Max_Width 200


@interface ChatMessageCell : UITableViewCell

@property(nonatomic,strong) NSString        * userHeadUrlStr;
@property(nonatomic,strong) NSString        * otherHeadUrlStr;
@property(nonatomic,strong) UIImageView     * chatBacgroudImg;
@property(nonatomic,strong) NSString        *chatContent;

@property(nonatomic) enum kWCMessageCellStyle  msgStyle;

@property (nonatomic,strong) ChatMessageModel *chatModel;

@property (nonatomic,strong) XMPPMessageArchiving_Message_CoreDataObject *model;


+ (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath withObject:(XMPPMessageArchiving_Message_CoreDataObject *)model;

@end
