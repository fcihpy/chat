//
//  RegisterView.m
//  BussinessChat
//
//  Created by zhisheshe on 15-3-27.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//


#define TEXTFIEL_HEIGHT 11
#define IMAGE_HEIGHT 22


#import "RegisterView.h"
#import "UIView+FC.h"

@implementation RegisterView

- (id)initWithFrame:(CGRect)frame delegate:(id)delegate{
    
    if (self = [super initWithFrame:frame]) {
        
        [self.layer setBorderWidth:1];
        
        self.backgroundColor = [UIColor whiteColor];
        //phoneNumber
        UIImageView * phoneImg = [[UIImageView alloc ] initWithFrame:CGRectMake(15, IMAGE_HEIGHT, 22, 22)];
        [phoneImg setImage:[UIImage imageNamed:@"oauth_register_username.png"]];
//        [phoneImg.layer setBorderWidth:1];
        [self addSubview:phoneImg];
        
        
        UITextField *inputPhone = [[UITextField alloc] initWithFrame:CGRectMake(44, TEXTFIEL_HEIGHT, screenW - 54, 44)];
//        [inputPhone.layer setBorderWidth:1];
        inputPhone.placeholder = @"账户名称";
        inputPhone.tag = 101;
        [self setTxetField:inputPhone];
        [self addSubview:inputPhone];
        
        
        //VerifyCodeNumber
        UIImageView * VerifyCodeImg = [[UIImageView alloc ] initWithFrame:CGRectMake(15, IMAGE_HEIGHT + 44, 22, 22)];
        [VerifyCodeImg setImage:[UIImage imageNamed:@"oauth_register_veri"]];
        [self addSubview:VerifyCodeImg];
        
        UITextField *inputVerifyCode = [[UITextField alloc] initWithFrame:CGRectMake(44, TEXTFIEL_HEIGHT + 44, screenW - 54, 44)];
        inputVerifyCode.placeholder = @"6-16位英文字母、数字";
        inputVerifyCode.tag = 102;
        [self setTxetField:inputVerifyCode];
        [self addSubview:inputVerifyCode];
        
        UIButton * VerifyCodeBtn = [[UIButton alloc ] initWithFrame:CGRectMake(screenW - 90, TEXTFIEL_HEIGHT + 44 +10, 80, 25)];
        [VerifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [VerifyCodeBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [VerifyCodeBtn setBackgroundColor:kButtonPreColor];
        VerifyCodeBtn.enabled = NO;
        VerifyCodeBtn.layer.cornerRadius = 3;
        
        [VerifyCodeBtn addTarget:delegate action:@selector(getVerifyCode:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:VerifyCodeBtn];
        
        
        //PassWordNumber
        UIImageView * passWordImg = [[UIImageView alloc ] initWithFrame:CGRectMake(15, IMAGE_HEIGHT + 44 *2, 22, 22)];
        [passWordImg setImage:[UIImage imageNamed:@"oauth_register_passwd.png"]];
        [self addSubview:passWordImg];
        
        UITextField *inputPassWord = [[UITextField alloc] initWithFrame:CGRectMake(44, TEXTFIEL_HEIGHT + 44 * 2, screenW - 54, 44)];
        inputPassWord.placeholder = @"6-16位英文字母、数字";
        [kUserDefaults setObject:@"placeHoldColor" forKey:@"placeHoldColor"];
        inputPassWord.tag = 103;
        [self setTxetField:inputPassWord];
        [self addSubview:inputPassWord];

        
    }
    return self;
}



-(void)setTxetField : (UITextField *)textField{
    textField.returnKeyType = UIReturnKeyDone; 
    textField.keyboardType = UIKeyboardTypePhonePad;
    textField.font = [UIFont systemFontOfSize:14];
    textField.keyboardAppearance = UIKeyboardAppearanceDefault;
//    
    [FCUitility addBorderLine:textField position:@"bottom"];
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
}



- (IBAction)textFeildChange {
    
    
}


+ (RegisterView *)register{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"RegisterView" owner:self options:nil] lastObject];
    
}


- (IBAction)getVerCodeBtn:(UIButton *)sender {
}
@end
