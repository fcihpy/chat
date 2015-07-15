//
//  RegisterStep2.m
//  BussinessChat
//
//  Created by zhisheshe on 15-3-27.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "RegisterStep2.h"
#import "CellLabelWithArrowItem.h"
#import "CellImgWithArrowItem.h"
#import "CellLableItem.h"
#import "CellSwitchItem.h"
#import "CellTextFeildItem.h"
#import "DiscoverController.h"

#import "CityInfoController.h"
#import "Cover.h"
#import "CellGroupItem.h"
#import "ChooseGender.h"
#import "AppDelegate.h"
#import "PresentDatePickerView.h"

#import "LoginController.h"

@interface RegisterStep2 ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    CellTextFeildItem *tf2;
    CellLabelWithArrowItem *t1;
   
    
    CellImgWithArrowItem    *_headIconItem;
    CellTextFeildItem       *_mobileItem;
    CellTextFeildItem       *_nickNameItem;
    CellLabelWithArrowItem  *_birthDayItem;
    CellLabelWithArrowItem  *_sexItem;
    CellLabelWithArrowItem  *_genderItem;
    CellLabelWithArrowItem  *_placeItem;
    
    CellLabelWithArrowItem  *_jobItem;
    CellTextFeildItem       *_siglWordItem;
    
    UIWindow                * _keyWindow;

    
    NSString                *_checkPhoneNumber;
    ChooseGender            *_chooseGenderView;
    
//    CustomKeyBoard *_toolBarView;
    
    NSDictionary            *_registerDict;     //上传字典
    UIImage                 *_choosedImg;       //上传img
    
}

@property (strong, nonatomic) CustomKeyBoard * toolBarView;
@property(nonatomic,strong) Cover *cover;

@end

@implementation RegisterStep2

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initArgs];
    
    //基本设置
    [self baseSetting];
    
    [self addItemGroup1];
    
    [self addItemGroup2];
    
    [self addObserver];
   
}

- (void)initArgs{
    
    _cellModelArry = [NSMutableArray array];
    
    _registerDict = [NSDictionary dictionary];
}

- (void)addObserver{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityChange:) name:@"changeCity" object:nil];

//    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(setMobileNumber:) name:@"setMobile" object:nil];
    
//    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(setNickName:) name:@"setNickName" object:nil];
    
    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(chooseGender:) name:@"chooseGender" object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark --------------------------------------------基本设置-----------------------------------------------
#pragma mark 基本设置
- (void)baseSetting{
    
    [super baseSetting];
    
    self.title = @"个人资料";
    
    self.isShowLeftItem = YES;
//    self.view.backgroundColor = kGlobalBg;
    
    _keyWindow = [UIApplication sharedApplication].keyWindow;
    
  
    //rightBarItem
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交"style:UIBarButtonItemStylePlain target:self action:@selector(submit)];
    
}


#pragma mark - UI

- (Cover *)cover{
    
    if (_cover == nil) {
        _cover = [Cover coverWithTarget:self action:@selector(hiddle)];
        
        _cover.frame = self.view.bounds;

    }
    return _cover;
}

