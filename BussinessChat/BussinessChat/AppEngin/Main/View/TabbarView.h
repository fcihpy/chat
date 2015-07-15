//
//  TabbarView.h
//  车商官家
//
//  Created by zhisheshe on 14-11-6.
//  Copyright (c) 2014年 zhisheshe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabbarItem.h"
@class TabbarView;

#pragma mark - 设置代理，用于对用户item选择的获取
@protocol TabbarViewDelegate <NSObject>

@optional
- (void)TabbarView:(TabbarView *)TabbarView   fromBarItem:(NSUInteger)fromBarItem   toBarItem:(NSUInteger)toBarItem;

@end



@interface TabbarView : UIView
{
    TabbarItem *_selectItem;
    UILabel *_unreadLabel;
     UIImageView * redPointImageView;
}

@property(nonatomic,weak) id<TabbarViewDelegate> delegate;

@property (nonatomic) NSInteger unreadCount;
@property (nonatomic) NSInteger moneyMessageCount;  //红包消息数量


@end
