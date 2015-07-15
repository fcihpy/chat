//
//  CellImgSubtitleItem.h
//  BussinessChat
//
//  Created by zhisheshe on 15-4-8.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

//#import "BaseCellItem.h"
#import <Foundation/Foundation.h>
#import "CellValueItem.h"
@class BaseCellItem;

@interface CellImgSubtitleItem : BaseCellItem

@property (nonatomic,assign) Class pushVCClass;    // 即将显示的控制器的类名
@property (nonatomic,copy) NSString *hqqqeader; // 头部标题


@end
