//
//  VButton.h
//  pinchehui
//
//  Created by zhisheshe on 15-1-22.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//  垂直button

#import <UIKit/UIKit.h>

@interface VButton : UIButton


#pragma mark -设置item不同状态时的图片
- (void)setIcon:(NSString *)icon    selectIcon:(NSString *)selectIcon;

#pragma mark -设置item不同状态时的文字title
- (void)setNormalTitle:(NSString *)normalTitle selectTitle:(NSString *)selectTitle;


#pragma mark -设置item不同状态时的文字颜色
- (void)setNormalTitleColor:(UIColor *)normalTitleColor selectTitleColor:(UIColor *)selectTitleColor;


@end
