//
//  RegisterController.m
//  bussinessChat
//
//  Created by zhisheshe on 15-3-25.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "RegisterStep1.h"
#import "RegisterView.h"
#import "RegisterStep2.h"
#import "XmppHelper.h"


/*
 注册流程：
    0、回收键盘
    1、验证参数的有效性
    2、保存注册的用户名和密码到单例中
    3、注册提示
    4、向XMPP发起注册请求
    5、处理返回的注册结果
    6、返回上一级，进行登录
 
 /
 [self.view endEditing:YES];
 
 //验证参数的有效性
 if (![self validateFormInfo]) {
 [self showHint:@"请填写正确的手机号和密码" yOffset:-200];
 return;
 }
 
 //保存注册的用户名和密码到单例中
 */

@interface RegisterStep1 ()
{
    BOOL        isAgreen;
    UITextField *_usernameTextField;
    UITextField *_passwdTextField;
    UIButton    *_rightBtn;
}

@property (nonatomic,strong) RegisterView *registerView;

@end

@implementation RegisterStep1

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view = [[RegisterView alloc ] initWithFrame:self.view.frame delegate:self];
        
//          self.view.backgroundColor = kGlobalBg;
//      [self.view addSubview:[RegisterView register]];
        
    }
    return self;
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    self.view.backgroundColor = kGlobalBg;
    
//    [self.view addSubview:self.registerView];
//    [self.view addSubview:[RegisterView register]];
    
    
    
    //基本设置
    [self baseSetting];
    
    [self addNotification];
  
}



#pragma mark --------------------------------------------基本设置-----------------------------------------------
#pragma mark 基本设置
- (void)baseSetting{
    
    self.title = @"注册";
    
    //leftNavItem
    UIButton *backBartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBartBtn.frame = CGRectMake(0, 0, 22, 22);
    [backBartBtn setBackgroundImage:[UIImage imageNamed:@"nav_icon_return"] forState:UIControlStateNormal];
    [backBartBtn addTarget:self action:@selector(backPrev) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:backBartBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.frame = CGRectMake(0, 0, 42, 22);
    _rightBtn.enabled = NO;
    [_rightBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
    _rightBtn.titleLabel.font = kFont13;
    [_rightBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_rightBtn];
    
}

#pragma mark 返回
-(void)backPrev{
    [self dismissViewControllerAnimated:YES completion:^{}];
}


#pragma mark -下一步
-(void)next{
    
    //回收键盘
    [self.view endEditing:YES];

    //验证参数的有效性
    if (![self validateFormInfo]) {
//        [self showHint:@"请填写正确的手机号和密码" yOffset:-200];
        [MBProgressHUD showError:@"请填写正确的手机号和密码"];
        return;
    }
    
    //保存注册的用户名和密码到单例中
//    Account *account = [[Account alloc]init];
//    account.registerUser = _usernameTextField.text;
//    account.registerpwd = _passwdTextField.text;
//    [[AccountTools sharedAccountTools] saveAccount:account];
    
    //开启注册选项开关
//    [XmppHelper sharedInstance].registerOperation = YES;
    
    //注册提示语
    [MBProgressHUD showMessage:@"正在注册中............." toView:self.view];
    
    
    //向XMPP发起注册请求
    __weak typeof(self) weakSelf = self;
    [[XmppHelper sharedInstance] asyncRegisterWithUsername:_usernameTextField.text Passwd:_passwdTextField.text Completion:^(XMPPResultType type) {
        
        [weakSelf handleResultType:type];
        
    } onQueue:nil];
    
    
}


-(void)addNotification{
    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(failure:) name:@"didNotRegister" object:nil];
    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(success:) name:@"DidRegister" object:nil];
}

-(void)success:(NSNotification *)notification{
    [self showHint:@"注册成功。" yOffset:-200];
    [self.navigationController presentViewController:[[UINavigationController alloc ] initWithRootViewController:[[RegisterStep2 alloc ] init]] animated:YES completion:^{}];
}
-(void)failure:(NSNotification *)notification{
    [self showHint:@"账号已存在，请登录" yOffset:-200];
    return;
}


#pragma mark - 校验信息
- (BOOL)validateFormInfo {

    //username
    _usernameTextField = (UITextField *)[self.view viewWithTagWithoutSelf:101];
    if (!_usernameTextField || [NSString isBlank:_usernameTextField.text] || ![_usernameTextField.text isValidateMobile]) {
//        [self showHint:@"请输入正确的手机号"];
//        [self showHudInView:self.view hint:@"请输入正确的手机号"];
        return NO;
    
    }

    //verifyCode
    //    //验证码，后期会做判断
    //    UITextField * verifyCodeNumber = (UITextField *)[self.view viewWithTagWithoutSelf:102];
    //    if (!verifyCodeNumber || [NSString isBlank:verifyCodeNumber.text]) {
    //        return NO;
    //    }
    
    //passwd
    _passwdTextField = (UITextField *)[self.view viewWithTagWithoutSelf:103];
    if (!_passwdTextField || [NSString isBlank:_passwdTextField.text] || ![_passwdTextField.text isValidatePassword]) {
//        [self showHint:@"请输入密码"];
        return NO;
    }
//
    [[NSUserDefaults standardUserDefaults ] setObject:_usernameTextField.text forKey:XMPP_USER_LOGINNAME];
    [[NSUserDefaults standardUserDefaults ] setObject:_passwdTextField.text forKey:XMPP_USER_PASSWORD];
    //    [[NSUserDefaults standardUserDefaults ] setObject:verifyCodeNumber.text forKey:@"verifyCodeNumber"];
    
    return YES;
}

