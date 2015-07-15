//
//  EditPersonInfoController.h
//  BussinessChat
//
//  Created by zhisheshe on 15/6/18.
//  Copyright (c) 2015年 firstChedai. All rights reserved.
//

#import "BaseViewController.h"
#import "PersonInfoModel.h"

@interface EditPersonInfoController : BaseViewController

@property (nonatomic,strong) NSString *editTitle;
@property (nonatomic,strong) PersonInfoModel *personInfo;
@property (nonatomic,weak)   UILabel *editText;

@end
