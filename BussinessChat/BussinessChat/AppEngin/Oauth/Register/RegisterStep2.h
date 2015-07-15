//
//  RegisterStep2.h
//  BussinessChat
//
//  Created by zhisheshe on 15-3-27.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "BaseViewWithTableViewController.h"
#import "CustomKeyBoard.h"
#import "BaseSettingTableView.h"


@protocol RegisgerViewControllerDelegate <NSObject>

/**
 *  完成注册
 */
-(void)regisgerViewControllerDidFinishRegister;

@end

@interface RegisterStep2 : BaseSettingTableView


@property (nonatomic,copy) NSString *userName;

@property (nonatomic,copy) NSString *passWd;

@property(nonatomic,weak)id<RegisgerViewControllerDelegate> delegate;


@end
