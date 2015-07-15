//
//  BaseTableViewCell.h
//  BussinessChat
//
//  Created by zhisheshe on 15-3-29.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//


#import <UIKit/UIKit.h>

@class BaseSettingTableCell;

@protocol BaseTableCellDelegate <NSObject>

- (void)cellImageViewLongPressAtIndexPath:(NSIndexPath *)indexPath;

@end





///////////////////////////////////////////////////////////////

@class BaseCellItem;

@interface BaseSettingTableCell : UITableViewCell

{
    UILongPressGestureRecognizer *_headerLongPress;
}


@property (nonatomic,weak)    id<BaseTableCellDelegate> delegate;

@property (nonatomic, strong) BaseCellItem              *cellitem;

@property (nonatomic,copy)    NSString                  *placeHolderStr;
@property (nonatomic, strong) NSIndexPath               *indexPath;
@property (strong, nonatomic) UIView                    *bottomLineView;


+ (instancetype)settingCellWithTableView:(UITableView *)tableView;

@end
