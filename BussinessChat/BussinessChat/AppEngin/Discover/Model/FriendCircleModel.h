//
//  FriendCircleModel.h
//  BussinessChat
//
//  Created by zhisheshe on 15-4-9.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendCircleModel : BaseModel


@property (nonatomic,assign) long long ID;     //信息 id
@property (copy, nonatomic) NSString * uid;     //userid
@property (copy, nonatomic) NSString * username;   // username
@property (copy, nonatomic) NSString * avatar_url;   // 头像url

@property (copy, nonatomic) NSString * content;         //   求购内容
@property (copy, nonatomic) NSString * add_time;        //   发布时间
@property (copy, nonatomic) NSString * publishTime;        //   发布时间


@property (copy, nonatomic) NSString * pic;             //   照片

@property (nonatomic, strong) NSMutableArray *picUrls; // 求购配图


@property (copy, nonatomic) NSString * pl;              //   评论
@property (nonatomic, assign) int commentsCount; // 评论数
@property (nonatomic, assign) int repostsCount; // 转发数



@end
