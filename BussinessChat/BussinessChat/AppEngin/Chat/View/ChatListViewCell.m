//
//  ChatListViewCell.m
//  BussinessChat
//
//  Created by zhisheshe on 15-3-26.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "ChatListViewCell.h"
#import "PersonInfoModel.h"
#import "SDImageCache.h"
#import "NSDate+Utils.h"
static UINib *cellNib;
@interface ChatListViewCell(){
    
    
    
}

@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *keyLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailMesglabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end


@implementation ChatListViewCell

- (void)awakeFromNib {
  
    _headImg.frame = CGRectMake(20, 10, 40, 40);
    _headImg.layer.cornerRadius = 20;
    _headImg.layer.masksToBounds = YES;
    _headImg.backgroundColor = [UIColor redColor];
    
    _keyLabel.frame = CGRectMake(60, 5, 200, 30);
    _detailMesglabel.frame = CGRectMake(60, 40, screenW - 60, 30);
    
    _countLabel.backgroundColor = [UIColor clearColor];
    _countLabel.layer.cornerRadius = 10;
    _countLabel.layer.masksToBounds = YES;
   
    _detailMesglabel.textColor = kValueColor;
    _timeLabel.textColor = kValueColor;
    self.backgroundColor = [UIColor whiteColor];

}


- (void)setChatModel:(ChatMessageModel *)chatModel
{
    PersonInfoModel *personInfo = [[PersonInfoModel alloc]initWithVcarJid:[XMPPJID jidWithString:chatModel.messageFrom]];
    _headImg.image = personInfo.personPhoto;
    _keyLabel.text = [chatModel.messageFrom componentsSeparatedByString:@"@"][0];
    _detailMesglabel.text = chatModel.messageType;
    _timeLabel.text = [NSDate changeTheDateString:chatModel.messageDate];
    
    if([chatModel.messageNotNumber intValue] >0)
    {
        _countLabel.backgroundColor = [UIColor redColor];
        _countLabel.textColor = [UIColor whiteColor];
        _countLabel.text = chatModel.messageNotNumber;

    }
    else
    {
        _countLabel.backgroundColor = [UIColor clearColor];
        _countLabel.textColor = [UIColor clearColor];
        _countLabel.text = chatModel.messageNotNumber;
    }

}

+ (UINib *)loadNib{
    
    if (cellNib) {
        return cellNib;
    }
    
    // Build cell nib
    cellNib = [UINib nibWithNibName:@"ChatListViewCell" bundle:nil];
    
    return cellNib;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

+ (id)cellShow{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"ChatListViewCell" owner:self options:nil] lastObject];
}

@end