- (void)addItemGroup1{
    
    __weak RegisterStep2 *reg2 = self;
    
    //选择头像
    _headIconItem = [CellImgWithArrowItem itemWithTitle:@"头像"];
    _headIconItem.imgName = @"chat_head";
    _headIconItem.operation= ^{
        //选择图片
        [reg2 openPics];
        
    };
    
    
    
    //手机
    _mobileItem = [CellTextFeildItem itemWithTitle:@"手机"];
    _mobileItem.placeHoldText = @"请输入手机号";

    //昵称
    _nickNameItem = [CellTextFeildItem itemWithTitle:@"昵称"];
    _nickNameItem.placeHoldText = @"请输入昵称";


    //性别
    _genderItem = [CellLabelWithArrowItem itemWithTitle:@"性别"];
    if (_genderItem.lablelText == 0) {
        _genderItem.lablelText = @"请选择性别";
    }
    
    _genderItem.operation = ^{
 
        [reg2 callGenderKeyBord];
    };
    
    //出生日期
    _birthDayItem  = [CellLabelWithArrowItem itemWithTitle:@"出生日期"];
    
    if (_birthDayItem.lablelText.length == 0) {
        _birthDayItem.lablelText =@"请选择日期";
    }
 
    _birthDayItem.operation = ^{
   
        [reg2 callDatePickKeyBord];
        
//        PresentDatePickerView *datePicker = [[PresentDatePickerView alloc]init];
//        [reg2.navigationController pushViewController:datePicker animated:YES];
    };

    
    //section1
    CellGroupItem *group1 = [[CellGroupItem alloc]init];
    group1.items = @[_headIconItem, _mobileItem,_nickNameItem,_genderItem,_birthDayItem];
    [_cellModelArry addObject:group1];

    
}


- (void)addItemGroup2{
    __weak RegisterStep2 *reg2 = self;
    
    _jobItem = [CellLabelWithArrowItem itemWithTitle:@"从事行业"];
    if (_jobItem.lablelText.length == 0) {
        _jobItem.lablelText = @"请选择行业";
    }
    
    
    _placeItem = [CellLabelWithArrowItem itemWithTitle:@"所在地"];
    _placeItem.pushVCClass = [CityInfoController class];
    if (_placeItem.lablelText.length == 0) {
        _placeItem.lablelText = @"请选择城市";
    }
    _placeItem.operation = ^{
        
        CityInfoController *city =  [[CityInfoController alloc]init];
        [reg2.navigationController pushViewController:city animated:YES];
    };
    

    _siglWordItem = [CellTextFeildItem itemWithTitle:@"个性签名"];
    _siglWordItem.placeHoldText = @"说点什么吧，让大家认识你";
    [kUserDefaults setObject:@"placeHoldColor" forKey:@"placeHoldColor"];
    
    _siglWordItem.operation = ^{
        UITextField *temptf = [[UITextField alloc]init];
        temptf.tag = 203;
        temptf.delegate = reg2;
    };
    

    CellGroupItem *group2 = [[CellGroupItem alloc]init];
//    group2.items = @[_jobItem,_placeItem,_siglWordItem];
    
     group2.items = @[_placeItem];
   
    
    [_cellModelArry addObject:group2];
    
}

-(CustomKeyBoard *)toolBarView{
    if (_toolBarView == nil) {
//        _toolBarView = [[CustomKeyBoard alloc ] initWithFrame:CGRectZero delegate:self];
        [_toolBarView.layer setBorderWidth:1];
    }else{
        [_toolBarView removeFromSuperview];
//        _toolBarView = [[CustomKeyBoard alloc ] initWithFrame:CGRectZero delegate:self];
        [_toolBarView.layer setBorderWidth:1];
    }
    return _toolBarView;
}


#pragma mark - --------------------------textFeild代理------------

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField.tag == 203) {
        MyLog(@"asdgaegsrg %@",textField.text);
    }
    
    MyLog(@"agagag %@",textField.text);
    _mobileItem.textFeildText = textField.text;
    
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    
   
    
    // 设置注册按钮的可能状态
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"\n"]){
        return YES;
    }
    
    
    
//    if (textField1) {
//        if ([string isNumber]) {
    
    _mobileItem.textFeildText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [self.tableView reloadData];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    
//        }else{
//            [self showHint:@"手机号只能为数字"];
//            return NO;
//        }
//    }else if (textField2){
//        nickName.lablelText = [textField.text stringByReplacingCharactersInRange:range withString:string];
//        [self.tableView reloadData];
//    }
    
    return YES;
}




