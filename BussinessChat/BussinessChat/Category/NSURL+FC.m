//
//  NSURL+FC.m
//  bussinessChat
//
//  Created by zhisheshe on 15-3-25.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "NSURL+FC.h"

@implementation NSURL (FC)

- (id)initWithStringSilent:(NSString *)url {
    return [NSString isBlank:url] ? nil : [self initWithString:url];
}

@end
