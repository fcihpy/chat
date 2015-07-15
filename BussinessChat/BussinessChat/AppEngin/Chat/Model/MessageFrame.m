//
//  MessageFrame.m
//  ChatTest
//
//  Created by 郑南 on 15-7-2.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import "MessageFrame.h"
#import "MessageModel.h"
@implementation MessageFrame

- (void)setMessage:(MessageModel *)message
{
    _message = message;
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    // 1、计算时间的位置
    if (_showTime){
        CGFloat timeY = ChatMargin;
        CGSize timeSize = [_message.strTime sizeWithFont:ChatTimeFont constrainedToSize:CGSizeMake(300, 100) lineBreakMode:NSLineBreakByWordWrapping];
        CGFloat timeX = (screenWidth - timeSize.width) / 2;
        _timeF = CGRectMake(timeX, timeY, timeSize.width + ChatTimeMarginW, timeSize.height + ChatTimeMarginH);
    }
    
    // 2、计算头像位置
    CGFloat iconX = ChatMargin;
    if (_message.from == MessageFromMy) {
        iconX = screenWidth - ChatMargin - ChatIconWH;
    }
    CGFloat iconY = CGRectGetMaxY(_timeF) + ChatMargin;
    _iconF = CGRectMake(iconX, iconY, ChatIconWH, ChatIconWH);
    
    // 3、计算ID位置
    _nameF = CGRectMake(iconX, iconY+ChatIconWH, ChatIconWH, 20);
    
    // 4、计算内容位置
    CGFloat contentX = CGRectGetMaxX(_iconF)+ChatMargin;
    CGFloat contentY = iconY;
    
    //根据种类分
    CGSize contentSize;
    switch (_message.type) {
        case MessageTypeText:
            contentSize = [_message.strContent sizeWithFont:ChatContentFont  constrainedToSize:CGSizeMake(ChatContentW, 20000.0f) lineBreakMode:NSLineBreakByWordWrapping];
            break;
        case MessageTypePicture:
            contentSize = CGSizeMake(ChatPicWH, ChatPicWH);
            break;
        case MessageTypeVoice:
            contentSize = CGSizeMake(120, 20);
            break;
        default:
            break;
    }
    if (_message.from == MessageFromMy) {
        contentX = iconX - contentSize.width - ChatContentLeft - ChatContentRight - ChatMargin;
    }
    _contentF = CGRectMake(contentX, contentY, contentSize.width + ChatContentLeft + ChatContentRight, contentSize.height + ChatContentTop + ChatContentBottom);
    _cellHeight = MAX(CGRectGetMaxY(_contentF), CGRectGetMaxY(_nameF))+ ChatMargin;

}

@end
