//
//  BaseCellModel.m
//  BussinessChat
//
//  Created by 郑南 on 15-7-7.
//  Copyright (c) 2015年 firstChedai. All rights reserved.
//

#import "BaseCellModel.h"

@implementation BaseCellModel

- (instancetype)initWithTitle:(NSString *)cellTitle;
{
    self = [super init];
    {
        self.cellTitle = cellTitle;
    }
    return self;

}

@end
