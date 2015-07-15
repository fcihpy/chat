//
//  NSString+Helper.h
//  MedicalInformationIBM
//
//  Created by 郑 南 on 15/5/14.
//  Copyright (c) 2015年 huaJu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Helper)

- (NSString *)trimString;
- (NSString *)shiftUTF8String;     // 转换成utf8编码
- (NSString *)compileUTF8String;   // 编译utf8编码
- (NSString *)base64EncodedString; // 加密base64
- (NSString *)base64DecodedString; // 解密base64
- (NSString *)senddate;
@end