#pragma mark - -------------------------事件处理---------------
- (void)backPrev{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark - 设置手机号

#pragma mark - 手机号键盘
- (void)callMobileKeyBoard{
    
    
    _cover = [Cover coverWithTarget:self action:@selector(hiddle)];
    
    _cover.frame = self.view.bounds;
    
    [self.view addSubview:_cover];
    
    
    if (_toolBarView != nil) {
        [_toolBarView removeFromSuperview];
    }
    
    _toolBarView = [[CustomKeyBoard alloc ] initWithFrame:CGRectZero style:kNumberKeyBoard changeFrame:NO delegate:self];
    
    [self.view addSubview:_toolBarView];
}

-(void)setMobileNumber:(NSNotification *)notification{
    
    _mobileItem.textFeildText = notification.object;
    
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}



#pragma mark - 设置昵称

- (void)callNickNameKeyBoard{
    
    _cover = [Cover coverWithTarget:self action:@selector(hiddle)];
    
    _cover.frame = self.view.bounds;
    
    [self.view addSubview:_cover];
    
    if (_toolBarView != nil) {
        [_toolBarView removeFromSuperview];
    }
    
    _toolBarView = [[CustomKeyBoard alloc ] initWithFrame:CGRectZero style:kDefaultKeyBoard changeFrame:NO delegate:self];
    [self.view addSubview:_toolBarView];
    
}


- (void)setNickName:(NSNotification *)notification{
    
    _nickNameItem.textFeildText = notification.object;
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}


#pragma mark -设置性别
- (UIView *)callGenderKeyBord{
    
  return   [[ChooseGender alloc]initWithFrame:_keyWindow.frame delegate:self window:_keyWindow gender:_genderItem.lablelText];
    
}

-(void)chooseGender:(NSNotification *)notification{
    
    _genderItem.lablelText = notification.object;
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}


#pragma mark - 设置出生日期
- (void)timeChange:(UIDatePicker *)dp{
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    // 1.修改模型
    _birthDayItem.lablelText = [fmt stringFromDate:dp.date];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:4 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    
}

-(void)callDatePickKeyBord{
    
    //创建一个蒙板
    _cover = [Cover coverWithTarget:self action:@selector(hiddle)];
    _cover.frame = self.view.bounds;
    [self.view addSubview:self.cover];

    //格式化时间
    _birthDayItem.lablelText = @"1990-01-01";
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [fmt dateFromString:self->_birthDayItem.lablelText];
    
    //创建datePicker
    UIDatePicker *dp = [[UIDatePicker alloc]init];
    dp.date = date;
    dp.datePickerMode = UIDatePickerModeDate;
    [dp addTarget:self action:@selector(timeChange:) forControlEvents:UIControlEventValueChanged];
    dp.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    dp.backgroundColor = [UIColor lightGrayColor];
    
    
    //创建一个临时的，没法有frame的textFeild，目的是为了叫出键盘
    UITextField *temptf = [[UITextField alloc]init];
    temptf.inputView = dp;
    [self.view addSubview:temptf];
    [temptf becomeFirstResponder];
    
}



#pragma mark - 设置从事行业



#pragma mark - 设置所在城市
- (void)cityChange:(NSNotification *)noti{
    NSDictionary *dict = noti.userInfo;
    _placeItem.lablelText = [NSString stringWithFormat:@"%@ %@",dict[@"provinceName"],dict[@"cityName"]];
    
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
    
}


#pragma mark - -------------键盘回调


//键盘上的完成按钮
-(void)clickSure{
    
    if (![_mobileItem.textFeildText isValidateMobile]) {
        MyLog(@"不是手机号");
        return;
    }
    [self.view endEditing:YES];
}


#pragma mark - ------------ 点击注册- 共3步，------------------------
/*
 1、判断用户输入参数是否符合规范
 2、上传用户头像
 3、向服务器发送注册信息,服务器同时会向环信发起注册
 */

#pragma mark - register Persion info
- (void)registerPersonInfo{
    
    [[XmppHelper sharedInstance] asyncRegisterWithUsername:_userName Passwd:@"111111" Completion:^(XMPPResultType type) {
        
        
        MyLog(@"33333333333 %d",XMPPStreamInvalidType);
        
        //拿到我的电子名片的对象
        XMPPvCardTemp *myVcard = [XmppHelper sharedInstance].vCardModule.myvCardTemp;
        
        //头像
        myVcard.photo = UIImagePNGRepresentation(_headIconItem.image);
        
        //手机
        myVcard.note = _mobileItem.textFeildText;
        
        //昵称
        myVcard.nickname = _nickNameItem.textFeildText;
        
        //性别
        
        //出生日期
        
        //所在地
        
        //更新对象信息
        [[XmppHelper sharedInstance].vCardModule updateMyvCardTemp:myVcard];
        
        FCAlert(@"成功了");
    } onQueue:nil];
    
    
   
    
    
    
}

#pragma mark - 判断注册输入信息的有效性
- (BOOL)checkRegInfoValid{
    
    return YES;
}

#pragma mark - 上传图片
- (void)uploadImgWithSucess:(void(^)(NSString *status,NSString *imgUrl))sucess{
    
    [[NetWorkClient sharedClient] POST:@"home/index/upload_img" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:UIImageJPEGRepresentation(_choosedImg,0.05) name:@"iconImage" fileName:@"iconImage.png" mimeType:@"png"];
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        MyLog(@"uploadimg %@",responseObject);
        
        if (sucess) {
            sucess(responseObject[@"mes"],responseObject[@"list"]);
        }
        
//        FCAlert(responseObject[@"mes"]);
    
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
          MyLog(@"uploadimgerr %@",error.localizedDescription);
        
    }];
    

}

