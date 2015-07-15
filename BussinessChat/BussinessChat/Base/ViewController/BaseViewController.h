//
//  BaseViewController.h
//  bussinessChat
//
//  Created by zhisheshe on 15-3-25.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController


@property (nonatomic,assign) BOOL isShowLeftItem;
@property (nonatomic,assign) BOOL isShowRightItem;


#pragma mark 基本设置
- (void)baseSetting;

- (void)clickLeftBarItm;

- (void)clickRightBarItm;


@end
