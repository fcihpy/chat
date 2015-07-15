//
//  NetWorkClient.h
//  pinchehui
//
//  Created by zhisheshe on 15-1-14.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import <Foundation/Foundation.h>

@interface NetWorkClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

//- (void)networkChanged:(EMConnectionState)connectionState;


#pragma mark -检测网络可达性



@end
