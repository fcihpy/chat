//
//  CellValueItem.h
//  BussinessChat
//
//  Created by zhisheshe on 15-3-29.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

/*
 需要存储数据的cellitem都继承他
 */

#import "BaseCellItem.h"
#import "CellValueKeyTool.h"

@interface CellValueItem : BaseCellItem

@property (nonatomic,copy) NSString *valueForKey;       //存储数据用的key
@end
