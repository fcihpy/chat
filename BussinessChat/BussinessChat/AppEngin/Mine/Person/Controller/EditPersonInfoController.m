//
//  EditPersonInfoController.m
//  BussinessChat
//
//  Created by zhisheshe on 15/6/18.
//  Copyright (c) 2015年 firstChedai. All rights reserved.
//

#import "EditPersonInfoController.h"

@interface EditPersonInfoController ()<UITextFieldDelegate>

@property(nonatomic,strong)UITextField *InPutText;

@end

@implementation EditPersonInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.InPutText];
}


#pragma mark 基本设置
- (void)baseSetting{
    
    
    self.view.backgroundColor = kGlobalBg;
    
    
    self.title = [NSString stringWithFormat:@"修改我的%@",_editTitle];
    
    //leftNavItem
    UIButton *leftBartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBartBtn.frame = CGRectMake(0, 0, 22, 22);
//    leftBartBtn.hidden = !self.isShowLeftItem;
    [leftBartBtn setBackgroundImage:[UIImage imageNamed:@"nav_icon_return"] forState:UIControlStateNormal];
    [leftBartBtn addTarget:self action:@selector(clickLeftBarItm) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:leftBartBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    
    //rightBarItem
    UIButton *rightBartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBartBtn.frame = CGRectMake(0, 0, 22, 22);
//    rightBartBtn.hidden = !self.isShowRightItem;
    [rightBartBtn setBackgroundImage:[UIImage imageNamed:@"nav_icon_mor"] forState:UIControlStateNormal];
    [rightBartBtn addTarget:self action:@selector(clickRightBarItm) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightbarItem = [[UIBarButtonItem alloc]initWithCustomView:rightBartBtn];
//    self.navigationItem.rightBarButtonItem = rightbarItem;
    
    
}
#pragma mark - 事件处理


#pragma mark - 事件处理

- (void)clickLeftBarItm{
    
    
    if([_InPutText.text isEqualToString:@""])
    {
        _editText.text = _InPutText.placeholder;

    }
    else
    {
        _editText.text = _InPutText.text;
        [self updataInfoContent:_editText.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)updataInfoContent:(NSString *)content
{
   if([_editTitle isEqualToString:@"手机:"])
   {
       _personInfo.prsonPhone = content;
       
   }else if ([_editTitle isEqualToString:@"昵称:"])
   {
       _personInfo.prsonName = content;

   
   }else if ([_editTitle isEqualToString:@"个性签名:"])
   {
       _personInfo.prsonTitle = content;

   }else if ([_editTitle isEqualToString:@""])
   {
       
   }else if ([_editTitle isEqualToString:@""])
   {
       
   }



}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self clickLeftBarItm];
    return YES;
}

#pragma mark -  getter/setter
- (UITextField *)InPutText{
    
    if (_InPutText == nil) {
        _InPutText=[[UITextField alloc]initWithFrame:CGRectMake(20, 10, screenW-40, 44)];
        _InPutText.backgroundColor = [UIColor whiteColor];
        _InPutText.borderStyle = UITextBorderStyleRoundedRect;
        _InPutText.placeholder=_editText.text;
        _InPutText.font = [UIFont systemFontOfSize:15];
        _InPutText.delegate = self;
        [self.view addSubview:_InPutText];
    }
    return _InPutText;
}




@end
