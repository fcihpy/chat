//
//  LoginView.h
//  BusinessTalk
//
//  Created by WQY on 15-3-25.
//  Copyright (c) 2015年 WQY. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewDelegate <NSObject>

@end


@interface LoginView : UIView

@property(nonatomic,weak) id<LoginViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame delegate:(id)delegate;

@end

