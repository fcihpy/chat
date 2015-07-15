//
//  RegisterView.h
//  BussinessChat
//
//  Created by zhisheshe on 15-3-27.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterView : UIView


- (id)initWithFrame:(CGRect)frame delegate:(id)delegate;


@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

@property (weak, nonatomic) IBOutlet UITextField *verCodeTextFeild;


@property (weak, nonatomic) IBOutlet UITextField *passwdTextFeild;




+ (RegisterView *)register;

- (IBAction)getVerCodeBtn:(UIButton *)sender;


@end
