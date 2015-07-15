//
//  SuperBaseCell.m
//  BussinessChat
//
//  Created by 郑南 on 15-7-7.
//  Copyright (c) 2015年 firstChedai. All rights reserved.
//

#import "SuperBaseCell.h"


@interface SuperBaseCell ()
{
//    UITextField *_cellCotentLabel;
//    UILabel *_cellTitle;
//    UILabel *_cellSubTitle;
//    UIImageView *_cellCotentPhoto;
//    UIImageView *_cellCotentIcon;
}

@end

@implementation SuperBaseCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if(style)
    {
        _cellCotentLabel = [[UILabel alloc]init];
        _cellCotentLabel.textAlignment = NSTextAlignmentRight;
        _cellCotentLabel.font = [UIFont systemFontOfSize:kCellContentFont];
        [self.contentView addSubview:_cellCotentLabel];
        
        _cellCotentIcon = [[UIImageView alloc]init];
        [self.contentView addSubview:_cellCotentIcon];
        
        _cellCotentPhoto = [[UIImageView alloc]init];
        [self.contentView addSubview:_cellCotentPhoto];
        
        _cellTitle = [[UILabel alloc]init];
        _cellTitle.font = [UIFont systemFontOfSize:kCellTitleFont];
        [self.contentView addSubview:_cellTitle];
        
        _cellSubTitle = [[UILabel alloc]init];
        _cellSubTitle.font = [UIFont systemFontOfSize:kCellSubTitleFont];
        [self.contentView addSubview:_cellSubTitle];

        UIView *view = [[UIView alloc]init];
        self.selectedBackgroundView = view;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)setCellModel:(BaseCellModel *)cellModel
{
    self.textLabel.text = cellModel.cellTitle;
    self.detailTextLabel.text = cellModel.cellSubTitle;
    self.imageView.image = cellModel.cellIcon;
    if(!cellModel.cellAccessoryView)
    {
        // 默认显示箭头
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else
    {
        self.accessoryView = cellModel.cellAccessoryView;
    }
    
    CGSize contentSize;
    CGSize subContentSize;
    BOOL isContentNull = YES;

    switch (cellModel.cellType) {
            
        case cellTypeItemLabel:
            
            if([cellModel.cellContent isEqualToString:@""] || cellModel.cellContent==nil)
            {
                isContentNull = NO;
                
            }
            _cellCotentLabel.text = isContentNull?cellModel.cellContent:[NSString stringWithFormat:@"请输入%@",self.textLabel.text];
            contentSize = [_cellCotentLabel.text sizeWithFont:_cellCotentLabel.font constrainedToSize:CGSizeMake(250, 30)];
            _cellCotentLabel.frame = CGRectMake(self.frame.size.width - 30 - contentSize.width, (self.frame.size.height - contentSize.height)/2, contentSize.width, contentSize.height);
            break;
            
        case cellTypeItemImagePhoto:
            
           
            _cellTitle.text = self.textLabel.text;
            _cellSubTitle.text = self.detailTextLabel.text;
            self.textLabel.text = nil;
            self.detailTextLabel.text = nil;
     
            _cellCotentPhoto.image = cellModel.cellContentPhoto?cellModel.cellContentPhoto:[UIImage imageNamed:@"chat_head"];
            _cellCotentPhoto.frame = CGRectMake(kCellElementGap, 10, kCellContentPhotoSize, kCellContentPhotoSize);
            
            contentSize = [_cellTitle.text sizeWithFont:_cellTitle.font constrainedToSize:CGSizeMake(250, 30)];
            _cellTitle.frame = CGRectMake(3*kCellElementGap + kCellContentPhotoSize, 10, contentSize.width, contentSize.height);
            
            subContentSize = [_cellSubTitle.text sizeWithFont:_cellSubTitle.font];
            _cellSubTitle.frame = CGRectMake(3*kCellElementGap + kCellContentPhotoSize, 40, subContentSize.width, subContentSize.height);
            
            break;
            
        case cellTypeItemImageIcno:
            
            _cellCotentIcon.image = cellModel.cellContentIcon?cellModel.cellContentIcon:[UIImage imageNamed:@"chat_head"];
            _cellCotentIcon.frame = CGRectMake(self.frame.size.width - 5 - 2*kCellContentIconSize , 10, kCellContentIconSize, kCellContentIconSize);
            
            break;
        default:
            break;
    }

}

@end
