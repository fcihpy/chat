//
//  Common.m
//  BussinessChat
//
//  Created by zhisheshe on 15-3-31.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "Common.h"

@implementation Common



+ (void)addBorderLine:(UIView *)view position:(NSString *)position {
    [self addBorderLine:view position:position clearBorderBeofreAdd:YES];
}

+ (void)addBorderLine:(UIView *)view position:(NSString *)position clearBorderBeofreAdd:(bool)clearBorderBeforeAdd {
    [self addBorderLine:view position:position size:0.5 clearBorderBeofreAdd:clearBorderBeforeAdd];
}

+ (void)addBorderLine:(UIView *)view position:(NSString *)position size:(float)size clearBorderBeofreAdd:(bool)clearBorderBeforeAdd {
    if (clearBorderBeforeAdd) {
        [self removeBorderLine:view];
    }
    CALayer *bbLine = [CALayer layer];
    bbLine.name = [NSString stringWithFormat:@"%@", view.layer];
    
    bbLine.frame = CGRectMake(0, [position isEqualToString:@"top"] ? 0 : view.frame.size.height - size, view.frame.size.width, size);
    if ([position isEqualToString:@"left"]) {
        bbLine.frame = CGRectMake(0, 0, size, view.frame.size.height);
    } else if ([position isEqualToString:@"right"]) {
        bbLine.frame = CGRectMake(view.frame.size.width - size, 0, size, view.frame.size.height);
    }
    
    bbLine.backgroundColor = kLineColor.CGColor;
    [view.layer addSublayer:bbLine];
}

+ (void)removeBorderLine:(UIView *)view {
    NSArray *subLayers = [view.layer sublayers];// 因为这个subLayers也包含了subviews的layers
    NSString *name = [NSString stringWithFormat:@"%@", view.layer];
    for(int i = subLayers.count - 1; i >= 0; i--) {
        CALayer * layer = [[view.layer sublayers] objectAtIndex:i];
        if ([layer.name isEqualToString:name]) {
            [layer removeFromSuperlayer];
        }
    }
}

+ (void)addSingleEvent:(UIView *)view target:(id)target action:(SEL)action {
    if (view != nil) {
        for(UIGestureRecognizer *recognizer in view.gestureRecognizers) {
            [view removeGestureRecognizer:recognizer];
        }
        [view setUserInteractionEnabled:YES];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
        singleTap.delegate = target;
        singleTap.numberOfTapsRequired = 1;
        singleTap.numberOfTouchesRequired = 1;
        [view addGestureRecognizer:singleTap];
    }
}




@end
