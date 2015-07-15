//
//  BaseCellModel.h
//  BussinessChat
//
//  Created by 郑南 on 15-7-7.
//  Copyright (c) 2015年 firstChedai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum
{
    cellTypeItemDefault =0 ,    // 默认
    cellTypeItemLabel,       // 文字
    cellTypeItemImagePhoto, // 相片图片
    cellTypeItemImageIcno, // 图标图片

}cellTypeItem;

@interface BaseCellModel : NSObject

@property (nonatomic,assign) cellTypeItem cellType;      // 类型
@property (nonatomic,copy) NSString *cellTitle;        // 标签
@property (nonatomic,copy) NSString *cellSubTitle;     // 副标签
@property (nonatomic,strong) UIView   *cellAccessoryView;   // cell尾标
@property (nonatomic,strong) UIImage  *cellIcon;


@property (nonatomic,copy) NSString *cellContent;      // 内容
@property (nonatomic,strong) UIImage  *cellContentPhoto;  // 内容图片
@property (nonatomic,strong) UIImage  *cellContentIcon;   // 内容图标
@property (nonatomic,strong) UIViewController *cellPustVC; // 跳转页面
@property (nonatomic,strong) void (^cellClick)();        //回调Cell点击方法

// 添加标题
- (instancetype)initWithTitle:(NSString *)cellTitle;


@end
