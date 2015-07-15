//
//  CustomKeyBoard.h
//  BussinessChat
//
//  Created by WQY on 15-4-1.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomKeyBoardDelegate <NSObject>

//@param toHeight 更改toolBar的高度
- (void)didChangeFrameToHeight:(CGFloat)toHeight;

@end



@interface CustomKeyBoard : UIView

enum TextKeyBoardType {
    kNumberKeyBoard = 0,
    kDefaultKeyBoard = 1,
    kToolBarKeyBoard = 2,
};

@property(nonatomic,weak)  id<CustomKeyBoardDelegate>delegate;
@property(nonatomic) NSInteger style;


- (id)initWithFrame:(CGRect)frame style:(NSInteger )style changeFrame:(BOOL)changeFrame delegate:(id)delegate;

@end


