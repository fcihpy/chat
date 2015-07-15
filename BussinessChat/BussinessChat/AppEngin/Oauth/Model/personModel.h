//
//  personModel.h
//  BussinessChat
//
//  Created by zhisheshe on 15-4-29.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface personModel : NSObject


@property (nonatomic) long long ID;

@property (nonatomic,copy) NSString *username;
@property (nonatomic,copy) NSString *password;
@property (nonatomic,copy) NSString *truename;
@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *hangye;
@property (nonatomic,copy) NSString *sex;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *gongs;
@property (nonatomic,copy) NSString *job;
@property (nonatomic,copy) NSString *gxjm;
@property (nonatomic,copy) NSString *jl;

@property (nonatomic,copy) NSString *addtime;
@property (nonatomic,copy) NSString *img;



@end
