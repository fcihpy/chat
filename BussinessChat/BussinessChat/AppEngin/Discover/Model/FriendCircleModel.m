//
//  FriendCircleModel.m
//  BussinessChat
//
//  Created by zhisheshe on 15-4-9.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "FriendCircleModel.h"

@implementation FriendCircleModel

- (id)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        self.ID = [[dict valueForKey:@"id"] longLongValue];
        self.uid = [dict valueForKey:@"uid"];

        self.content = [dict valueForKey:@"content"];
        self.add_time = [dict valueForKey:@"add_time"];
        self.username = [dict valueForKey:@"username"];
        self.avatar_url = [dict valueForKey:@"avatar_url"];

        
        
        //解析图片URL
        NSDictionary *picdict = [NSDictionary dictionary];
        self.picUrls = [NSMutableArray array];
        NSString *imgurl;
        NSArray *arry = [dict valueForKey:@"pic"];
        
        if (arryAndDicIsNotNull(arry)) {
            for (int i = 0 ; i < arry.count; i ++) {
                picdict = arry[i];
                if (arryAndDicIsNotNull(picdict)) {
                    imgurl = picdict[@"img"];
                    [self.picUrls addObject:imgurl];
                }
                
            }
        }

        
    }
    return self;
}
@end