#pragma mark - 请求一个验证码
- (void)getVerifyCode:(UIButton *)btn {
    
    _usernameTextField = (UITextField *)[self.view viewWithTagWithoutSelf:101];
    
    if (!_usernameTextField || [NSString isBlank:_usernameTextField.text] || ![_usernameTextField.text isValidateMobile]) {
        return;
    }
    
    __block int timeout = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0), (uint64_t) (1.0*NSEC_PER_SEC), 0); //每秒执行
    
    dispatch_queue_t queue1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer1 = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    
    NSString * url = @"http://www.chedd.com/api/user/sendSmsCheckCode?telephone=15110006782";
    
//    [[NetWorkClient sharedClient] POST:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//        NSNumber *listStatus = (NSNumber *) [NSString getMapValue:responseObject key:@"responseHeader.status"];
//        if ([listStatus intValue] != 200) {
//            id response = [responseObject objectForKey:@"response"];
//            if (![NSString isBlank:response]) {
////                [UIAlertView displayAlertWithTitle:@"提示" message:response leftButtonTitle:@"取消" leftButtonAction:^{} rightButtonTitle:@"登录" rightButtonAction:^{
//                    //自动登录
//                    //                    [AppDelegate getInstance].window.rootViewController = [[UINavigationController alloc] initWithRootViewController: ];
//                }];
//                dispatch_source_cancel(_timer);
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    //设置界面的按钮显示 根据自己需求设置
//                    [btn setTitle:@"发送验证码" forState:UIControlStateNormal];
//                    btn.userInteractionEnabled = YES;
//                });
//            }
//        }
//
//        
//        dispatch_source_set_event_handler(_timer, ^{
//            if(timeout<=0){ //倒计时结束，关闭
//                dispatch_source_cancel(_timer);
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    //设置界面的按钮显示 根据自己需求设置
//                    [btn setTitle:@"发送验证码" forState:UIControlStateNormal];
//                    btn.userInteractionEnabled = YES;
//                });
//            }else{
//                int seconds = timeout % 60;
//                NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    //设置界面的按钮显示 根据自己需求设置
//                    [btn setTitle:[NSString stringWithFormat:@"%@秒",strTime] forState:UIControlStateNormal];
//                    btn.userInteractionEnabled = NO;
//                });
//                timeout--;
//            }
//        });
//        dispatch_resume(_timer);
//
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//    }];
//    
   //倒计时block
//    dispatch_source_set_event_handler(_timer, ^{
//        if(timeout<=0){ //倒计时结束，关闭
//            dispatch_source_cancel(_timer);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //设置界面的按钮显示 根据自己需求设置
//                [btn setTitle:@"发送验证码" forState:UIControlStateNormal];
//                btn.userInteractionEnabled = YES;
//            });
//        }else{
//            int seconds = timeout % 60;
//            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //设置界面的按钮显示 根据自己需求设置
//                [btn setTitle:[NSString stringWithFormat:@"%@秒",strTime] forState:UIControlStateNormal];
//                btn.userInteractionEnabled = NO;
//            });
//            timeout--;
//        }
//    });
//    dispatch_resume(_timer);
}



#pragma mark - 事件处理

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

/**
 *  处理注册的结果
 */
- (void)handleResultType:(XMPPResultType)type{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [MBProgressHUD hideHUDForView:self.view];
        
        switch (type) {
            case XMPPResultTypeNetErr:
//                [MBProgressHUD showMessage:@"网络不稳定" toView:self.view];
            
                FCAlert(@"网络不稳定");
                break;
             
            case XMPPResultTypeRegisterSuccess:
            {
//                [MBProgressHUD showMessage:@"注册成功" toView:[UIApplication sharedApplication].keyWindow];
                
                FCAlert(@"注册成功,请重新登录");
                //回到上个控制器
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self dismissViewControllerAnimated:YES completion:^{
                        
                        
                    }];
                    
                });
            }
                break;
                
            case XMPPResultTypeRegisterFailure:
                FCAlert(@"注册失败,用户名重复");
//                [MBProgressHUD showMessage:@"注册失败,用户名重复" toView:[UIApplication sharedApplication].keyWindow];
                break;
                
                
            default:
                break;
        }
      
//        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow];
     
    });
    
    
}


- (void)textChange:(UITextField *)textfeild{
    
//    _rightBtn.enabled = YES;
//    
//    // 设置注册按钮的可能状态
//    BOOL isEanble = (_usernameTextField.text.length != 0 && _passwdTextField.text.length  != 0);
//    
//    _rightBtn.enabled = isEanble;
    
    
}


#pragma mark - ---------------------getter/setter
- (RegisterView *)registerView{
    
    if (_registerView) {
        _registerView = [RegisterView register];
        _registerView.frame = CGRectMake(0, 64, screenW, 142);
    }
    
    return _registerView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
