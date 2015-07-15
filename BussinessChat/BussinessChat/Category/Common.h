//
//  Common.h
//  BussinessChat
//
//  Created by zhisheshe on 15-3-31.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Common : NSObject

+ (void)addBorderLine:(UIView *)view position:(NSString *)position;
+ (void)addBorderLine:(UIView *)view position:(NSString *)position clearBorderBeofreAdd:(bool)clearBorderBeforeAdd;

+ (void)addBorderLine:(UIView *)view position:(NSString *)position size:(float)size clearBorderBeofreAdd:(bool)clearBorderBeforeAdd;

+ (void)removeBorderLine:(UIView *)view;

+ (void)addSingleEvent:(UIView *)view target:(id)target action:(SEL)action;

@end
