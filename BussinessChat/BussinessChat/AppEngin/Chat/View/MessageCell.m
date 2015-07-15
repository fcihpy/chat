//
//  MessageCell.m
//  ChatTest
//
//  Created by 郑南 on 15-7-2.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import "MessageCell.h"
@interface MessageCell ()
{
    UIView *_headImageBackView;
    NSString *_forDate;

}

@end

@implementation MessageCell

- (void)awakeFromNib {
    
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 1、创建时间
        self.labelTime = [[UILabel alloc] init];
        self.labelTime.textAlignment = NSTextAlignmentCenter;
        self.labelTime.textColor = [UIColor grayColor];
        self.labelTime.font = ChatTimeFont;
        [self.contentView addSubview:self.labelTime];
        
        // 2、创建头像
        _headImageBackView = [[UIView alloc]init];
        _headImageBackView.layer.cornerRadius = 22;
        _headImageBackView.layer.masksToBounds = YES;
        _headImageBackView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.4];
        [self.contentView addSubview:_headImageBackView];
        
        self.btnHeadImage = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnHeadImage.layer.cornerRadius = 20;
        self.btnHeadImage.layer.masksToBounds = YES;
//       [self.btnHeadImage addTarget:self action:@selector(btnHeadImageClick:)  forControlEvents:UIControlEventTouchUpInside];
        [_headImageBackView addSubview:self.btnHeadImage];
        
        // 3、创建头像下标
        self.labelNum = [[UILabel alloc] init];
        self.labelNum.textColor = [UIColor grayColor];
        self.labelNum.textAlignment = NSTextAlignmentCenter;
        self.labelNum.font = ChatTimeFont;
        [self.contentView addSubview:self.labelNum];
        
        // 4、创建内容
        self.btnContent = [[UIButton alloc]init];
        [self.btnContent setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.btnContent.titleLabel.font = ChatContentFont;
        self.btnContent.titleLabel.numberOfLines = 0;
//        [self.btnContent addTarget:self action:@selector(btnContentClick)  forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.btnContent];

    }
    return self;
    

}


//内容及Frame设置
- (void)setMessageFrame:(MessageFrame *)messageFrame{
    
    _messageFrame = messageFrame;
    MessageModel *message = messageFrame.message;
    
    // 1、设置时间
    if(_messageFrame.showTime)
    {
        self.labelTime.hidden = NO;
    }
    else
    {
        self.labelTime.hidden = YES;

    }
        self.labelTime.text =  message.strTime;
        self.labelTime.frame = messageFrame.timeF;
    

    
    
    // 2、设置头像
    _headImageBackView.frame = messageFrame.iconF;
    self.btnHeadImage.frame = CGRectMake(2, 2, ChatIconWH-4, ChatIconWH-4);
    if(!message.strIconURL)
    {
        [self.btnHeadImage setBackgroundImage:[UIImage imageNamed:@"chat_head"] forState:0];
    }
  
    // 3、设置下标
    self.labelNum.text = message.strName;
    if (messageFrame.nameF.origin.x > 160) {
        self.labelNum.frame = CGRectMake(messageFrame.nameF.origin.x - 60, messageFrame.nameF.origin.y + 3, 100, messageFrame.nameF.size.height);
        self.labelNum.textAlignment = NSTextAlignmentRight;
    }else{
        self.labelNum.frame = CGRectMake(messageFrame.nameF.origin.x+5, messageFrame.nameF.origin.y + 3, 80, messageFrame.nameF.size.height);
        self.labelNum.textAlignment = NSTextAlignmentLeft;
    }
    
    // 4、设置内容
    //prepare for reuse
    [self.btnContent setTitle:@"" forState:UIControlStateNormal];
//    self.btnContent.voiceBackView.hidden = YES;
//    self.btnContent.backImageView.hidden = YES;
    self.btnContent.frame = messageFrame.contentF;
    
    if (message.from == MessageFromMy) {
//        self.btnContent.isMyMessage = YES;
        [self.btnContent setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.btnContent.contentEdgeInsets = UIEdgeInsetsMake(ChatContentTop, ChatContentRight, ChatContentBottom, ChatContentLeft);
    }else{
//        self.btnContent.isMyMessage = NO;
        [self.btnContent setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.btnContent.contentEdgeInsets = UIEdgeInsetsMake(ChatContentTop, ChatContentLeft, ChatContentBottom, ChatContentRight);
    }
    
    //背景气泡图
    UIImage *normal;
    if (message.from == MessageFromMy) {
        normal = [UIImage imageNamed:@"chat_to"];
        normal = [normal resizableImageWithCapInsets:UIEdgeInsetsMake(20, 10, 10, 22)];
    }
    else{
        normal = [UIImage imageNamed:@"chat_from"];
        normal = [normal resizableImageWithCapInsets:UIEdgeInsetsMake(20, 22, 10, 10)];
    }
    [self.btnContent setBackgroundImage:normal forState:UIControlStateNormal];
    [self.btnContent setBackgroundImage:normal forState:UIControlStateHighlighted];
    
    switch (message.type) {
        case MessageTypeText:{
                [self.btnContent setTitle:message.strContent forState:UIControlStateNormal];
        }
            break;
            
        case MessageTypePicture:
        {
//            self.btnContent.backImageView.hidden = NO;
//            [self.btnContent.backImageView sd_setImageWithURL:message.pictureURL placeholderImage:[UIImage imageNamed:@"not.jpeg"]];
//            self.btnContent.backImageView.frame = CGRectMake(0, 0, self.btnContent.frame.size.width, self.btnContent.frame.size.height);
//            [self makeMaskView:self.btnContent.backImageView withImage:normal];
        }
            break;
        case MessageTypeVoice:
        {
//            self.btnContent.voiceBackView.hidden = NO;
//            self.btnContent.second.text = [NSString stringWithFormat:@"语音:%@",message.strVoiceTime];
//            //          songData = message.voice;
//            //          voiceURL = [NSString stringWithFormat:@"%@%@",RESOURCE_URL_HOST,message.strVoice];
//            voiceURL = message.strVoice;
        }
            break;
            
        default:
            break;
    }
}


- (void)setCellModel:(XMPPMessageArchiving_Message_CoreDataObject *)model andBeforeDate:(NSDate*)BeforeDate;
{
    MessageModel *message = [[MessageModel alloc]init];
    MessageFrame *messageframe = [[MessageFrame alloc]init];
    NSMutableDictionary *messageDict = [[NSMutableDictionary alloc]init];
    NSString *date = [self dateString:model.timestamp];
    NSString *forDate = [self dateString:BeforeDate];
    [messageDict setObject:model.body forKey:@"strContent"];
    [messageDict setObject:model.outgoing forKey:@"from"];
    [messageDict setObject:@(MessageTypeText) forKey:@"type"];
    [messageDict setObject:date forKey:@"strTime"];

    [message minuteOffSetStart:forDate end:date];
    [message setWithDict:messageDict];
    messageframe.showTime = message.showDateLabel;
    messageframe.message = message;
    self.messageFrame = messageframe;
   
}
- (CGFloat)getCellHight
{
    return _messageFrame.cellHeight;
}

// 设置时间
- (NSString *)dateString:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}



@end
