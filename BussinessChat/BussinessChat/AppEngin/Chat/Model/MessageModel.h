//
//  MessageModel.h
//  ChatTest
//
//  Created by 郑南 on 15-7-2.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MessageType)
{
    MessageTypeText = 0,    // 文本
    MessageTypePicture = 1, // 图片
    MessageTypeVoice = 2    // 语言
};

typedef NS_ENUM(NSInteger, MessageFrom)
{
    MessageFromMy = 1, // 自己发送的
    MessageFromOther = 0, //别人发送的

};

@interface MessageModel : NSObject

@property (nonatomic, copy) NSString *strIconURL;
@property (nonatomic, copy) NSString *strId;
@property (nonatomic, copy) NSString *strTime;
@property (nonatomic, copy) NSString *strName;

@property (nonatomic, copy) NSString *strContent;
@property (nonatomic, copy) NSURL    *pictureURL;
@property (nonatomic, copy) NSData   *voice;
@property (nonatomic, copy) NSString *strVoiceTime;
@property (nonatomic, copy) NSString *strVoice;

@property (nonatomic, assign) MessageType type;
@property (nonatomic, assign) MessageFrom from;

@property (nonatomic, assign) BOOL showDateLabel;

- (void)setWithDict:(NSDictionary *)dict;

- (void)minuteOffSetStart:(NSString *)start end:(NSString *)end;

@end
