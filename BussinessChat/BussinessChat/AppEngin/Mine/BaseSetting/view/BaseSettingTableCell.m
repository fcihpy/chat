//
//  BaseTableViewCell.m
//  BussinessChat
//
//  Created by zhisheshe on 15-3-29.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "BaseSettingTableCell.h"
#import "BaseCellItem.h"
#import "CellSwitchItem.h"
#import "CellArrowItem.h"
#import "CellLableItem.h"
#import "CellLableItem.h"
#import "CellLabelWithArrowItem.h"
#import "CellImgWithArrowItem.h"
#import "CellTextFeildItem.h"
#import "CellImgSubtitleItem.h"
#import <AssetsLibrary/AssetsLibrary.h>

const int cellMargin = 10;

@interface BaseSettingTableCell ()
{
    UIImageView     *_arrow;
    UISwitch        *_switch;
    UILabel         *_label;
    UITextField     *_textField;
    UIView          *_cellLabelArrowView;
    UIView          *_cellImgArrowView;
    UIView          *_divider;
    UILabel         *_arrowLabel;
    UIImageView     *_imgView;
}

@end

@implementation BaseSettingTableCell


+ (instancetype)settingCellWithTableView:(UITableView *)tableView{
    
    //用static修饰的局部变量，只会初始化一次
    static NSString *cellID = @"Cell";
    
    //.拿到一个标识先去缓存池中查找对应的Cell
    BaseSettingTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    //如果缓存池中没有，才需要传入一个标识创建新的Cell
    if (cell == nil) {
        cell = [[BaseSettingTableCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setCellBg];
        
        //设置子控制属性
        [self setupSubViews];
    
    }
    return self;
}


#pragma mark --- -----------------------------------------事件处理--------------------------------------
- (void)setCellitem:(BaseCellItem *)cellitem{
    _cellitem = cellitem;
    
    //设置数据
    CGRect headIconFrame;
    if (cellitem.icon) {
         headIconFrame =  CGRectMake(10, 10, 30, 30);
    }else{
        headIconFrame =  CGRectMake(10, 10, 0, 0);
    }
   
    MyLog(@"wsefawtawt%@",cellitem.icon);
    
    UIImageView *headIcon = [[UIImageView alloc]init];
    headIcon.image = [UIImage imageNamed:cellitem.icon];
    headIcon.frame = headIconFrame;
    [self addSubview:headIcon];
    
    CGFloat namelabelX = CGRectGetMaxX(headIconFrame) + 10;
    CGFloat namelabelY =  10;
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.frame = CGRectMake(namelabelX, namelabelY, 160, 30);
    nameLabel.text = cellitem.title;
    nameLabel.font = kKeyFont;
    nameLabel.textColor = kKeyColor;
    [self addSubview:nameLabel];
    
    CGFloat mobleLabelX = namelabelX;
    CGFloat mobleLabelY =  CGRectGetMaxY(nameLabel.frame);
    UILabel *mobleLabel = [[UILabel alloc]init];
    mobleLabel.frame = CGRectMake(mobleLabelX, mobleLabelY, 160, 30);
    mobleLabel.text = cellitem.subTitle;
    mobleLabel.font = kValueFont;
    mobleLabel.textColor = kValueColor;
    [self addSubview:mobleLabel];

   
    
    if ([cellitem isKindOfClass:[CellArrowItem class]]) {
        
        [self setCellArrow];
        
    }else if ([cellitem isKindOfClass:[CellLableItem class]]){
        
        [self setCelllabel];
        
    }else if ([cellitem isKindOfClass:[CellSwitchItem class]]){
        
        
        [self setCellSwitch];
        
    }else if ([cellitem isKindOfClass:[CellLabelWithArrowItem class]]){
        
        [self setLabelWithArrow];
        
    }else if ([cellitem isKindOfClass:[CellImgWithArrowItem class]]){
        
        [self setCellImg];
        
    }else if ([cellitem isKindOfClass:[CellTextFeildItem class]]){
        
        [self setCellTextFeild];
        
    }else if ([cellitem isKindOfClass:[CellImgSubtitleItem class]]){
        
        
        [self setCellPersonImg];
        
        
    }else{
        
        // 什么也没有，清空右边显示的view
        self.accessoryView = nil;
        
        // 用默认的选中样式
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    
}

- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}


#pragma mark  设置子控件属性
- (void)setupSubViews{
    
    self.textLabel.backgroundColor = kClearColor;
    self.textLabel.font = kKeyFont;
    
    self.detailTextLabel.backgroundColor = kClearColor;
    self.detailTextLabel.font = kValueFont;
}

#pragma mark - 设置CELL背景
- (void)setCellBg{
    
    // 1.默认
    UIView *bg = [[UIView alloc] init];
    self.backgroundView = bg;
    
    // 2.选中
    UIView *selectedBg = [[UIView alloc] init];
    selectedBg.backgroundColor =kButtonPreColor;
    self.selectedBackgroundView = selectedBg;
    
}

#pragma  mark --------------------------------------------添加控件--------------------------------

#pragma mark 设置右边的文本标签
- (void)setCelllabel{
    
    //初始化
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.bounds = CGRectMake(0, 0, 100, self.frame.size.height);
        _label.backgroundColor = kClearColor;
        _label.textAlignment = NSTextAlignmentRight;
        _label.textColor = kValueColor;
        _label.font = kValueFont;
        
    }
    
    //设置右边label的值
    CellLableItem *labelItem = (CellLableItem *)_cellitem;
    _label.text = labelItem.lablelText;
    
    //右边显示的内容
    self.accessoryView = _label;
    
    //禁止选中
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
}


