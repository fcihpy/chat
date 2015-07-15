//
//  ChooseDatePicker.h
//  BussinessChat
//
//  Created by 郑南 on 15-7-9.
//  Copyright (c) 2015年 firstChedai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseDatePickerDelegate  <NSObject>

- (void)ChooseDatePickerReturnDate:(NSString *)returnDate;

@end

@interface ChooseDatePicker : UIView

@property (nonatomic,weak)id<ChooseDatePickerDelegate>delegate;

- (instancetype)initWithWindow:(UIWindow *)window andDelegate:(id)delegate andDateString:(NSString *)dateString;

@end
