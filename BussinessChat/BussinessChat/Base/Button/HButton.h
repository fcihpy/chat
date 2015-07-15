//
//  HButton.h
//  pinchehui
//
//  Created by zhisheshe on 15-1-22.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//  //水平button

#import <UIKit/UIKit.h>

@interface HButton : UIButton


#pragma mark -设置item不同状态时的文字title
- (void)setNormalTitle:(NSString *)normalTitle selectTitle:(NSString *)selectTitle;

#pragma mark -设置item不同状态时的图片
- (void)setIcon:(NSString *)icon    selectIcon:(NSString *)selectIcon;




@end
