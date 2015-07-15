//
//  HttpTools.m
//  myinfo
//
//  Created by Apple on 14-11-14.
//  Copyright (c) 2014年 allianture. All rights reserved.
//

#import "HttpTools.h"
static NSString * const BaseURL = @"http://api.app.net/";


@implementation HttpTools
singleton_implementation(HttpTools)

+ (void)getWithPath:(NSString *)path params:(NSDictionary *)params GetSuccess:(HttpSuccessBlock)GetSuccess GetFailure:(HttpFailureBlock)GetFailure{
    
    //创建一个AFN单例对象,BASEURL存放在manager参数中
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    //发起get请求，并将返回的结果，赋值给回调的block
    [mgr GET:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (GetSuccess) {
            GetSuccess(responseObject);
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (GetFailure) {
            GetFailure(error);
        }
    }];
}


+(void)postWithPath:(NSString *)path params:(NSDictionary *)params PostSuccess:(HttpSuccessBlock)PostSuccess PostFailure:(HttpFailureBlock)PostFailure{
    
    //创建一个AFN单例对象，BASEURL存放在manager参数中
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    //发起post请求，并将返回的结果，赋值给回调的block
   [mgr POST:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
       if (PostSuccess) {
           PostSuccess(responseObject);
       }
  
   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
       if (PostFailure) {
           PostFailure(error);
       }
   }];


    
    
   
    
    
}


@end
