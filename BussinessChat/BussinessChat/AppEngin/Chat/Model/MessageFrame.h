//
//  MessageFrame.h
//  ChatTest
//
//  Created by 郑南 on 15-7-2.
//  Copyright (c) 2015年 test. All rights reserved.
//


#define ChatMargin 10       //间隔
#define ChatIconWH 44       //头像宽高height、width
#define ChatPicWH 200       //图片宽高
#define ChatContentW 180    //内容宽度

#define ChatTimeMarginW 15  //时间文本与边框间隔宽度方向
#define ChatTimeMarginH 10  //时间文本与边框间隔高度方向

#define ChatContentTop 10   //文本内容与按钮上边缘间隔
#define ChatContentLeft 20  //文本内容与按钮左边缘间隔
#define ChatContentBottom 10 //文本内容与按钮下边缘间隔
#define ChatContentRight 15 //文本内容与按钮右边缘间隔

#define ChatTimeFont [UIFont systemFontOfSize:13]   //时间字体
#define ChatContentFont [UIFont systemFontOfSize:17]//内容字体


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MessageModel;

@interface MessageFrame : NSObject

@property (nonatomic,assign,readonly) CGRect nameF;
@property (nonatomic,assign,readonly) CGRect iconF;
@property (nonatomic,assign,readonly) CGRect timeF;
@property (nonatomic,assign,readonly) CGRect contentF;
@property (nonatomic,assign,readonly) CGFloat cellHeight;

@property (nonatomic,strong) MessageModel *message;
@property (nonatomic,assign) BOOL showTime;

@end
