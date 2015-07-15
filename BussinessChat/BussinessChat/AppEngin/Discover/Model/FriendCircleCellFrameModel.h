//
//  FriendCircleCellFrameModel.h
//  BussinessChat
//
//  Created by zhisheshe on 15-4-9.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FriendCircleModel.h"

@interface FriendCircleCellFrameModel : NSObject

@property (nonatomic,strong) FriendCircleModel *cellModel;   //模型数据


@property (nonatomic, readonly) CGFloat cellHeight; // Cell的高度

@property (nonatomic, readonly) CGRect headFrame; // 头像的frame

@property (nonatomic, readonly) CGRect screenNameFrame; // 昵称的frame

@property (nonatomic, readonly) CGRect contentFrame; //内容的frame

@property (nonatomic, readonly) CGRect carImgFrame; // 配图的frame


@property (nonatomic, readonly) CGRect interActionFrame; // 交互的Viewframe

@property (nonatomic, readonly) CGRect pinglunFrame;    //pinglun的Viewframe

@property (nonatomic, readonly) CGRect publishTimeFrame;   //发布时间frame

@end
