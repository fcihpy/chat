//
//  FCMob.h
//  BussinessChat
//
//  Created by zhisheshe on 15-5-12.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FCMobheaders.h"
#import "FCOauthManager.h"

@interface FCMob : NSObject <UIApplicationDelegate>


#pragma mark - ---------------------集成的其它类

/*!
 @class
 @brief 该类声明了
 @discussion SDK集成进工程后, 最先使用的类, 所有的类对象, 均是通过这个单实例来获取, 示例代码如下:
 [FcMob sharedInstance]
 */


//登录
@property (nonatomic, readonly, strong) id<FCOauthManager> OauthManger;

//个人信息


//硬件











/*!
 @method
 @brief 获取单实例
 @discussion
 @result FcMob实例对象
 */

+ (FCMob *)sharedInstance;










@end
