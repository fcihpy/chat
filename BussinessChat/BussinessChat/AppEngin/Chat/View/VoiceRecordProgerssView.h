//
//  VoiceRecordProgerssView.h
//  BussinessChat
//
//  Created by 郑南 on 15-7-3.
//  Copyright (c) 2015年 firstChedai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VoiceRecordProgerssView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;

+ (void)show;

+ (void)dismissWithSuccess:(NSString *)str;

+ (void)dismissWithError:(NSString *)str;

+ (void)changeSubTitle:(NSString *)str;

@end
