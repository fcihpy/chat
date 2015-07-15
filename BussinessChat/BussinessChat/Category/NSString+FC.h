//
//  NSString+FC.h
//  pinchehui
//
//  Created by zhisheshe on 15-3-16.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (FC)


// 生成一个保留fractionCount位小数的字符串(裁剪尾部多余的0)
+ (NSString *)stringWithDouble:(double)value fractionCount:(int)fractionCount;

- (NSString *)fileAppend:(NSString *)append;

-(BOOL)isChinese;

+ (int)toInt:(id)str;

+ (NSString *)toString:(NSInteger)obj;

+ (BOOL)isPureFloat:(NSString *)string point:(int)point;

- (bool)isChinese:(int)minLength;

- (int)countForEnglish;

+ (NSDate *)toDate:(NSString *)date;

+ (BOOL)isBlank:(id)str;

+ (NSString *)defaultIfNil:(NSString *)str value:(NSString *)value;

- (NSString *)urldecode;

+ (id)getMapValue:(NSDictionary *)map key:(NSString *)key;
+ (id)getMapValue:(NSDictionary *)map key:(NSString *)key defaultValue:(NSString *)defaultValue;

- (BOOL)validateCarNo;

- (BOOL)isValidateEmail;

- (BOOL)isValidateMobile;
- (BOOL)isValidatePassword;

- (NSString *)template:(NSDictionary *)data;

- (NSString *)urlencode;


#pragma mark - md5加密
- (NSString *)md5Hex:(NSString *)input;

- (NSArray *)splitToArray:(NSString *)sep;

- (BOOL)isEmpty:(NSString *)str;

#pragma mark - DES加密

/*字符串加密
 *参数
 *plainText : 加密明文
 *key        : 密钥 64位
 */
- (NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key;

#pragma mark - DES加密

#pragma mark -  -----------verifyIDCard
/*
 验证身份证
 长度必须是18位，前17位必须是数字，第十八位可以是数字或X（校验时不区分大小写）
 前两位必须是以下35种情形中的一种： 11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65,71,81,82,91
 第7到第14位出生年月日。第7到第10位为出生年份；11到12位表示月份，范围为01～12；13到14位为合法的日期，比如月份是04，范围应是01～30
 第17位表示性别，必须是0或1，0表示女，1表示男
 第18位为前17位的校验位 算法如下：
 总和 = (n1 + n11) * 7 + (n2 + n12) * 9 + (n3 + n13) * 10 + (n4 + n14) * 5 + (n5 + n15) * 8 + (n6 + n16) * 4 + (n7 + n17) * 2 + n8 + n9 * 6 + n10 * 3，其中n1表示1位数字，其它类似
 用总和除以11，看余数是多少, 余数只可能有0 1 2 3 4 5 6 7 8 9 10这11个数字。其分别对应的最后一位身份证的号码为1 0 X 9 8 7 6 5 4 3 2
 第7位必须为1，第8位必须为9，即：出生年份的前两位必须是19

 */

+ (BOOL)verifyIDCardNumber:(NSString *)value; //验证身份证

+ (BOOL)verifyCardNumberWithSoldier:(NSString *)value;   //验证军官证或警官证

+ (BOOL)verifyIDCardHadAdult:(NSString *)card;  //验证身份证是否成年且小于100岁****这个方法中不做身份证校验，请确保传入的是正确身份证

//+ (BOOL)verifyIDCardMoreThanPointDate:(NSString *)card withNumber:(NSInteger)number withAddTimeInterval:(NSTimeInterval)interval withDateType:(DateType)dateType; //验证身份证加上指定天数是否大于指定number的类型
//
//+ (BOOL)verifyIDCardLessThanPointDate:(NSString *)card withNumber:(NSInteger)number withAddTimeInterval:(NSTimeInterval)interval withDateType:(DateType)dateType;  //验证身份证是否小于指定number的类型

+ (NSString *)getIDCardBirthday:(NSString *)card;   //得到身份证的生日****这个方法中不做身份证校验，请确保传入的是正确身份证

+ (NSInteger)getIDCardSex:(NSString *)card;   //得到身份证的性别（1男0女）****这个方法中不做身份证校验，请确保传入的是正确身份证
@end
