//
//  CityModel.m
//  BussinessChat
//
//  Created by zhisheshe on 15-4-1.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel

- (id)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        
        self.cityName = dict[@"name"];
        self.cityID = dict[@"id"];
    }
    return self;
}

@end
