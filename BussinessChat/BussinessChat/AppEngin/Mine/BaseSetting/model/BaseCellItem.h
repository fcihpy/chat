//
//  BaseCellItem.h
//  BussinessChat
//
//  Created by zhisheshe on 15-3-29.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

/*
 一个ITEM对应一个cell
 用来描述当前cell里面的内容，描述点击cell后做的事情
 
 
 */

#import <Foundation/Foundation.h>

@interface BaseCellItem : NSObject


@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *subTitle;
@property (nonatomic, copy) void (^operation)() ; // 点击cell后要执行的操作



@property (nonatomic,copy) NSString *personIcon;
@property (nonatomic,copy) NSString *personName;
@property (nonatomic,copy) NSString *personMobile;



+ (id)itemWithTitle:(NSString *)title;

+ (id)itemWithIcon:(NSString *)icon  title:(NSString *)title;

+ (id)itemWithIcon:(NSString *)icon  title:(NSString *)title subTitle:(NSString *)subtitle;


+ (id)itemWithPersonIcon:(NSString *)personIcon name:(NSString *)personName mobile:(NSString *)personMobile;


@end
