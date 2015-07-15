//
//  AddFriendView.m
//  BussinessChat
//
//  Created by WQY on 15-5-5.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "AddFriendCoverView.h"
#import "Cover.h"
#import "AddFriendViewController.h"

#define Icon_Height 80

typeof(id) bSelf;

@implementation AddFriendCoverView

-(id)initWithFrame:(CGRect)frame delegate:(id)delegate window:(UIWindow *)window{
    if (self = [super initWithFrame:frame]) {
        
        bSelf = self;
        
        //蒙层
        Cover *cover = [Cover coverWithTarget:delegate action:@selector(viewHidden)];
        cover.frame = window.frame;
        [self addSubview:cover];
        
        
        UIView * bgView = [[UIView alloc ] initWithFrame:CGRectMake(0, 0, screenW, Icon_Height)];
        [bgView setBackgroundColor:[UIColor whiteColor]];
        [bgView setAlpha:0.9];
        [self addSubview:bgView];
        
        UIView * line = [[UIView alloc ] initWithFrame:CGRectMake(screenW / 2.0, 0, 1, Icon_Height)];
        [line setBackgroundColor:[UIColor lightGrayColor]];
        [line setAlpha:0.7];
        [bgView addSubview:line];
        

        //添加好友
        
        UIImageView * addFriendView = [[UIImageView alloc ] initWithImage:[UIImage imageNamed:@"chat_add friends"]];
        addFriendView.frame = CGRectMake(((screenW / 2.0 - 44) / 2.0), 10, 44, 44);
        addFriendView.alpha = 1;
        [FCUitility addSingleEvent:addFriendView target:delegate action:@selector(addFriends)];
        [bgView addSubview:addFriendView];
        

        UILabel * addFriendLabel = [[UILabel alloc ] initWithFrame:CGRectMake(((screenW / 2.0 - 44) / 2.0), 60, 44, 10)];
        addFriendLabel.text = @"添加好友";
        addFriendLabel.font = kFont11;
        [bgView addSubview:addFriendLabel];
        
        
        //群聊
        UIImageView * addGroupView = [[UIImageView alloc ] initWithImage:[UIImage imageNamed:@"chat_addgroup"]];
        addGroupView.frame = CGRectMake((screenW / 2.0 - 44 + screenW)/ 2.0  , 10, 44, 44);
        addGroupView.alpha = 1;
        [FCUitility addSingleEvent:addGroupView target:delegate action:@selector(addGroups)];
        [bgView addSubview:addGroupView];
        
        UILabel * addGroupLabel = [[UILabel alloc ] initWithFrame:CGRectMake((screenW / 2.0 - 44 + screenW)/ 2.0, 60, 44, 10)];
        addGroupLabel.text = @"发起群聊";
        addGroupLabel.font = kFont11;
        [bgView addSubview:addGroupLabel];
        
    }
    return self;
}


@end
