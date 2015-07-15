//
//  ChatMessageObject.h
//  BusinessTalk
//
//  Created by WQY on 15-3-13.
//  Copyright (c) 2015年 WQY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

#define kMESSAGE_TYPE @"messageType"
#define kMESSAGE_FROM @"messageFrom"
#define kMESSAGE_TO @"messageTo"
#define kMESSAGE_CONTENT @"messageContent"
#define kMESSAGE_DATE @"messageDate"

typedef  enum  {
    kWCMessageTypePlain = 0,  // 普通文本
    kWCMessageTypeImage = 1,  // 图片
    kWCMessageTypeVoice =2,   // 语音
    kWCMessageTypeLocation=3  // 地理定位
}kWCMessageType;

enum kWCMessageCellStyle {
    kWCMessageCellStyleMe = 0,
    kWCMessageCellStyleOther = 1,
    kWCMessageCellStyleMeWithImage=2,
    kWCMessageCellStyleOtherWithImage=3
};


@interface ChatMessageModel : BaseModel

@property (nonatomic,copy) NSString  *messageFrom;
@property (nonatomic,copy) NSString  *messageTo;
@property (nonatomic,copy) NSString  *messageContent;
@property (nonatomic,copy) NSDate    *messageDate;
@property (nonatomic,copy) NSString  *messageType;
@property (nonatomic,copy) NSString  *messageNotNumber;
@property (nonatomic,assign) BOOL    isCurrent;

@end
