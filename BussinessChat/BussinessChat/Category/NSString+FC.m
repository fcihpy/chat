//
//  NSString+FC.m
//  pinchehui
//
//  Created by zhisheshe on 15-3-16.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "NSString+FC.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (FC)


+ (NSString *)stringWithDouble:(double)value fractionCount:(int)fractionCount
{
    if (fractionCount < 0) return nil;
    
    // 1.fmt ---> %.2f
    NSString *fmt = [NSString stringWithFormat:@"%%.%df", fractionCount];
    
    // 2.生成保留fractionCount位小数的字符串
    NSString *str = [NSString stringWithFormat:fmt, value];
    
    // 3.如果没有小数，直接返回
    if ([str rangeOfString:@"."].length == 0) {
        return str;
    }
    
    // 4.不断删除最后一个0 和 最后一个'.'
    NSInteger index = str.length - 1;
    unichar currentChar = [str characterAtIndex:index];
    
    while (currentChar == '0' ||  currentChar == '.') {
        if (currentChar == '.') {
            return [str substringToIndex:index];
        }
        
        index--;
        currentChar = [str characterAtIndex:index];
    }
    return [str substringToIndex:index + 1];
    //    unichar last = 0;
    //    while ( (last = [str characterAtIndex:str.length - 1]) == '0' ||
    //            last == '.') {
    //        str = [str substringToIndex:str.length - 1];
    //
    //        // 裁剪到'.'，直接返回
    //        if (last == '.') return str;
    //    }
}


//只能输入汉字
-(BOOL)isChinese{
    NSString *match=@"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}



+ (int)toInt:(id)str {
    @try {
        return [str intValue];
    } @catch (NSError *error) {
    } @catch (NSException *error) {
    }
    return 0;
}

+ (NSString *)toString:(NSInteger)obj {
    return [NSString stringWithFormat:@"%d", obj];
}

/**
 * 判断是否是float类型，并且只允许小数点后point位数
 */
+ (BOOL)isPureFloat:(NSString *)string point:(int)point {
    NSArray *array = [string componentsSeparatedByString:@"."];
    if (array.count > 1) {
        NSString *str = [array objectAtIndex:1];
        if (str.length > point) return false;
    }
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

- (bool)isChinese:(int)minLength {
    int count = 0;
    for (int i = 0; i < [self length]; i++) {
        unichar chinese = [self characterAtIndex:i];
        if (chinese >= 0x4e00 && chinese <= 0x9fff) {
            count++;
        }
    }
    return count >= minLength;
}

- (int)countForEnglish {
    int count = 0;
    for (int i = 0; i < [self length]; i++) {
        unichar chinese = [self characterAtIndex:i];
        if (chinese < 0x4e00 || chinese > 0x9fff) {
            count = count + 1;
        } else {
            count = count + 2;
        }
    }
    return count;
}

+ (NSDate *)toDate:(NSString *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter dateFromString:date];
}

+ (BOOL)isBlank:(id)str {
    return !str || str == (id) [NSNull null] || ((NSString *) str).length <= 0 || [@"(null)" isEqualToString:str];
}

+ (NSString *)defaultIfNil:(NSString *)str value:(NSString *)value {
    if ([NSString isBlank:str]) {
        return value;
    }
    return str;
}

/*邮箱验证 MODIFIED BY HELENSONG*/
- (BOOL)isValidateEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

/*手机号码验证 MODIFIED BY HELENSONG*/
- (BOOL)isValidateMobile {
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((17[0-9])|(13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:self];
}

// 5-10位数字或字母
- (BOOL)isValidatePassword {
    if (self.length < 5 || self.length > 10) return NO;
    NSString *phoneRegex = @"^[a-zA-Z0-9]+$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:self];
}


//身份号码
- (BOOL)isCertifNum{
    NSString *certStr = @"\\{14}[[0-9],0-9xX]";
    NSPredicate *certTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",certStr];
    return [certTest evaluateWithObject:self];
}

//只能是数字
- (BOOL)isNumber{
    NSString *numStr = @"^[0-9]*$";
    NSPredicate *numTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numStr];
    return [numTest evaluateWithObject:self];
}

/** 模板数据替换, @"a{name}b".template:@{"name":"W"} ==> aWb */
- (NSString *)template:(NSDictionary *)data {
    NSArray *keys = [data allKeys];
    NSString *result = self;
    for(NSString *key in keys) {
        result = [result stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"{%@}", key] withString:[data objectForKey:key]];
    }
    return result;
}

- (NSString *)urlencode {
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *) [self UTF8String];
    int sourceLen = strlen((const char *) source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' ') {
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

- (NSString *)urldecode {
    if ([NSString isBlank:self]) return self;
    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)md5Hex:(NSString *)input {
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];//
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%2s",result ];
    }
    return ret;
    