#pragma mark 设置右边的开关
- (void)setCellSwitch{
    if (_switch == nil) {
        _switch = [[UISwitch alloc]init];
        [_switch addTarget:self action:@selector(switchChange) forControlEvents:UIControlEventValueChanged];
    }
    
    // 设置开关的状态
    CellSwitchItem *switchItem = (CellSwitchItem *)_cellitem;
    _switch.on = !switchItem.isOff;
   
    //右边显示的内容
    self.accessoryView = _switch;
    
    //禁止选中
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
}

#pragma mark 开关状态改变
- (void)switchChange{
    
    CellSwitchItem *switchItem = (CellSwitchItem *)_cellitem;
    switchItem.isOff =! _switch.on;
}

#pragma mark 设置右边的箭头
- (void)setCellArrow{
    
    if (_arrow == nil) {
        _arrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"list_arrowright"]];
        
    }

    // 右边显示箭头
    self.accessoryView = _arrow;
    
    // 用默认的选中样式
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    
}



#pragma mark 设置右边的文本框带右剪头
- (void)setLabelWithArrow{
    
    //初始化
    if (_cellLabelArrowView == nil) {
        _cellLabelArrowView = [[UIView alloc]initWithFrame:CGRectMake(120, 0, 200, self.frame.size.height)];

        
        UIImageView *arrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"list_arrowright"]];
        arrow.frame = CGRectMake(_cellLabelArrowView.frame.size.width - 12, 15, 12,12);
        
        UILabel  *arrowLabel = [[UILabel alloc] init];
        arrowLabel.frame = CGRectMake(0, 0, _cellLabelArrowView.frame.size.width - 12, self.frame.size.height);
        arrowLabel.textAlignment = NSTextAlignmentRight;
        arrowLabel.textColor = kValueColor;
        arrowLabel.font = kValueFont;
    
        _arrowLabel = arrowLabel;
    
        [_cellLabelArrowView addSubview:arrow];
        [_cellLabelArrowView addSubview:arrowLabel];
    }

  
    //设置右边label的值
    CellLableItem *labelItem = (CellLableItem *)_cellitem;
    _arrowLabel.text = labelItem.lablelText;
    

    //右边显示的内容
    self.accessoryView = _cellLabelArrowView;
   
    //禁止选中
    self.selectionStyle = UITableViewCellSelectionStyleDefault;

}


