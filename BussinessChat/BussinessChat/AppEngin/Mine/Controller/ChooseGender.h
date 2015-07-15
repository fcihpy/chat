//
//  ChooseGender.h
//  BussinessChat
//
//  Created by zhisheshe on 15-4-7.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseGenderDelegate <NSObject>

- (void)ChooseGenderReturnStr:(NSString *)returnStr;

@end

@interface ChooseGender : UIView

@property (nonatomic,weak) id<ChooseGenderDelegate> delegate;

-(id)initWithFrame:(CGRect)frame delegate:(id)delegate window:(UIWindow *)window gender:(NSString *)gender;

@end
