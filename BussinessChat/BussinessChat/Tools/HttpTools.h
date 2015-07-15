//
//  HttpTools.h
//  myinfo
//
//  Created by Apple on 14-11-14.
//  Copyright (c) 2014年 allianture. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Singleton.h"  //单例方法

typedef void (^HttpSuccessBlock)(id responseObject);
typedef void (^HttpFailureBlock)(NSError *error);

@interface HttpTools : NSObject
singleton_interface(HttpTools)

//此处的PATH是除去baseurl之后的路径，baseurl，需要在afn中的manager中去修改

//GET请求
+ (void)getWithPath:(NSString *)path    params:(NSDictionary *)params   GetSuccess:(HttpSuccessBlock)GetSuccess   GetFailure:(HttpFailureBlock)GetFailure;
//POST请求
+ (void)postWithPath:(NSString *)path    params:(NSDictionary *)params   PostSuccess:(HttpSuccessBlock)PostSuccess   PostFailure:(HttpFailureBlock)PostFailure;

//下载图片


//上传图片


//上传视频

@end
