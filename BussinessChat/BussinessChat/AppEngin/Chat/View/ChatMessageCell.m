//
//  ChatMessageCell.m
//  BusinessTalk
//
//  Created by WQY on 15-3-18.
//  Copyright (c) 2015年 WQY. All rights reserved.
//

#import "ChatMessageCell.h"
#import "FCUitility.h"

@interface ChatMessageCell (){
    
    UIImageView *_userHeadImg;
    UIImageView *_otherHeadImg;
    UILabel     *_chatContentLabel;
}

@end

@implementation ChatMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        [self _initSubViews];
        
        self.backgroundColor = COLOR(234, 238, 242, 1);
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    }
    return self;
}


#pragma mark -初始化cell中所有控件  ---private mothod------------------------
- (void)_initSubViews{
    
    //自己头像
    _userHeadImg = [[UIImageView alloc ] init];
    [self.contentView addSubview:_userHeadImg];
    
    //他人头像
    _otherHeadImg= [[UIImageView alloc ] init];
    [self.contentView addSubview:_otherHeadImg];
    
    
    //聊天内容背景
    _chatBacgroudImg = [[UIImageView alloc ] initWithFrame:CGRectZero];
    _chatBacgroudImg.frame =  CGRectMake(0, 0, 34, 34);
    [self.contentView addSubview:_chatBacgroudImg];
    
    _chatContentLabel = [[UILabel alloc ] initWithFrame:CGRectZero];
    _chatContentLabel.frame = CGRectMake(0, 0, 100, 40);
    [_chatBacgroudImg addSubview:_chatContentLabel];
    
}


#pragma mark -对cell中控件进行布局
-(void)layoutSubviews{
    [super layoutSubviews];
    
    //自己头像
    [_userHeadImg setFrame:CGRectMake(5, 5, 40, 40)];
 
     //他人头像
    [_otherHeadImg setFrame:CGRectMake(screenW - 45, 5, 40, 40)];
    
   
    //聊天内容布局
    [_chatContentLabel setFont:kFont15];
    [_chatContentLabel setTextColor:[UIColor blackColor]];

    
    //设置文本位置
    [_chatContentLabel setY:5];
    [_chatContentLabel setX:10];
    
}

- (void)setModel:(XMPPMessageArchiving_Message_CoreDataObject *)model{
    
    _model = model;
    
    
    //聊天内容
    self.chatContent = _model.body;
    
    
    //消息收发归属
    //    enum kWCMessageCellStyle style=[chatModel.messageFrom isEqualToString:USER_ID]?kWCMessageCellStyleMe:kWCMessageCellStyleOther;
    
    BOOL isSender = model.outgoing ?YES:NO;
    
    //设置样式
    //    self.msgStyle = style;
    
    //自己头像url
    self.userHeadUrlStr = @"chat_head";
    
    //他人头像url
    self.otherHeadUrlStr = @"chat_head";
    
    
    //设置自己或他人的气泡位置
    CGSize contentSize = _chatContentLabel.frame.size;
    
    if (model.isOutgoing == NO) {
        [_otherHeadImg setHidden:YES];
        [_userHeadImg setHidden:NO];
        
        //聊天气泡位置
        [_chatBacgroudImg setFrame:CGRectMake(50 , 5, contentSize.width + 10, contentSize.height + 10)];
        _chatBacgroudImg.image = [[UIImage imageNamed:@"chat_from"] stretchableImageWithLeftCapWidth:15 topCapHeight:20];
        
    }else{
        
        [_userHeadImg setHidden:YES];
        [_otherHeadImg setHidden:NO];
        
        [_chatBacgroudImg setFrame:CGRectMake(screenW - 70 - contentSize.width , 8,contentSize.width + 10, contentSize.height + 10)];
        
        _chatBacgroudImg.image = [[UIImage imageNamed:@"chat_to"] stretchableImageWithLeftCapWidth:5 topCapHeight:20];
        
    }
    
    //刷新布局
    [self setNeedsLayout];
    
    
}


- (void)setChatModel:(ChatMessageModel *)chatModel{
    
    _chatModel = chatModel;
    
    //聊天内容
    self.chatContent = chatModel.messageContent;
    
    
    //消息收发归属
//    enum kWCMessageCellStyle style=[chatModel.messageFrom isEqualToString:USER_ID]?kWCMessageCellStyleMe:kWCMessageCellStyleOther;
    
    BOOL isSender = [chatModel.messageFrom isEqualToString:USER_ID]?YES:NO;
    
    //设置样式
//    self.msgStyle = style;
    
    //自己头像url
    self.userHeadUrlStr = @"chat_head";
    
    //他人头像url
    self.otherHeadUrlStr = @"chat_head";
    
    
    //设置自己或他人的气泡位置
     CGSize contentSize = _chatContentLabel.frame.size;
    
    if (isSender == NO) {
        [_otherHeadImg setHidden:YES];
        [_userHeadImg setHidden:NO];
        
        //聊天气泡位置
        
        
        //聊天气泡位置
        [_chatBacgroudImg setFrame:CGRectMake(50 , 5, contentSize.width + 10, contentSize.height + 10)];
        
        _chatBacgroudImg.image = [[UIImage imageNamed:@"chat_from"] stretchableImageWithLeftCapWidth:15 topCapHeight:20];
        
    

    }else{
        
        [_userHeadImg setHidden:YES];
        [_otherHeadImg setHidden:NO];
        
        [_chatBacgroudImg setFrame:CGRectMake(screenW - 70 - contentSize.width , 8,contentSize.width + 10, contentSize.height + 10)];
        
        _chatBacgroudImg.image = [[UIImage imageNamed:@"chat_to"] stretchableImageWithLeftCapWidth:5 topCapHeight:20];
   
    }

    //刷新布局
    [self setNeedsLayout];
    
}

- (void)awakeFromNib{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
}


+ (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath withObject:(XMPPMessageArchiving_Message_CoreDataObject *)model{
    
    NSString * chatText = model.body;
    CGSize textBlockMinSize = {200, CGFLOAT_MAX};
    CGSize size = [chatText boundingRectWithSize:textBlockMinSize
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:kFont14}
                                         context:nil].size;
    if (size.height < 50) {
        return 55;
    }
    return size.height + 25;
}

#pragma mark -------------getter/setter--------------

- (void)setUserHeadUrlStr:(NSString *)userHeadUrlStr{
    
    _userHeadUrlStr = userHeadUrlStr;
    
    [_userHeadImg setImage:[UIImage imageNamed:userHeadUrlStr]];
}

- (void)setOtherHeadUrlStr:(NSString *)otherHeadUrlStr{
    
    _otherHeadUrlStr = otherHeadUrlStr;
    
    [_otherHeadImg setImage:[UIImage imageNamed:otherHeadUrlStr]];
}

- (void)setChatContent:(NSString *)chatContent{
    
    _chatContent = chatContent;
    
    _chatContentLabel.text = chatContent;
    
    [_chatContentLabel  autoLabelHeight];
}



@end
