//
//  Account.m
//  车商官家
//
//  Created by Apple on 14-10-21.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "Account.h"

#define UidKey @"uid"
#define LoginNameKey @"loginName"
#define LoginPasswdKey @"loginPasswd"




@implementation Account

- (void)encodeWithCoder:(NSCoder *)encoder{
   
    [encoder encodeObject:_uid forKey:UidKey];
    [encoder encodeObject:self.loginName forKey:LoginNameKey];
    [encoder encodeObject:self.loginPasswd forKey:LoginPasswdKey];
    
}

- (id)initWithCoder:(NSCoder *)decoder{
    
    if (self =[super init]) {
        self.uid = [decoder decodeObjectForKey:UidKey];
        self.loginName = [decoder decodeObjectForKey:LoginNameKey];
        self.loginPasswd = [decoder decodeObjectForKey:LoginPasswdKey];
        
    }
    return self;
    
}


-(NSString *)jid{
    
    return [NSString stringWithFormat:@"%@@%@",self.loginName,XMPP_DOMAIN];
}


@end



