//
//  CellValueKeyTool.m
//  BussinessChat
//
//  Created by zhisheshe on 15-3-29.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//



#import "CellValueKeyTool.h"

@implementation CellValueKeyTool



+ (id)objectForKey:(NSString *)keyName{
    
    return [kUserDefaults objectForKey:keyName];
}

+ (void)setObject:(id)value forKey:(NSString *)keyName{
    [kUserDefaults setObject:value forKey:keyName];
    [kUserDefaults synchronize];
    
}

+ (BOOL)boolForKey:(NSString *)keyName{
    
    return [kUserDefaults boolForKey:keyName];
}
+ (void)setBool:(BOOL)value forKey:(NSString *)keyName{
    
    [kUserDefaults setBool:value forKey:keyName];
    [kUserDefaults synchronize];
}


@end
