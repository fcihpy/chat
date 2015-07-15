//
//  LoginController.m
//  bussinessChat
//
//  Created by zhisheshe on 15-3-25.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//
/*
 
 1、判断用户名密码是否合法，
 2、正确后进行登录
 3、登录成功后将用户名、密码保存到帐号单例中，并且发送通知修改登录状态
 
 */

#import "LoginController.h"
#import "LoginView.h"
#import "RegisterStep1.h"
#import "FCNavigationController.h"
#import "NewfeatureController.h"
#import "MainController.h"

@interface LoginController ()
{
    NSString *_username;
    NSString *_passwd;
}


@end

@implementation LoginController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      self.view = [[LoginView alloc ] initWithFrame:self.view.frame delegate:self];
    }
    return self;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    self.title =@"登录";

    self.view.backgroundColor = kLabelColor;
    //键盘弹出的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keysboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)goLogin{
    
   
    UITextField * phoneNumberTextFeild = (UITextField *)[[self.view viewWithTagWithoutSelf:101] viewWithTagWithoutSelf:101];
//
//    
//    if (!phoneNumber || [NSString isBlank:phoneNumber.text] || !phoneNumber.text.isValidateMobile) {
//        
//        [self showHint:@"请输入正确的手机 号"];
//        
//        return;
//    }
    
    UITextField * passWordTextFeild = (UITextField *)[[self.view viewWithTagWithoutSelf:101] viewWithTagWithoutSelf:102];
//
//    if (!passWord || [NSString isBlank:passWord.text] || !passWord.text.isValidatePassword) {
//        [self showHint:@"密码长度不正确"];
//        return;
//    }
//    
//    if (!passWord || [NSString isBlank:passWord.text]) {
//        [self showHint:@"请输入密码"];
//        return;
//    }else if (!passWord.text.isValidatePassword){
//        [self showHint:@"密码长度应为5-10位"];
//        return;
//    }
    
    
     //隐藏键盘
    [self recognizer];
    
    
    // 登录之前给个提示
    [MBProgressHUD showMessage:@"正在登录中" toView:self.view];
    __weak typeof (self)weakSelf = self;
    [[XmppHelper sharedInstance] asyncLoginWithUsername:phoneNumberTextFeild.text Passwd:passWordTextFeild.text Completion:^(XMPPResultType type) {

        _username = phoneNumberTextFeild.text;
        _passwd = passWordTextFeild.text;
        
        [weakSelf handleResultType:type];
  
    } onQueue:nil];
    
}

-(void)back{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark -------------------------UITextField---------notification

- (void)keysboardWillChangeFrame:(NSNotification *)notification{
    
  
    NSDictionary *userInfo = notification.userInfo;
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view setFrame:CGRectMake(0,  - endFrame.size.height +70, screenW, screenH)];
    } completion:^(BOOL finished) {
    }];
}

//取消响应，并将视图回复原状
-(void)recognizer{
    
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view setFrame:CGRectMake(0, 0, screenW, screenH)];
    } completion:^(BOOL finished) {
    }];
}

#pragma mark - 事件处理
-(void)forgetPassWd{
    
}

-(void)register1{
    
    FCNavigationController *nav = [[FCNavigationController alloc]initWithRootViewController:[[RegisterStep1 alloc]init]];
    [self presentViewController:nav animated:YES completion:nil];
}


#pragma mark - 处理返回结果

- (void)handleResultType:(XMPPResultType)type{
    
    //在主线程刷新UI
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [MBProgressHUD hideHUDForView:self.view];
        
        // 将登录状态放入字典，然后通过通知传递
//        NSDictionary *userInfo = @{@"loginStatus":@(type)};
        
        switch (type) {
            case XMPPResultTypeLoginSuccess:
                MyLog(@"登录成功");

                //发送登录成功通知
//                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE
//                                                                    object:nil
//                                                                  userInfo:userInfo];
//                
                // 隐藏模态窗口
                [self dismissViewControllerAnimated:YES completion:nil];
          
                [UIApplication sharedApplication].keyWindow.rootViewController = [[FCNavigationController alloc]initWithRootViewController:[[MainController alloc]init]];
                
                [AccountTools sharedAccountTools].isLogin = YES;
                
                FCAlert([NSString stringWithFormat:@"欢迎回来-%@",_username]);
                
                break;
                
            case XMPPResultTypeLoginFailure:
                MyLog(@"登录失败");
                [MBProgressHUD showError:@"用户名或者密码不正确" toView:self.view];
                break;
                
            case XMPPResultTypeNetErr:
                [MBProgressHUD showError:@"网络不给力" toView:self.view];
                
            default:
                break;

        }
        
    });
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}




@end
