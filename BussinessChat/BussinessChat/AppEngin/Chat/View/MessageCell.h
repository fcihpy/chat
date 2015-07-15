//
//  MessageCell.h
//  ChatTest
//
//  Created by 郑南 on 15-7-2.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"
#import "MessageFrame.h"
@interface MessageCell : UITableViewCell

@property (nonatomic, retain)UILabel *labelTime;
@property (nonatomic, retain)UILabel *labelNum;
@property (nonatomic, retain)UIButton *btnHeadImage;
@property (nonatomic, retain)UIButton *btnContent;
@property (nonatomic, retain)MessageFrame *messageFrame;

- (void)setCellModel:(XMPPMessageArchiving_Message_CoreDataObject *)model andBeforeDate:(NSDate*)BeforeDate;

@end
