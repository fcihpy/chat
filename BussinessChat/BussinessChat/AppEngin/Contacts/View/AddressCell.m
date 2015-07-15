//
//  AddressCell.m
//  BussinessChat
//
//  Created by zhisheshe on 15-4-24.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "AddressCell.h"
#import <MessageUI/MessageUI.h>

enum kInviteType {
    
    kInvitedTypeAdded = 0,
    kInvitedTypeAccess = 1,
    kInvitedTypeVerificaton = 2
    
};


typedef enum kInviteType inviteType;


@interface AddressCell (){
    
    
}





@end

typeof(id) bSelf;

static UINib *cellNib;

@implementation AddressCell

-(void)initWithDelegate:(id)delegate{
    
    bSelf = delegate;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (UINib *)loadNib{
    
    if (cellNib) {
        return cellNib;
    }
    
    cellNib = [UINib nibWithNibName:@"AddressCell" bundle:nil];
    
    return  cellNib;
}


+ (instancetype)cellShow{
    
    return [[NSBundle mainBundle] loadNibNamed:@"AddressCell" owner:self options:nil][0];
}

- (void)setModel:(AddressModel *)model{
    _model = model;
    
    self.nameLabel.text = model.name;
    
    //根据不同状态，显示按钮的title
    
//    [self.statusBtn setTitle:@"已添加" forState:UIControlStateNormal];
//    [self.statusBtn setTitleColor:kValueColor forState:UIControlStateDisabled];
//    self.statusBtn.enabled = NO;
//    self.statusBtn.titleLabel.font = kFont13;
    

//    [self.statusBtn setTitle:@"等待验证" forState:UIControlStateNormal];
//    [self.statusBtn setTitleColor:kValueColor forState:UIControlStateDisabled];
//    self.statusBtn.enabled = NO;
//    self.statusBtn.titleLabel.font = kFont13;
    
    
    [self.statusBtn setTitle:@"添加" forState:UIControlStateNormal];
    self.statusBtn.titleLabel.font = kFont13;
    [self.statusBtn setBackgroundColor:kButtonPreColor];
    [self.statusBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.statusBtn.layer.cornerRadius = 3;
    self.statusBtn.layer.masksToBounds = YES;
    
//    [self.statusBtn setTitle:@"接受" forState:UIControlStateNormal];
//    self.statusBtn.titleLabel.font = kFont13;
//    [self.statusBtn setBackgroundColor:kButtonPreColor];
//    [self.statusBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    self.statusBtn.layer.cornerRadius = 3;
//    self.statusBtn.layer.masksToBounds = YES;
    
    [self.statusBtn addTarget:self action:@selector(sendShortMsg) forControlEvents:UIControlEventTouchDown];
    
}

- (void)sendShortMsg{

    //实例化一个控制器
    MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc]init];
    
    
    //判断是否有发短信功能
    if (![MFMessageComposeViewController canSendText]) return;
    
    //收件人
    messageVC.recipients = @[_model.mobile];
    
    //内容
    messageVC.body = @"我要加你为好友,行吗？";
    
    //代理
    messageVC.messageComposeDelegate = bSelf;
    
    //显示短信控制器
    [bSelf presentViewController:messageVC animated:YES completion:nil];
  
}




@end
