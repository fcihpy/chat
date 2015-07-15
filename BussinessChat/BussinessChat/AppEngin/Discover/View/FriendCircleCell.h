//
//  FriendCircleCell.h
//  BussinessChat
//
//  Created by zhisheshe on 15-4-9.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendCircleCellFrameModel.h"

@interface FriendCircleCell : UITableViewCell

@property (nonatomic,strong) FriendCircleCellFrameModel *CellFrameModel;


@property (nonatomic,weak) UILabel *name;
@property (nonatomic,strong) UIImageView *headImgView;;
@property (strong, nonatomic) UILabel *contentLabel;
@property (nonatomic,assign) long long indexpath;   //TAGID
@property (nonatomic) NSInteger indexPathRow;

+ (instancetype)settingCellWithTableView:(UITableView *)tableView;
@end
