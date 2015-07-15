//
//  FCKeybordToobar.h
//  BussinessChat
//
//  Created by zhisheshe on 15-4-9.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface FCKeybordToobar : NSObject{
    
    UIToolbar       *_toobarview;                       //工具条
    NSArray         *textFields;                 //输入框数组
    BOOL            _allowShowPreAndNext;         //是否显示上一项、下一项
    BOOL            _isInNavigationController;    //是否在导航视图中
    UIBarButtonItem *_prevButtonItem;             //上一项按钮
    UIBarButtonItem *_nextButtonItem;             //下一项按钮
    UIBarButtonItem *_hiddenButtonItem;           //隐藏按钮
    UIBarButtonItem *_spaceButtonItem;            //空白按钮
    UITextField     *_currentTextField;           //当前输入框
}

@property(nonatomic,retain) UIToolbar *toobarview; //工具条


-(id)init;
-(void)setAllowShowPreAndNext:(BOOL)isShow;
-(void)setIsInNavigationController:(BOOL)isbool;
-(void)setTextFieldsArray:(NSArray *)array;
-(void)showPrevious;
-(void)showNext;
-(void)showBar:(UITextField *)textField;
-(void)HiddenKeyBoard;

@end
