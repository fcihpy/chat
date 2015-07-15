//
//  Cover.h
//  车商官家
//
//  Created by zhisheshe on 14-11-6.
//  Copyright (c) 2014年 zhisheshe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cover : UIView 

+ (id)cover;
+ (id)coverWithTarget:(id)target action:(SEL)action;

- (void)reset;

@end
