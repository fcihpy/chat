//
//  CellTextFeild.h
//  BussinessChat
//
//  Created by zhisheshe on 15-3-30.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "BaseCellItem.h"
#import "CellValueItem.h"

@interface CellTextFeildItem : CellValueItem

@property (nonatomic,copy) NSString *placeHoldText;      //右边默认显示的文字
@property (nonatomic,copy) NSString *textFeildText;      //右边显示的文字

@end
