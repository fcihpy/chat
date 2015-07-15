//
//  AddressCell.h
//  BussinessChat
//
//  Created by zhisheshe on 15-4-24.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"



@interface AddressCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIButton *statusBtn;


@property (nonatomic,strong) AddressModel *model;


+ (UINib *)loadNib;

-(void)initWithDelegate:(id)delegate;

@end
