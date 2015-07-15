//
//  LoginView.m
//  BusinessTalk
//
//  Created by WQY on 15-3-25.
//  Copyright (c) 2015年 WQY. All rights reserved.
//

#import "LoginView.h"
#import "Constant.h"



#define Icon_Width (screenW - 280) / 2.0
#define BGView_Height screenH - 266
#define BackBtn_width (screenW - 32) / 2

#define LogoImg_Width (screenW - 152) / 2.0
#define LogoImg_Height 80 / 568.0 * screenH

@interface LoginView ()<UITextFieldDelegate>


@end

@implementation LoginView



- (id)initWithFrame:(CGRect)frame delegate:(id)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBgImge];
        
        //账号，密码表单
        UIView * bgView = [[UIView alloc ] initWithFrame:CGRectMake(0, BGView_Height , screenW, 190)];
        bgView.tag = 101;
        [self addSubview:bgView];
        
        //输入账户名
        UIImageView * phoneImg = [[UIImageView alloc ] initWithFrame:CGRectMake(Icon_Width, 11, 22, 22)];
        [phoneImg setImage:[UIImage imageNamed:@"oauth_login_username"]];
        [bgView addSubview:phoneImg];
        
        UITextField *inputPhone = [[UITextField alloc] initWithFrame:CGRectMake(Icon_Width + 30, 0, screenW - Icon_Width * 2 - 25, 44)];
        inputPhone.placeholder = @"请输入账户名";
        inputPhone.tag = 101;
        inputPhone.delegate = self;
        [self setTxetField:inputPhone];
        [bgView addSubview:inputPhone];
        
        UIView * phoneLine = [[UIView alloc ] initWithFrame:CGRectMake(Icon_Width, 44.5, screenW - 44, 0.5)];
        [phoneLine setBackgroundColor:kLineLoginColor];
        [bgView addSubview:phoneLine];
        
        
        //输入密码
        UIImageView * passWordImg = [[UIImageView alloc ] initWithFrame:CGRectMake(Icon_Width, 55, 22, 22)];
        [passWordImg setImage:[UIImage imageNamed:@"oauth_login_passwd"]];
        [bgView addSubview:passWordImg];
        
        UITextField *inputPassWord = [[UITextField alloc] initWithFrame:CGRectMake(Icon_Width + 30, 44, screenW - Icon_Width * 2 - 25, 44)];
        inputPassWord.placeholder = @"请输入密码";
        inputPassWord.tag = 102;
        inputPassWord.delegate = self;
        [self setTxetField:inputPassWord];
        [bgView addSubview:inputPassWord];
        
        UIView * passwordLine = [[UIView alloc ] initWithFrame:CGRectMake(Icon_Width, 88 , screenW - 44, 0.5)];
        [passwordLine setBackgroundColor:kLineLoginColor];
        [bgView addSubview:passwordLine];
        
        //登录
        UIButton * loginBtn = [[UIButton alloc ] initWithFrame:CGRectMake(Icon_Width, 118, 280, 40)];
        [loginBtn setBackgroundColor:kLabelColor];
        [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [loginBtn setTitleColor:kButtonPreColor forState:UIControlStateNormal];
        [loginBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [loginBtn.layer setMasksToBounds:YES];
        [loginBtn.layer setCornerRadius:5.0];
        [loginBtn addTarget:delegate action:@selector(goLogin) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:loginBtn];
        
        
        UILabel * forgetPassWd = [[UILabel alloc] initWithFrame:CGRectMake(Icon_Width, 168, 70, 20)];
        [forgetPassWd setText:@"忘记密码?"];
        [forgetPassWd setTextColor:kLabelColor];
        [forgetPassWd setFont:kFont14];
        [FCUitility addSingleEvent:forgetPassWd target:delegate action:@selector(forgetPassWd)];
        [bgView addSubview:forgetPassWd];
        
        
        UILabel * reg = [[UILabel alloc] initWithFrame:CGRectMake(Icon_Width + 280 - 40, 168, 40, 20)];
        [reg setTextAlignment:NSTextAlignmentRight];
        [reg setText:@"注册"];
        [reg setTextColor:kLabelColor];
        [reg setFont:kFont14];
        [FCUitility addSingleEvent:reg target:delegate action:@selector(register1)];
        [bgView addSubview:reg];
        
    
        
        //返回
        UIButton * backBtn = [[UIButton alloc ] initWithFrame:CGRectMake(BackBtn_width, screenH - 65, 32, 32)];
        [backBtn setImage:[UIImage imageNamed:@"login_back"] forState:UIControlStateNormal];
        [backBtn addTarget:delegate action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backBtn];
        
        [FCUitility addSingleEvent:self target:delegate action:@selector(recognizer)];
        
       
        
        [[NSUserDefaults standardUserDefaults ] setObject:@"syle1" forKey:@"syle1"];
    }
    return self;
}

-(void)setTxetField : (UITextField *)textField{
    
    textField.returnKeyType = UIReturnKeyDone;
    textField.keyboardType = UIKeyboardTypePhonePad;
    textField.font = kFont14;
    textField.textColor= [UIColor whiteColor];
//  textField.textColor = kColorWithRGB(119, 151, 168, 1);
    textField.keyboardAppearance = UIKeyboardAppearanceDefault;
    [kUserDefaults setObject:@"placeHoldColor" forKey:@"placeHoldColor"];
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    if (textField.tag == 101) {
        NSString *name = [AccountTools sharedAccountTools].account.loginName;
        
        textField.text = name;
        
        if (![name isValidateMobile]) {
            textField.text = @"";
        }
        
        MyLog(@"usernametext %@",textField.text);
        
    }else{
        
        textField.text = [AccountTools sharedAccountTools].account.loginPasswd;
        
        if ([textField.text isEqualToString:@"passwd"]) {
            textField.text = @"";
        }
         MyLog(@"passwd %@",textField.text);
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
    
}

-(void)setBgImge{
    
    
    UIImageView * loginImg = [[UIImageView alloc ] initWithFrame:self.frame];
    if (kIphone4) {
        [loginImg setImage:[UIImage imageNamed:@"Default"]];
    }else if (kIphone5){
        [loginImg setImage:[UIImage imageNamed:@"Default-568h"]];
    }else if(screenH == 667){
        
         [loginImg setImage:[UIImage imageNamed:@"Default-568h"]];
    }else{
        
         [loginImg setImage:[UIImage imageNamed:@"Default-568h"]];
    }
    [self addSubview:loginImg];
    

}





@end
