//
//  ProvinceModel.m
//  BussinessChat
//
//  Created by zhisheshe on 15-4-1.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "ProvinceModel.h"

@implementation ProvinceModel


- (id)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        
        self.provinceName = dict[@"name"];
        self.provinceID = dict[@"id"];
    }
    return self;
}


@end
