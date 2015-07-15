//
//  PresentDatePickerView.h
//  车商官家
//
//  Created by wangkebo on 14-10-30.
//  Copyright (c) 2014年 wangkebo. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface PresentDatePickerView : UIView

@property (strong, nonatomic) UIView * topView;
@property (strong, nonatomic) UIView * bottomView;
@property (strong, nonatomic) UIToolbar * toolBar;
@property (strong, nonatomic) UIDatePicker * datePicker;

@property (nonatomic) int currentTag;

@end
