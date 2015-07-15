//
//  SuperBaseCell.h
//  BussinessChat
//
//  Created by 郑南 on 15-7-7.
//  Copyright (c) 2015年 firstChedai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCellModel.h"
@interface SuperBaseCell : UITableViewCell

#define kCellContentFont 13.0    // 字体大小

#define kCellTitleFont 14.0
#define kCellSubTitleFont 14.0
#define kCellContentIconSize 35  // 图标大小
#define kCellContentPhotoSize 50 // 头像大小
#define kCellElementGap 10


@property (nonatomic,strong) BaseCellModel *cellModel;

@property (nonatomic,strong) UILabel *cellCotentLabel;
@property (nonatomic,strong) UILabel *cellTitle;
@property (nonatomic,strong) UILabel *cellSubTitle;
@property (nonatomic,strong) UIImageView *cellCotentPhoto;
@property (nonatomic,strong) UIImageView *cellCotentIcon;


@end