#pragma mark -注册方法
- (void)registerWithDict:(NSDictionary *)dict   Success:(void(^)(int status,NSString *message))success  failure:(void(^)(NSError *error))failure{
    
    [[NetWorkClient sharedClient] POST:@"home/index/regit" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //获取错误码
        int errorNumber = [responseObject[@"status"] intValue];
        
        NSString *message = responseObject[@"mes"];
        
//        FCAlert(message);
        
        if (success) {
            success(errorNumber,message);
        }
       
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}


#pragma mark - 提交注册信息
- (void)submit{

    [self registerPersonInfo];
//    _registerDict = @{
//                      @"username":_userName,
//                      @"password":_passWd,
//                      @"truename":_nickNameItem.textFeildText,
//                      @"city":_placeItem.lablelText,
//                      @"hangye":@"iot",
//                      @"sex":_genderItem.lablelText,
//                      @"phone":_mobileItem.textFeildText,
//                      @"gongs":@"第一车贷",
//                      @"job":@"leader",
//                      @"gxjm":@"天道酬勤",
//                      @"jl":@"100kille"
//                     
//                      };
//    
//        MyLog(@"nick111111-%@-",_registerDict);
//    //向本地存储帐号密码
//    Account *account = [[Account alloc]init];
//    account.registerUser = _userName;
//    account.registerpwd = _passWd;
//    [[AccountTools sharedAccountTools] saveAccount:account];
//
//    
//    //设置注册开关为on
//    [XmppHelper sharedInstance].RegisterOperation = YES;
//    
//    __weak typeof(self)  weakSelf = self;
//    [self uploadImgWithSucess:^(NSString *status, NSString *imgUrl) {
//        
//        _registerDict = @{
//                          @"username":_userName,
//                          @"password":_passWd,
//                          @"truename":_nickNameItem.textFeildText,
//                          @"city":_placeItem.lablelText,
//                          @"hangye":@"iot",
//                          @"sex":_genderItem.lablelText,
//                          @"phone":_mobileItem.textFeildText,
//                          @"gongs":@"第一车贷",
//                          @"job":@"leader",
//                          @"gxjm":@"天道酬勤",
//                          @"jl":@"100kille",
//                          @"img":imgUrl
//                          };
//        
//    MyLog(@"nick-%@-",_registerDict);
//        
//        FCAlert(status);
//        
//        //提示用户正在进行注册
//        [MBProgressHUD showSuccess:@"正在注册中......." toView:self.view];
//        
//        
//        //3、获取到服务器返回的图片url后，开始发起注册
//        [weakSelf registerWithDict:_registerDict Success:^(int status, NSString *message) {
//            
//            //弹出成功注册提示
//            FCAlert(message);
//  
//            
//              //延迟2S 跳转到登录页面
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                
//              
//                LoginController *login = [[LoginController alloc]init];
//                [weakSelf presentViewController:login animated:YES completion:nil];
//            });
//           
//            
//        } failure:^(NSError *error) {
//            
//        }];
//
//    }];

    
    //1、检查用户输入的有效性
    
//    if ([self checkRegInfoValid]) {
//        
//        //2、开始上传图片
//        [self uploadImgWithSucess:^(NSString *status,NSString *imgUrl) {
//            
//            
//            
//            MyLog(@"aaag %@",status);
//            
//            //3、获取到服务器返回的图片url后，开始发起注册
//            [self registerWithDict:_registerDict Success:^(int status, NSString *message) {
//                
////                FCAlert(message);
//                
//            } failure:^(NSError *error) {
//                
//            }];
//        }];
//
//        
//    }
    
//    //3、获取到服务器返回的图片url后，开始发起注册
//    [self registerWithDict:_registerDict Success:^(int status, NSString *message) {
//        
//        //                FCAlert(message);
//        
//    } failure:^(NSError *error) {
//        
//    }];
//    
   
    
}

/**
 *  处理注册的结果
 */

-(void)handleResultType:(XMPPResultType)type{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view];
        
        switch (type) {
            case XMPPResultTypeNetErr:
                [MBProgressHUD showError:@"网络不稳定" toView:self.view];
                break;
                
            case XMPPResultTypeRegisterSuccess:
                [MBProgressHUD showError:@"注册成功" toView:self.view];
                
                // 回到上个控制器
                [self dismissViewControllerAnimated:YES completion:nil];
                
                if ([self.delegate respondsToSelector:@selector(regisgerViewControllerDidFinishRegister)]) {
                    [self.delegate regisgerViewControllerDidFinishRegister];
                }
                break;
                
            case XMPPResultTypeRegisterFailure:
                [MBProgressHUD showError:@"注册失败,用户名重复" toView:self.view];
                break;
                
            default:
                break;
        }

        
        
    });
}