#pragma mark 设置右边的内像
- (void)setCellImg{
    if (_cellImgArrowView == nil) {
        _cellImgArrowView = [[UIView alloc]initWithFrame:CGRectMake(120, 0, 69, 66)];
        
        UIImageView  *imgView = [[UIImageView alloc] init];
        imgView.frame = CGRectMake(3, 5, 57, 57);
        imgView.backgroundColor = [UIColor redColor];
        imgView.layer.cornerRadius = 25;
        imgView.layer.masksToBounds = YES;
       
        _imgView = imgView;
        
        UIImageView *arrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"list_arrowright"]];
        arrow.frame = CGRectMake(_cellImgArrowView.frame.size.width - 12, 28, 12,12);

        [_cellImgArrowView addSubview:imgView];
//        [_cellImgArrowView addSubview:arrow];
    }
    
    //设置右边内容的值
    
    CellImgWithArrowItem *imgItem = (CellImgWithArrowItem *)_cellitem;
    
    if (imgItem.imgName) {
       
        [_imgView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imgItem.imgName]] placeholderImage:[UIImage imageNamed:@"chat_head"]];
        
    }if (imgItem.image) {
        _imgView.image = imgItem.image;
    }

    //右边显示的内容
    self.accessoryView = _cellImgArrowView;

    //禁止选中
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
   
}



#pragma mark 设置右边的textFeild
- (void)setCellTextFeild{
    
    if (_textField == nil) {
        _textField = [[UITextField alloc]init];
        _textField.font = kValueFont;
        _textField.textColor = kValueColor;
        _textField.textAlignment = NSTextAlignmentRight;
        _textField.bounds = CGRectMake(0, 220, 85, self.frame.size.height);
        
    }
    
    // 设置右边的值
    CellTextFeildItem *textFeildPlaceHold = (CellTextFeildItem *)_cellitem;
    _textField.placeholder = textFeildPlaceHold.placeHoldText;
    
    //右边显示的内容
    self.accessoryView = _textField;
    
    //禁止选中
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
}


- (void)setCellPersonImg{
    
    CellImgSubtitleItem *cellitem = (CellImgSubtitleItem *)_cellitem;
    
    CGRect headIconFrame =  CGRectMake(10, 10, 57, 57);

    UIImageView *headIcon = [[UIImageView alloc]init];
    [headIcon setImageWithURL:[NSURL URLWithString:cellitem.personIcon] placeholderImage:nil];
    headIcon.frame = headIconFrame;
    [self addSubview:headIcon];
    
    CGFloat namelabelX = CGRectGetMaxX(headIconFrame) + 10;
    CGFloat namelabelY =  10;
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.frame = CGRectMake(namelabelX, namelabelY, 160, 30);
    nameLabel.text = cellitem.personName;
    nameLabel.font = kKeyFont;
    nameLabel.textColor = kKeyColor;
    [self addSubview:nameLabel];
    
    CGFloat mobleLabelX = namelabelX;
    CGFloat mobleLabelY =  CGRectGetMaxY(nameLabel.frame);
    UILabel *mobleLabel = [[UILabel alloc]init];
    mobleLabel.frame = CGRectMake(mobleLabelX, mobleLabelY, 160, 30);
    mobleLabel.text = cellitem.personMobile;
    mobleLabel.font = kValueFont;
    mobleLabel.textColor = kValueColor;
    [self addSubview:mobleLabel];

    
    if (_arrow == nil) {
        _arrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"list_arrowright"]];
        
    }
    
    // 右边显示箭头
    self.accessoryView = _arrow;
    
}


#pragma mark --事件处理

- (void)headerLongPress:(UILongPressGestureRecognizer *)longPress{
    
    if (longPress.state == UIGestureRecognizerStateBegan) {
        if (_delegate && _indexPath && [_delegate respondsToSelector:@selector(cellImageViewLongPressAtIndexPath:)]) {
            
            [_delegate cellImageViewLongPressAtIndexPath:self.indexPath];
        }
    }
}


@end
