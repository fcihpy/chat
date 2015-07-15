//
//  Cover.m
//  车商官家
//
//  Created by zhisheshe on 14-11-6.
//  Copyright (c) 2014年 zhisheshe. All rights reserved.
//

#import "Cover.h"

//#define kAlpha 0.6
#define kAlpha 0.3

@interface Cover ()<UIGestureRecognizerDelegate>

@end

@implementation Cover

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // 1.背景色
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        
        // 2.自动伸缩
//        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
    }
    return self;
}

- (void)reset
{
    self.alpha = kAlpha;
}

+ (id)cover
{
    return [[self alloc] init];
}

+ (id)coverWithTarget:(id)target action:(SEL)action
{
    Cover *cover = [self cover];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:action];
    tap.delegate = self;
    [cover addGestureRecognizer:tap];

    return cover;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    
    return YES;
}

@end
