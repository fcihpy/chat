//
//  MBProgressHUD+FC.h
//  BussinessChat
//
//  Created by zhisheshe on 15-5-18.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (FC)


+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;


@end
