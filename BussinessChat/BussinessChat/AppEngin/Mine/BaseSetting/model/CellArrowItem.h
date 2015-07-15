//
//  CellArrowItem.h
//  BussinessChat
//
//  Created by zhisheshe on 15-3-29.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//
//箭头ITEM

#import "BaseCellItem.h"
#import "CellValueItem.h"

@interface CellArrowItem : CellValueItem

@property (nonatomic,assign) Class pushVCClass;    // 即将显示的控制器的类名

@end
