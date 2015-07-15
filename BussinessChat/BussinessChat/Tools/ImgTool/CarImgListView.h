//
//  CarImgListView.h
//  pinchehui
//
//  Created by zhisheshe on 15-1-29.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
// 配图列表 1-9

#import <UIKit/UIKit.h>

@interface CarImgListView : UIView

//所有图片的url
@property (nonatomic,strong) NSArray *imagUrls;

+ (CGSize)imageListSizeWithCount:(NSInteger)count;

@end
