//
//  TabbarItem.h
//  车商官家
//
//  Created by zhisheshe on 14-11-6.
//  Copyright (c) 2014年 zhisheshe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabbarItem : UIButton

@property (nonatomic) int index;

#pragma mark -设置item不同状态时的文字title
- (void)setTitle:(NSString *)title;

#pragma mark -设置item不同状态时的图片
- (void)setIcon:(NSString *)icon    selectIcon:(NSString *)selectIcon;


@end
