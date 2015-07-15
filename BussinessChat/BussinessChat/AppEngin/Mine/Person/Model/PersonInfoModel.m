//
//  PersonInfoModel.m
//  BussinessChat
//
//  Created by 郑南 on 15/7/12.
//  Copyright (c) 2015年 firstChedai. All rights reserved.
//

#import "PersonInfoModel.h"
@implementation PersonInfoModel

-(instancetype)init
{
    self = [super init];
    if(self)
    {
        XmppHelper *helper = [XmppHelper sharedInstance];
        XMPPvCardTemp *vcardTemp = helper.vCardModule.myvCardTemp;
        
        NSData *photoData = [helper.vCardAvatarModule photoDataForJID:helper.xmppStream.myJID];
        if(photoData.length>0&&photoData!=nil)
        {
            _personPhoto = [UIImage imageWithData:photoData];
        }
        else
        {
            _personPhoto = [UIImage imageNamed:@"chat_head"];
        }
        _prsonName =vcardTemp.nickname?[vcardTemp.nickname compileUTF8String]:@"";
        _prsonGender = vcardTemp.givenName?[vcardTemp.givenName compileUTF8String]:@"";
        _prsonPhone = vcardTemp.prefix?[vcardTemp.prefix compileUTF8String]:[helper.xmppStream.myJID.bare componentsSeparatedByString:@"@"][0];
        _prsonBday = vcardTemp.bday?[self date:vcardTemp.bday]:@"";
        _prsonFamilyAddresses = vcardTemp.familyName?[vcardTemp.familyName compileUTF8String]:@"";
        _prsonTitle =vcardTemp.title?[vcardTemp.title compileUTF8String]:@"";
        _prsonLogo = vcardTemp.logo?[UIImage imageWithData:vcardTemp.logo]:[UIImage imageNamed:@"chat_QR code"];
        
    }
    return self;
}

- (instancetype)initWithVcarJid:(XMPPJID *)vcardJid
{
    self = [super init];
    if(self)
    {
        XmppHelper *helper = [XmppHelper sharedInstance];
        XMPPvCardTemp *vcardTemp = [helper.vCardModule vCardTempForJID:vcardJid shouldFetch:YES];
        
        NSData *photoData = [helper.vCardAvatarModule photoDataForJID:helper.xmppStream.myJID];
        if(photoData.length>0&&photoData!=nil)
        {
            _personPhoto = [UIImage imageWithData:photoData];
        }
        else
        {
            _personPhoto = [UIImage imageNamed:@"chat_head"];
        }
        _prsonName =vcardTemp.nickname?[vcardTemp.nickname compileUTF8String]:@"";
        _prsonGender = vcardTemp.givenName?[vcardTemp.givenName compileUTF8String]:@"";
        _prsonPhone = vcardTemp.prefix?[vcardTemp.prefix compileUTF8String]:[vcardJid.bare componentsSeparatedByString:@"@"][0];
        _prsonBday = vcardTemp.bday?[self date:vcardTemp.bday]:@"";
        _prsonFamilyAddresses = vcardTemp.familyName?[vcardTemp.familyName compileUTF8String]:@"";
        _prsonTitle =vcardTemp.title?[vcardTemp.title compileUTF8String]:@"";
        _prsonLogo = vcardTemp.logo?[UIImage imageWithData:vcardTemp.logo]:[UIImage imageNamed:@"chat_QR code"];

    }
    return self;
}

- (NSString *)date:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:date];
}
- (NSDate *)stringDate:(NSString *)stringDate
 {
     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
     [dateFormatter setDateFormat:@"yyyy-MM-dd"];
     return [dateFormatter dateFromString:stringDate];
}

- (void)personInfoSave
{
    XmppHelper *helper = [XmppHelper sharedInstance];
    XMPPvCardTemp *vcardTemp = helper.vCardModule.myvCardTemp;
    
    vcardTemp.nickname = [_prsonName shiftUTF8String];
    vcardTemp.givenName = [_prsonGender shiftUTF8String];
    vcardTemp.photo = UIImageJPEGRepresentation(_personPhoto, 0.5);
    vcardTemp.prefix = [_prsonPhone shiftUTF8String];
    vcardTemp.bday = [self stringDate:_prsonBday];
    vcardTemp.familyName = [_prsonFamilyAddresses shiftUTF8String];
    vcardTemp.title = [_prsonTitle shiftUTF8String];
    vcardTemp.logo = UIImageJPEGRepresentation(_prsonLogo, 0.5);
    
    [helper.vCardModule updateMyvCardTemp:vcardTemp];

}

@end
