//
//  BaseCellGroup.m
//  BussinessChat
//
//  Created by 郑南 on 15-7-8.
//  Copyright (c) 2015年 firstChedai. All rights reserved.
//

#import "BaseCellGroup.h"

@implementation BaseCellGroup

-(instancetype)init
{
    self = [super init];
    if(self)
    {
        _groupMemberArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (instancetype)initWithGroupArrar:(NSArray *)groupArr;
{
    self = [super init];
    if (self) {
        _groupMemberArray = [NSMutableArray arrayWithArray:groupArr];;
    }
    return self;
}

@end
