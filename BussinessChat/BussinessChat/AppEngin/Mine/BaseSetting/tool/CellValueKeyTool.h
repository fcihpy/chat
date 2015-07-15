//
//  CellValueKeyTool.h
//  BussinessChat
//
//  Created by zhisheshe on 15-3-29.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellValueKeyTool : NSObject


+ (id)objectForKey:(NSString *)keyName;
+ (void)setObject:(id)value forKey:(NSString *)keyName;

+ (BOOL)boolForKey:(NSString *)keyName;
+ (void)setBool:(BOOL)value forKey:(NSString *)keyName;

@end