#pragma mark - -------------------------textfeild delegate-----------------





#pragma mark - -------------------------日期选择器-----------------




#pragma mark --- --------------相册选择-----------------
//打开相册
- (void)openPics{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"使用摄像头拍摄", @"从手机相册选择", nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}

//actionsheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    @try {
        
        UIImagePickerController *imgPicker = [[UIImagePickerController alloc]init];
        imgPicker.delegate = self;
        //编辑模式
        imgPicker.allowsEditing = YES;
        
        switch (buttonIndex) {
            case 0:             //使用摄像头拍摄
                imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                break;
                
            case 1:              //从手机相册选择
                imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
            default:
                return;
        }
        
        [self presentViewController:imgPicker animated:YES completion:nil];
        
    }
    @catch (NSException *exception) {
        FCAlert(@"您的机器不支持拍照");
    }
    @finally {
        
    }
    
}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    [viewController.navigationItem setTitle:@"照片"];
    
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc ] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(imageBack)];
    
}

- (void)imageBack {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

// 选中照片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        _headIconItem.image = info[@"UIImagePickerControllerEditedImage"];
        
        _choosedImg = info[@"UIImagePickerControllerEditedImage"];
        
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        
    }];
    
}


// 取消相册
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    MyLog(@"pickgetwt %@",picker);
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)hiddle{

    [_cover removeFromSuperview];
    [self.view endEditing:YES];
    
}




@end
