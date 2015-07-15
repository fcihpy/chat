//
//  CellLabelWithArrowItem.h
//  BussinessChat
//
//  Created by zhisheshe on 15-3-29.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellValueItem.h"

@interface CellLabelWithArrowItem : BaseCellItem


@property (nonatomic,assign) Class pushVCClass;    // 即将显示的控制器的类名
@property (nonatomic,copy) NSString *lablelText;      //右边显示的文字


@end
