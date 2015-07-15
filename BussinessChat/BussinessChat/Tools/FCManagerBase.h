//
//  FCManagerBase.h
//  BussinessChat
//
//  Created by zhisheshe on 15-5-12.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FCManagerDelegate.h"

@protocol FCManagerDelegate ;




@protocol FCManagerBase <NSObject>


@required

/*!
 @method
 @brief 注册一个监听对象到监听列表中
 @discussion 把监听对象添加到监听列表中准备接收相应的事件
 @param delegate 需要注册的监听对象
 @param queue 通知监听对象时的线程
 @result
 */
- (void)addDelegate:(id<FCManagerDelegate>)delegate delegateQueue:(dispatch_queue_t)queue;

/*!
 @method
 @brief 从监听列表中移除一个监听对象
 @discussion 把监听对象从监听列表中移除,取消接收相应的事件
 @param delegate 需要移除的监听对象
 @result
 */
- (void)removeDelegate:(id<FCManagerDelegate>)delegate;


@end