//    const char *original_str = [password UTF8String];
//    unsigned char result[CC_MD5_DIGEST_LENGTH];
//    CC_MD5(original_str, strlen(original_str), result);
//    NSMutableString *hash = [NSMutableString string];
//    for (int i = 0; i < 16; i++)
//    {
//        [hash appendFormat:@"%02X", result[i]];
//    }
//    NSString *mdfiveString = [hash lowercaseString];
//    return mdfiveString;
}


- (NSArray *)splitToArray:(NSString *)sep {
    NSMutableArray *result = [NSMutableArray array];
    NSArray *array = [self componentsSeparatedByString:sep];
    for(NSString *str in array) {
        if (![NSString isBlank:str]) {
            [result addObject:str];
        }
    }
    return result;
}


/** NSString.getMapValue:{"a":{"b":"x"}} key:@"a.b" ==> x */
+ (id)getMapValue:(NSDictionary *)map key:(NSString *)key {
    if (!map) return nil;
    NSArray *array = [key componentsSeparatedByString:@"."];
    id result = map;
    for(NSString *k in array) {
        if (!result) return nil;
        if (![result isKindOfClass:[NSDictionary class]]) break;
        result = [result objectForKey:k];
    }
    return result;
}

/** NSString.getMapValue:{"a":{"b":"x"}} key:@"a.b" ==> x */
+ (id)getMapValue:(NSDictionary *)map key:(NSString *)key defaultValue:(NSString *)defaultValue {
    id result = [NSString getMapValue:map key:key];
    if ([NSString isBlank:result]) {
        return defaultValue;
    }
    return result;
}

/*车牌号验证 MODIFIED BY HELENSONG*/
- (BOOL)validateCarNo {
    NSString *carRegex = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", carRegex];
    return [carTest evaluateWithObject:self];
}


- (BOOL)isEmpty:(NSString *)str{
    
    
    if (!str)  return NO;
    
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (![str isEqualToString:@""]) {
        return YES;
    }else{
        return NO;
    }
 
}

- (NSString *)fileAppend:(NSString *)append
{
    // 1.1.获得文件拓展名
    NSString *ext = [self pathExtension];
    
    // 1.2.删除最后面的扩展名
    NSString *imgName = [self stringByDeletingPathExtension];
    
    // 1.3.拼接-568h@2x
    imgName = [imgName stringByAppendingString:append];
    
    // 1.4.拼接扩展名
    return [imgName stringByAppendingPathExtension:ext];
}


/*字符串加密
 *参数
 *plainText : 加密明文
 *key        : 密钥 64位
 */
//- (NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key;
//{
//    NSString *ciphertext = nil;
//    const char *textBytes = [plainText UTF8String];
//    NSUInteger dataLength = [plainText length];
//    unsigned char buffer[1024];
//    memset(buffer, 0, sizeof(char));
//    Byte iv[] = {1,2,3,4,5,6,7,8};
//    size_t numBytesEncrypted = 0;
//
//    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
//                                          kCCOptionPKCS7Padding,
//                                          [key UTF8String], kCCKeySizeDES,
//                                          iv,
//                                          textBytes, dataLength,
//                                          buffer, 1024,
//                                          &numBytesEncrypted);
//    if (cryptStatus == kCCSuccess) {
//        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
//        
//        ciphertext = [[NSString alloc] initWithData:[GTMBase64 encodeData:data] encoding:NSUTF8StringEncoding];
//    }
//    return ciphertext;
//}



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
  //6. 出生年份的前两位必须是19或20
 */

+ (BOOL)verifyIDCardNumber:(NSString *)value{ //验证身份证
    
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([value length] != 18) {
        return NO;
    }
    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    NSString *leapMmdd = @"0229";
    NSString *year = @"(19|20)[0-9]{2}";
    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![regexTest evaluateWithObject:value]) {
        return NO;
    }
    int summary = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7
    + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9
    + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10
    + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5
    + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8
    + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4
    + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2
    + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6
    + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
    NSInteger remainder = summary % 11;
    NSString *checkBit = @"";
    NSString *checkString = @"10X98765432";
    checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
    return [checkBit isEqualToString:[[value substringWithRange:NSMakeRange(17,1)] uppercaseString]];
    
}

