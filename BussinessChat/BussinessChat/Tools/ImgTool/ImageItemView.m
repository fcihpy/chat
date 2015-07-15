//
//  ImageItemView.m
//  pinchehui
//
//  Created by zhisheshe on 15-1-27.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "ImageItemView.h"


@interface ImageItemView()
{
    UIImageView *_gifView;
}
@end

@implementation ImageItemView

// init
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *gifView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gif.png"]];
        [self addSubview:gifView];
        _gifView = gifView;
        
    }
    return self;
}

- (void)setUrl:(NSString *)url
{
    _url = url;
    
    // 1.加载图片
    [self setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",url]]];

    
    // 2.是否为gif
    _gifView.hidden = ![url.lowercaseString hasSuffix:@"gif"];

}


- (void)setFrame:(CGRect)frame
{
    // 1.设置gifView的位置
    CGRect gifFrame = _gifView.frame;
    gifFrame.origin.x = frame.size.width - gifFrame.size.width - 2;
    gifFrame.origin.y =  frame.size.height - gifFrame.size.height - 2;
    _gifView.frame = gifFrame;
    
    [super setFrame:frame];
}

@end
