//
//  CellSwitchItem.m
//  BussinessChat
//
//  Created by zhisheshe on 15-3-29.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "CellSwitchItem.h"

@implementation CellSwitchItem

- (void)setIsOff:(BOOL)isOff{
    _isOff = isOff;
    
    // 归档
    [CellValueKeyTool setBool:isOff forKey:self.valueForKey];
    
}

- (void)setValueForKey:(NSString *)valueForKey{
    [super setValueForKey:valueForKey];
    
    //读档
    _isOff = [CellValueKeyTool boolForKey:valueForKey];
    
}

@end
