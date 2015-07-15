//
//  PersonManager.m
//  BussinessChat
//
//  Created by zhisheshe on 15-4-29.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "PersonManager.h"

@implementation PersonManager
singleton_implementation(PersonManager)

#pragma mark - 获取个人信息
+ (void)getPersonInfoWithuid:(NSString *)uid getPersonModelSuccess:(void (^)(personModel *model))getPersonModelSuccess failure:(void (^)(NSError *error))failure{
    
    
    [[NetWorkClient sharedClient] GET:[NSString stringWithFormat:@"home/index/sele_user?username=%@",uid] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        MyLog(@"pserinsgi %@",responseObject);
        
        NSDictionary *dict = responseObject[@"list"];
        
        personModel *model = [personModel objectWithKeyValues:dict];
    
    
        
        if (getPersonModelSuccess) {
            getPersonModelSuccess(model);
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
    
    
}
@end
