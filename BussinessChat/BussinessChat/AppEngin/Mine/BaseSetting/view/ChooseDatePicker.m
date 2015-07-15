//
//  ChooseDatePicker.m
//  BussinessChat
//
//  Created by 郑南 on 15-7-9.
//  Copyright (c) 2015年 firstChedai. All rights reserved.
//

#import "ChooseDatePicker.h"
#include "Cover.h"
@interface ChooseDatePicker ()
{

    NSString *_presentDate;
    UIWindow *_myWinodw;
    UIDatePicker *_datePicker;
}

@end

@implementation ChooseDatePicker

- (instancetype)initWithWindow:(UIWindow *)window andDelegate:(id)delegate andDateString:(NSString *)dateString
{
    self = [super init];
    {
        _delegate = delegate;
        _presentDate = dateString;
        _myWinodw = window;
        self.frame = window.frame;
        [self createUI];
    }
    return self;

}

- (void)createUI
{
    //蒙层
    Cover *cover = [Cover coverWithTarget:self action:@selector(viewHidden)];
    cover.frame = _myWinodw.frame;
    [self addSubview:cover];
    
    NSDate *CurrnDate = [[NSDate alloc]init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *resultDate;
    if([_presentDate isEqualToString:@""] || _presentDate == nil)
    {
        resultDate = [dateFormatter stringFromDate:CurrnDate];
    }
    else
    {
        resultDate = _presentDate;
    }
    NSDate *tempDate = [dateFormatter dateFromString:resultDate];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSDate *mindate=[dateFormatter dateFromString:@"1950-01-01"];
    
    _datePicker = [[UIDatePicker alloc] init];
    _datePicker.center = self.center;
    _datePicker.backgroundColor=[UIColor whiteColor];
    [_datePicker setLocale:locale];
    [_datePicker setMaximumDate:CurrnDate];
    [_datePicker setMinimumDate:mindate];
    [_datePicker setDate:tempDate animated:YES];
    [_datePicker setDatePickerMode:UIDatePickerModeDate];
    [_datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_datePicker];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(screenW/2-50, _datePicker.frame.origin.y+_datePicker.frame.size.height+20, 100, 30)];
    [btn setTitle:@"确 定" forState:0];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn setTitleColor:[UIColor lightGrayColor] forState:0];
    [btn addTarget:self action:@selector(cilck) forControlEvents:UIControlEventTouchUpInside];
    [cover addSubview:btn];
    
    [_myWinodw addSubview:self];

}
- (void)datePickerValueChanged:(UIDatePicker*)datePicker
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    _presentDate = [dateFormatter stringFromDate:datePicker.date];

}

- (void)cilck
{
    [self.delegate ChooseDatePickerReturnDate:_presentDate];
    [self viewHidden];

}

/**
 *  移除View
 */
- (void)viewHidden
{
    [self removeFromSuperview];
}

@end
