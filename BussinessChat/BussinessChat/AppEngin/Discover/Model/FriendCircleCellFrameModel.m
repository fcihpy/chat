//
//  FriendCircleCellFrameModel.m
//  BussinessChat
//
//  Created by zhisheshe on 15-4-9.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "FriendCircleCellFrameModel.h"

@implementation FriendCircleCellFrameModel

- (void)setCellModel:(FriendCircleModel *)cellModel{
    
    _cellModel = cellModel;
    
    //根据model数据，计算出所在子控件的frame
    
    // 1.头像
    CGFloat headX = kCellBorderWidth;
    CGFloat headY = kCellBorderWidth;
    _headFrame = CGRectMake(headX, headY, 40, 40);
    
    // 2.昵称
    CGFloat screenNameX = CGRectGetMaxX(_headFrame) + kCellBorderWidth;
    CGFloat screenNameY = kCellBorderWidth;
    
    CGSize screenNameSize = [cellModel.username sizeWithAttributes:@{NSFontAttributeName:kKeyFont}];
    _screenNameFrame = (CGRect){{screenNameX, screenNameY}, screenNameSize};
    
    
    //发布时间
    CGFloat  publishTimeX = screenW - 70;
    CGFloat  publishTimeY = kCellBorderWidth;
    CGSize publishTimeSize = [cellModel.publishTime sizeWithAttributes:@{NSFontAttributeName:kValueFont}];
    _publishTimeFrame = (CGRect){{publishTimeX, publishTimeY}, publishTimeSize};

    
    //内容
    CGFloat contentX = screenNameX;
    CGFloat contentY = CGRectGetMaxY(_screenNameFrame)  + 10;
    NSString *content = cellModel.content;
    CGSize contentSize = [content boundingRectWithSize:CGSizeMake(screenW - 3*kCellBorderWidth - _headFrame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kValueFont} context:nil].size;
    
    _contentFrame = (CGRect){{contentX , contentY}, contentSize};
    
    //交互view
    
    CGFloat interActionX = screenW - 66- 10;
    CGFloat interActionY = CGRectGetMaxY(_contentFrame)  + 10;
    _interActionFrame = CGRectMake(interActionX,interActionY, 66, 24);
    
    
    //pinglunView
    CGFloat pinglunX = screenNameX;
    CGFloat pinglunY = CGRectGetMaxY(_interActionFrame)  + 10;
    _pinglunFrame = CGRectMake(pinglunX,pinglunY, _contentFrame.size.width, 80);
    
    
    
    // 11.整个cell的高度
    _cellHeight = CGRectGetMaxY(_pinglunFrame)+ 10 ;

    
}

@end
