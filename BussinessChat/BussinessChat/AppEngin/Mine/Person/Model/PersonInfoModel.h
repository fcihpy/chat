//
//  PersonInfoModel.h
//  BussinessChat
//
//  Created by 郑南 on 15/7/12.
//  Copyright (c) 2015年 firstChedai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonInfoModel : NSObject

@property (nonatomic,strong) UIImage *personPhoto;              // 头像
@property (nonatomic,strong) NSString *prsonName;               // 姓名
@property (nonatomic,strong) NSString *prsonPhone;              // 电话
@property (nonatomic,strong) NSString *prsonGender;             // 性别
@property (nonatomic,strong) NSString *prsonBday;               // 生日
@property (nonatomic,strong) NSString *prsonFamilyAddresses;    // 家庭地址
@property (nonatomic,strong) NSString *prsonTitle;              // 个性签名
@property (nonatomic,strong) UIImage *prsonLogo;               // 二维码


- (instancetype)initWithVcarJid:(XMPPJID *)vcardJid;

// 保存个人信息
- (void)personInfoSave;

@end
