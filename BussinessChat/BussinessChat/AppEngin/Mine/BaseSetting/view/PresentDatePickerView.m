//
//  PresentDatePickerView.m
//  车商官家
//
//  Created by wangkebo on 14-10-30.
//  Copyright (c) 2014年 wangkebo. All rights reserved.
//

#import "PresentDatePickerView.h"

@implementation PresentDatePickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setSubviews];
    }
    return self;
}

- (void)setSubviews
{
    self.backgroundColor = [UIColor clearColor];
    
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, screenH)];
    _topView.backgroundColor = [UIColor blackColor];
    _topView.alpha = 0.5;
    [self addSubview:_topView];
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    [_topView addGestureRecognizer:tapGesture];
    
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 568, 320, 204+44)];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_bottomView];
    
    //toolbar
    _toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
//    _toolBar.barStyle = UIBarStyleBlackTranslucent;
    _toolBar.backgroundColor = [UIColor grayColor];
    
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(110, 0, 100, 44)];
    lab.text = @"请选择";
    lab.font = [UIFont boldSystemFontOfSize:20];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = [UIColor blackColor];
    UIBarButtonItem * titleButton = [[UIBarButtonItem alloc]initWithCustomView:lab];
    
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 50, 44);
    [rightButton setTitle:@"确定" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(clickOK) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    
    UIBarButtonItem *leftButton  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *fixedButton  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    NSArray *array = [[NSArray alloc] initWithObjects:leftButton,fixedButton,titleButton,fixedButton,rightBarButton,nil];
    [_toolBar setItems: array];
    
    
    [_bottomView addSubview:_toolBar];
    
    
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, 0, 0)];
    _datePicker.backgroundColor = [UIColor whiteColor];
    _datePicker.tag = 100;
    NSLocale * locale = [[NSLocale alloc] initWithLocaleIdentifier:@"Chinese"];
    [_datePicker setLocale:locale];
    
//    _datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:-60*60*24*365*10];
//    _datePicker.maximumDate = [NSDate dateWithTimeIntervalSinceNow:60*60*24*365*10];
    
    _datePicker.datePickerMode = UIDatePickerModeDate;
    [_bottomView addSubview:_datePicker];
}


-(void)setCurrentTag:(int)currentTag
{
    _currentTag = currentTag;
    if (currentTag == 1) {
        _datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:-60*60*24*365*15];
        _datePicker.maximumDate = [NSDate date];
    }else if (currentTag == 2){
        _datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:-60*60*24*365*6];
        _datePicker.maximumDate = [NSDate dateWithTimeIntervalSinceNow:60*60*24*365*6];
    }
    _datePicker.date = [NSDate date];
}

- (void)clickOK
{
    NSDate * date = [_datePicker date];
    //上传用的
    NSDateFormatter * dateFormatter= [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];//location设置为中国
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    dateFormatter.dateStyle = kCFDateFormatterNoStyle;
    NSString * time = [dateFormatter stringFromDate:date];
    
    //显示用的
    NSDateFormatter * dateFormatter1= [[NSDateFormatter alloc] init];
    [dateFormatter1 setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];//location设置为中国
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
    NSString * time1 = [dateFormatter1 stringFromDate:date];
    
    NSDictionary * timeDict = [NSDictionary dictionaryWithObjectsAndKeys:time1,@"showTime",time,@"upLoadTime", nil];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"choosedTime" object:nil userInfo:timeDict];
    [self done];
}

- (void)done
{
    _topView.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.3 animations:^(void){
        self.bottomView.frame = CGRectMake(0, 568, 0, 0);
    }completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
}

- (void)tapGesture:(UITapGestureRecognizer *)tap
{
    _topView.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.3 animations:^(void){
        self.bottomView.frame = CGRectMake(0, 568, 0, 0);
    }completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