//+ (BOOL)verifyCardNumberWithSoldier:(NSString *)value{  //验证军官证或警官证
//    
//    NSString *s1 = @"^\\d*$";
//    NSString *s2 = @"^.{1,}字第\\d{4,}$";
//    //NSString *s3 = @"^([A-Za-z0-9\\u4e00-\\u9fa5])*$";
//    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    if ([self verifyText:value withRegex:s1]) {
//        NSString *s11 = @"^\\d{4,20}$";
//        return [value isMatchedByRegex:s11];
//    } else if ([self lengthUsingChineseCharacterCountByTwo:value] >= 10
//               && [self lengthUsingChineseCharacterCountByTwo:value] <= 20) {
//        return [value isMatchedByRegex:s2];
//    }
//    
//    return NO;
//    
//}
//
//+ (BOOL)verifyIDCardHadAdult:(NSString *)card{  //验证身份证是否成年且小于100岁****这个方法中不做身份证校验，请确保传入的是正确身份证
//    NSString *birtday = [VerifyRegexTool getIDCardBirthday:card];   //****年**月**日
//    //转换为****-**-**
//    birtday = [birtday stringByReplacingOccurrencesOfString:@"年" withString:@"-"];
//    birtday = [birtday stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
//    birtday = [birtday stringByReplacingOccurrencesOfString:@"日" withString:@""];
//    birtday = [NSString stringWithFormat:@"%@ 00:00",birtday];
//    NSDate *dateBirtday = [NSDate dateFromString:birtday];
//    NSInteger year = [[NSDate date] getIntervalTime:dateBirtday withDateType:DateTypeYear];   //得到年数
//    
//    if (year >= 18 && year < 100) {
//        return YES;
//    } else {
//        return NO;
//    }
//    
//    
//}
//
//+ (BOOL)verifyIDCardMoreThanPointDate:(NSString *)card withNumber:(NSInteger)number withAddTimeInterval:(NSTimeInterval)interval withDateType:(DateType)dateType{ //验证身份证加上指定天数是否大于指定number的类型
//    
//    
//    NSString *birtday = [VerifyRegexTool getIDCardBirthday:card];   //****年**月**日
//    //转换为****-**-**
//    birtday = [birtday stringByReplacingOccurrencesOfString:@"年" withString:@"-"];
//    birtday = [birtday stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
//    birtday = [birtday stringByReplacingOccurrencesOfString:@"日" withString:@""];
//    birtday = [NSString stringWithFormat:@"%@ 00:00",birtday];
//    NSDate *dateBirtday = [NSDate dateFromString:birtday];
//    NSDate *today = [NSDate dateFromStringWithoutTime:[[NSDate date] strDate]];
//    NSDate *pointDate = [today dateByAddingTimeInterval:interval];
//    
//    //tempDate为number后的日期
//    NSDate *tempDate = [pointDate dateAddNumber:-number withDateType:dateType];  //临界日期
//    if ([dateBirtday earlierDate:tempDate] == dateBirtday) {  //如果生日＋指定天数大雨tempdate，则通过
//        return YES;
//    } else {
//        return NO;
//    }
//    
//}
//
//+ (BOOL)verifyIDCardLessThanPointDate:(NSString *)card withNumber:(NSInteger)number withAddTimeInterval:(NSTimeInterval)interval withDateType:(DateType)dateType{  //验证身份证是否小于指定number的类型
//    
//    NSString *birtday = [self getIDCardBirthday:card];   //****年**月**日
//    //转换为****-**-**
//    birtday = [birtday stringByReplacingOccurrencesOfString:@"年" withString:@"-"];
//    birtday = [birtday stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
//    birtday = [birtday stringByReplacingOccurrencesOfString:@"日" withString:@""];
//    birtday = [NSString stringWithFormat:@"%@ 00:00",birtday];
//    NSDate *dateBirtday = [NSDate dateFromString:birtday];
//    NSDate *today = [NSDate dateFromStringWithoutTime:[[NSDate date] strDate]];
//    NSDate *pointDate = [today dateByAddingTimeInterval:interval];
//    
//    //tempDate为number后的日期
//    NSDate *tempDate = [pointDate dateAddNumber:-number withDateType:dateType];  //临界日期
//    if ([tempDate earlierDate:dateBirtday] == tempDate) {  //如果生日＋指定天数小于tempdate，则通过
//        return YES;
//    } else {
//        return NO;
//    }
//    
//    
//}


+ (NSString *)getIDCardBirthday:(NSString *)card{   //得到身份证的生日****这个方法中不做身份证校验，请确保传入的是正确身份证
    
    card = [card stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([card length] != 18) {
        return nil;
    }
    NSString *birthady = [NSString stringWithFormat:@"%@年%@月%@日",[card substringWithRange:NSMakeRange(6,4)], [card substringWithRange:NSMakeRange(10,2)], [card substringWithRange:NSMakeRange(12,2)]];
    return birthady;
    
}


+ (NSInteger)getIDCardSex:(NSString *)card{   //得到身份证的性别（1男0女）****这个方法中不做身份证校验，请确保传入的是正确身份证
    
    card = [card stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSInteger defaultValue = 0;
    if ([card length] != 18) {
        return defaultValue;
    }
    NSInteger number = [[card substringWithRange:NSMakeRange(16,1)] integerValue];
    if (number % 2 == 0) {  //偶数为女
        return 0;
    } else {
        return 1;
    }
    
}
@end
