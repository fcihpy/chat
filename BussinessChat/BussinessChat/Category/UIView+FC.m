//
//  UIView+FC.m
//  bussinessChat
//
//  Created by zhisheshe on 15-3-25.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "UIView+FC.h"
#import <objc/runtime.h>
#import "NSString+FC.h"

@implementation UIView (FC)


- (void)setX:(CGFloat)x {
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}

- (void)setY:(CGFloat)y {
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

- (void)setWidth:(CGFloat)w {
    CGRect rect = self.frame;
    rect.size.width = w;
    self.frame = rect;
}

- (void)setHeight:(CGFloat)h {
    CGRect rect = self.frame;
    rect.size.height = h;
    self.frame = rect;
}


- (CGFloat)getRight:(bool)snap {
    if (snap && [self isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)self;
        return self.frame.origin.x + [label.text sizeWithFont:label.font].width;
    }
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)getBottom:(bool)snap {
    if (snap && [self isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)self;
        return self.frame.origin.y + [label.text sizeWithFont:label.font].height;
    }
    return self.frame.origin.y + self.frame.size.height;
}

- (void)autoHeight:(int)maxLine {
    if ([self isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)self;
        // 一行能容纳多少个字
        //        int numberOfFont = (int) (label.frame.size.width / 14);
        //        int line = label.text.length / numberOfFont + [label.text componentsSeparatedByString:@"\n"].count;
        //        if (maxLine > 0 && line > maxLine) line = maxLine;
        //        label.numberOfLines = line;
        //        label.lineBreakMode = NSLineBreakByCharWrapping;
        //        label.text = [NSString stringWithFormat:@"%@\n\n\n\n\n\n\n\n\n\n", label.text];
        //        [label setHeight:line * 20];
        [label autoLabelHeight];
    }
}

- (void)autoHeight0:(int)maxLine {
    if ([self isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)self;
        // 一行能容纳多少个字
        int numberOfFont = (int) (label.frame.size.width / 14);
        int line = label.text.length / numberOfFont + [label.text componentsSeparatedByString:@"\n"].count;
        if (maxLine > 0 && line > maxLine) line = maxLine;
        label.numberOfLines = line;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        [label setHeight:line * 18];
    }
}

- (void)autoLabelHeight {
    if ([self isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)self;
        if ([NSString isBlank:label.text]) {
            [label setHeight:10];
            return;
        }
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByCharWrapping;
        [label setHeight:0];
        @try {
            NSRange range = NSMakeRange(0, label.attributedText.length);
            CGSize size = [label.text boundingRectWithSize:label.bounds.size
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:[label.attributedText
                                                            attributesAtIndex:0 effectiveRange:&range] context:nil].size;
            [label setHeight:size.height];
        }@catch (NSException *e) {
            [self autoHeight0:-1];
            
        }
    }
}

- (UIView *)parents:(Class)pClass {
    UIView *me = self;
    while (![me.superview isKindOfClass:pClass]) {
        me = me.superview;
    }
    return me.superview;
}

- (NSArray *)children:(Class)pClass {
    NSMutableArray *array = [NSMutableArray array];
    NSArray *subviews = self.subviews;
    for(UIView *view in subviews) {
        if ([view isKindOfClass:pClass]) {
            [array addObject:view];
        }
    }
    return array;
}

- (UIView *)getByTag:(NSString *)tag {
    NSArray *depths = [tag componentsSeparatedByString:@"."];
    UIView *result = self;
    for(NSString *d in depths) {
        result = [result viewWithTagWithoutSelf:[d intValue]];
    }
    return result;
}

- (UILabel *)findByLabel:(NSString *)label {
    NSArray *array = self.subviews;
    for(UIView *view in array) {
        if ([view isKindOfClass:[UILabel class]] && [((UILabel *)view).text isEqualToString:label]) {
            return (UILabel *)view;
        }
        UILabel *result = [view findByLabel:label];
        if (result) {
            return result;
        }
    }
    return nil;
}

//////////////

static const NSInteger kViewIdKey = 1;
static const NSInteger kViewId2Key = 2;
- (void)setInfo:(NSString *)aInfo {
    objc_setAssociatedObject(self, &kViewIdKey, aInfo, OBJC_ASSOCIATION_COPY);
}

- (NSString *)info {
    return (NSString *)objc_getAssociatedObject(self, &kViewIdKey);
}
- (void)setId:(NSString *)aId {
    objc_setAssociatedObject(self, &kViewId2Key, aId, OBJC_ASSOCIATION_COPY);
}

- (NSString *)id {
    return (NSString *)objc_getAssociatedObject(self, &kViewId2Key);
}

- (void)UITitle {
    if ([self isKindOfClass:[UILabel class] ]) {
        UILabel *label = (UILabel *)self;
//        label.textColor = COLOR_DEEP_TEXT;
        label.font = kFont14;
        label.backgroundColor = [UIColor clearColor];
    }
}
- (void)UISubTitle {
    if ([self isKindOfClass:[UILabel class] ]) {
        UILabel *label = (UILabel *)self;
//        label.textColor = COLOR_TIPS_TEXT;
        label.font = kFont12;
    }
}

- (void)addBorderLine:(NSString *)position {
    [self addBorderLine:position clearBorderBeofreAdd:YES];
}

- (void)addBorderLine:(NSString *)position clearBorderBeofreAdd:(bool)clearBorderBeforeAdd {
    [self addBorderLine:position size:1 clearBorderBeofreAdd:clearBorderBeforeAdd];
}

- (void)addBorderLine:(NSString *)position size:(int)size clearBorderBeofreAdd:(bool)clearBorderBeforeAdd {
    if (clearBorderBeforeAdd) {
        [self removeBorderLine];
    }
    CALayer *bbLine = [CALayer layer];
    bbLine.name = [NSString stringWithFormat:@"%@", self.layer];
    
    bbLine.frame = CGRectMake(0, [position isEqualToString:@"top"] ? 0 : self.frame.size.height - size, self.frame.size.width, size);
    if ([position isEqualToString:@"left"]) {
        bbLine.frame = CGRectMake(0, 0, size, self.frame.size.height);
    } else if ([position isEqualToString:@"right"]) {
        bbLine.frame = CGRectMake(self.frame.size.width - size, 0, size, self.frame.size.height);
    }
    
//    bbLine.backgroundColor = COLOR_LINE.CGColor;
    [self.layer addSublayer:bbLine];
}

- (void)removeBorderLine {
    NSArray *subLayers = [self.layer sublayers];// 因为这个subLayers也包含了subviews的layers
    NSString *name = [NSString stringWithFormat:@"%@", self.layer];
    for(int i = subLayers.count - 1; i >= 0; i--) {
        CALayer * layer = [[self.layer sublayers] objectAtIndex:i];
        if ([layer.name isEqualToString:name]) {
            [layer removeFromSuperlayer];
        }
    }
}

- (void)addBadge:(NSString *)num point:(CGPoint)point {
    [self addBadge:num point:point badgePadding:4];
}
- (void)addBadge:(NSString *)num point:(CGPoint)point badgePadding:(int)badgePadding {
    if ([@"0" isEqualToString:num]) {
        [self removeBadge];
        return;
    }
    int tag = 9999;
    if ([NSString toInt:num] > 99) num = @"99+";
    UILabel *badge = (UILabel *) [self viewWithTagWithoutSelf:tag];
    if (badge) [badge removeFromSuperview];
    badge = [[UILabel alloc] initWithFrame:CGRectMake(point.x, point.y, 0, 0)];
    badge.text = num;
    badge.font = kFont12;
//    badge.textColor = COLOR_TEXT_WHITE;
    badge.backgroundColor = [UIColor redColor];
    badge.textAlignment = NSTextAlignmentCenter;
    [badge sizeToFit];
    badge.tag = tag;
    [self addSubview:badge];
    
    CGSize expectedLabelSize = badge.frame.size;
    CGFloat minHeight = expectedLabelSize.height;
    CGFloat minWidth = expectedLabelSize.width;
    int minSize = badgePadding * 2;
    minHeight = (minHeight < minSize) ? minSize : expectedLabelSize.height;
    CGFloat padding = badgePadding;
    
    minWidth = (minWidth < minHeight) ? minHeight : expectedLabelSize.width;
    badge.frame = CGRectMake(point.x, point.y, minWidth + padding, minHeight + padding);
    badge.layer.cornerRadius = (minHeight + padding) / 2;
    badge.layer.masksToBounds = YES;
}

- (void)removeBadge {
    int tag = 9999;
    UILabel *badge = (UILabel *) [self viewWithTagWithoutSelf:tag];
    if (badge) [badge removeFromSuperview];
}

- (bool)hasBadge {
    int tag = 9999;
    UILabel *badge = (UILabel *) [self viewWithTagWithoutSelf:tag];
    return badge ? true : false;
}

/////

- (UIView *)viewWithTagWithoutSelf:(NSInteger)tag {
    for (UIView *view in self.subviews) {
        if (view.tag == tag && ![view isKindOfClass:[CALayer class]]) return view;
    }
    return nil;
}

- (void)removeAllSubviews {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

- (void)hideAllSubviews {
    for(UIView *view in self.subviews) {
        view.hidden = YES;
    }
}


- (void)setViewLayerWithBackGroudColor:(UIColor *)color{
    
    self.backgroundColor = color;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 0.5;
    self.layer.cornerRadius = 5;
}



//


@end
