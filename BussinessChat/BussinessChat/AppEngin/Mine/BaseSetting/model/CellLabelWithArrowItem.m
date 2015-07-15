//
//  CellLabelWithArrowItem.m
//  BussinessChat
//
//  Created by zhisheshe on 15-3-29.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "CellLabelWithArrowItem.h"
#import "CellValueKeyTool.h"

@implementation CellLabelWithArrowItem

- (void)setLablelText:(NSString *)lablelText{
    _lablelText = lablelText;
    
    // 归档
//    [CellValueKeyTool setObject:lablelText forKey:self.valueForKey];
    

}

- (void)setValueForKey:(NSString *)valueForKey{
//    [super setValueForKey:valueForKey];
    
    //读档
//    _lablelText = [CellValueKeyTool objectForKey:valueForKey];
    
}


@end
