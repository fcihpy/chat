//
//  FriendCircleCell.m
//  BussinessChat
//
//  Created by zhisheshe on 15-4-9.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "FriendCircleCell.h"

@interface FriendCircleCell (){
    
    UILabel *_screenNamelLabel;
    UILabel * _publishTimeLabel;

    UIImageView *_contentBackView;
    UIView *_interActionView;
    UIImageView *_pinglunView;
}

@end

@implementation FriendCircleCell


+ (instancetype)settingCellWithTableView:(UITableView *)tableView{
    
    //用static修饰的局部变量，只会初始化一次
    static NSString *cellID = @"Cell";
    
    //.拿到一个标识先去缓存池中查找对应的Cell
    FriendCircleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    //如果缓存池中没有，才需要传入一个标识创建新的Cell
    if (cell == nil) {
        cell = [[FriendCircleCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        
        //添加所需控件
        [self addSubViews];
    
    }
    
    return self;
}

#pragma mark -添加所需控件
- (void)addSubViews{
    
    // 1.头像
    _headImgView = [[UIImageView alloc]init];
    _headImgView.layer.cornerRadius = 20;
    _headImgView.layer.masksToBounds = YES;
    _headImgView.userInteractionEnabled = YES;
    [self.contentView addSubview:_headImgView];
 
    // 2.昵称
    _screenNamelLabel = [[UILabel alloc] init];
    _screenNamelLabel.font = kKeyFont;
    _screenNamelLabel.textColor = kNameColor;
    [self.contentView addSubview:_screenNamelLabel];
    
 
    //3、发布时间
    _publishTimeLabel = [[UILabel alloc]init];
    _publishTimeLabel.backgroundColor = [UIColor clearColor];
    _publishTimeLabel.textAlignment = NSTextAlignmentRight;
    _publishTimeLabel.font = kValueFont;
    _publishTimeLabel.textColor = kValueColor;
    [self.contentView addSubview:_publishTimeLabel];
    
  
    
    // 4.内容
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.numberOfLines = 0;
    _contentLabel.layer.borderColor = [UIColor clearColor].CGColor;
    _contentLabel.textAlignment = NSTextAlignmentLeft;
    _contentLabel.font = kValueFont;
    _contentLabel.userInteractionEnabled = YES;
    _contentLabel.textColor = kKeyColor;
    [self.contentView addSubview:_contentLabel];

    //5、交互view
    _interActionView = [[UIView alloc]init];
//    _interActionView.backgroundColor = [UIColor redColor];
    UIButton *collectBtn = [[UIButton alloc]init];
    collectBtn.frame = CGRectMake(0, 0, 26, 24);
    [collectBtn setImage:[UIImage imageNamed:@"discover_friendCircle_collect"] forState:UIControlStateNormal];
    
    UIButton *commuitBtn = [[UIButton alloc]init];
    commuitBtn.frame = CGRectMake(66-26, 0, 26, 24);
    [commuitBtn setImage:[UIImage imageNamed:@"discover_friendCircle_comment"] forState:UIControlStateNormal];
    [_interActionView addSubview:collectBtn];
    [_interActionView addSubview:commuitBtn];
    
    [self.contentView addSubview:_interActionView];
    
    //6、评论
    
    _pinglunView = [[UIImageView alloc]initWithFrame:CGRectZero];
    _pinglunView.image = [[UIImage imageNamed:@"discover_friendCircle_pingLunView"] stretchableImageWithLeftCapWidth:100 topCapHeight:20];
    _pinglunView.userInteractionEnabled = YES;
    [self.contentView addSubview:_pinglunView];
    
    
    // 7.配图
//    _carImgView = [[CarImgListView alloc]init];
//    _carImgView.layer.cornerRadius = 5;
//    [self.contentView addSubview:_carImgView];
    
}

- (void)setCellFrameModel:(FriendCircleCellFrameModel *)CellFrameModel{
    
    _CellFrameModel = CellFrameModel;
    FriendCircleModel *model = CellFrameModel.cellModel;
    
    // 1.头像
    _headImgView.frame = CellFrameModel.headFrame;
    _headImgView.image = [UIImage imageNamed:@"chat_head"];
//    [_headImgView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.avatar_url]] placeholderImage:[UIImage imageNamed:@"carResourcePlace"] options:SDWebImageRetryFailed | SDWebImageLowPriority];
    
    // 2.昵称
    _screenNamelLabel.frame = CellFrameModel.screenNameFrame;
    _screenNamelLabel.text = model.username;
//     _screenNamelLabel.text = @"asdgasfaweawgwggagagagafawf";
    //    _screenNamelLabel.text = [[PurchaseTool getPersonModel:model.uid] username];
    
    
    
    //发布时间
    _publishTimeLabel.frame = CellFrameModel.publishTimeFrame;
    _publishTimeLabel.text = model.publishTime;
    
    //交互view
    _interActionView.frame = CellFrameModel.interActionFrame;
    
    
    
    // 4.内容
    _contentLabel.frame = CellFrameModel.contentFrame;
    _contentLabel.text = model.content;
    
    
    // 5.配图
    //    if (model.picUrls > 0) {
    //        _carImgView.hidden = NO;
    //        _carImgView.frame = purchaseCellFrameModel.carImgFrame;
    //        _carImgView.imagUrls = model.picUrls;
    //
    //    }else{
    //        _carImgView.hidden = YES;
    //    }

     //6、评论
    _pinglunView.frame = CellFrameModel.pinglunFrame;
    
}

- (void)setFrame:(CGRect)frame{
    
    
    //    frame.origin.x = kTableBorderWidth;
    frame.origin.y += kCellMargin;
    frame.size.height -= kCellMargin;
    //    frame.size.width = 320 - kTableBorderWidth *2;
    [super setFrame:frame];
}

@end
