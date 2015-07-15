//
//  UIView+FC.h
//  bussinessChat
//
//  Created by zhisheshe on 15-3-25.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FC)


// 扩展属性
@property(nonatomic, strong) NSString *info;
@property(nonatomic, strong) NSString *id;

- (void)setX:(CGFloat)x;
- (void)setY:(CGFloat)y;
- (void)setWidth:(CGFloat)w;
- (void)setHeight:(CGFloat)h;
- (CGFloat)getRight:(bool)snap;
- (CGFloat)getBottom:(bool)snap;

// 自动调整高度
- (void)autoHeight:(int)maxLine;

- (void)autoHeight0:(int)maxLine;

- (void)autoLabelHeight;

- (UIView *)parents:(Class)pClass;
- (NSArray *)children:(Class)pClass;

- (UIView *)getByTag:(NSString *)tag;
- (UILabel *)findByLabel:(NSString *)label;


- (void)UITitle;
- (void)UISubTitle;

- (void)addBorderLine:(NSString *)position;

- (void)addBorderLine:(NSString *)position clearBorderBeofreAdd:(bool)clearBorderBeforeAdd;

- (void)addBorderLine:(NSString *)position size:(int)size clearBorderBeofreAdd:(bool)clearBorderBeforeAdd;

- (void)removeBorderLine;

- (void)addBadge:(NSString *)num point:(CGPoint)point;

- (void)addBadge:(NSString *)num point:(CGPoint)point badgePadding:(int)badgePadding;

- (void)removeBadge;

- (bool)hasBadge;

//////
- (UIView *)viewWithTagWithoutSelf:(NSInteger)tag;

- (void)removeAllSubviews;

- (void)hideAllSubviews;

- (void)setViewLayerWithBackGroudColor:(UIColor *)color;

//
/**
* 对一个View增加border
* @position bottom , top
*/



@end
