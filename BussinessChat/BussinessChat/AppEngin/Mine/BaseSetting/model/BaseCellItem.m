//
//  BaseCellItem.m
//  BussinessChat
//
//  Created by zhisheshe on 15-3-29.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "BaseCellItem.h"




@implementation BaseCellItem

+ (id)itemWithIcon:(NSString *)icon  title:(NSString *)title subTitle:(NSString *)subtitle{
    
    BaseCellItem *item = [[self alloc]init];
    item.icon = icon;
    item.title = title;
    item.subTitle = subtitle;
  
    return item;
   
}

+ (id)itemWithIcon:(NSString *)icon title:(NSString *)title{
    
    return [self itemWithIcon:icon title:title subTitle:nil];
}

+ (id)itemWithTitle:(NSString *)title{
    
    return [self itemWithIcon:nil title:title subTitle:nil];
}


+ (id)itemWithPersonIcon:(NSString *)personIcon name:(NSString *)personName mobile:(NSString *)personMobile{
    
    BaseCellItem *item = [[self alloc]init];
    item.personIcon = personIcon;
    item.personName = personName;
    item.personMobile = personMobile;
    return  item;
    
}


@end
