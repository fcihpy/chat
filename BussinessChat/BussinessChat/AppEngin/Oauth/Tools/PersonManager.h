//
//  PersonManager.h
//  BussinessChat
//
//  Created by zhisheshe on 15-4-29.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PersonModel.h"


@interface PersonManager : NSObject


#pragma mark - 获取个人信息
+ (void)getPersonInfoWithuid:(NSString *)uid getPersonModelSuccess:(void (^)(personModel *model))getPersonModelSuccess failure:(void (^)(NSError *error))failure;


@end
