//
//  NetWorkClient.m
//  pinchehui
//
//  Created by zhisheshe on 15-1-14.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "NetWorkClient.h"

static NSString * const NetWorkClientBaseUrlString = kBASEURL;


@implementation NetWorkClient

+ (instancetype)sharedClient{
    static NetWorkClient *_sharedClient = nil;
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[NetWorkClient alloc] initWithBaseURL:[NSURL URLWithString:NetWorkClientBaseUrlString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}


+ (BOOL)network{
    __block BOOL netState = NO;
    
    NSString *strUrl = @"http://www.baidu.com";
    NSURL *baseURL = [NSURL URLWithString:strUrl];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    
    NSOperationQueue *operationQueue = manager.operationQueue;
    
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                netState = YES;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                netState = NO;
            default:
                [operationQueue setSuspended:YES];
                break;
        }
    }];
    
    [manager.reachabilityManager startMonitoring];
    
    return netState;
}


@end
