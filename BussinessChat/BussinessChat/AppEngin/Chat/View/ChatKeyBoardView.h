//
//  ChatKeyBoardView.h
//  BusinessTalk
//
//  Created by WQY on 15-3-23.
//  Copyright (c) 2015年 WQY. All rights reserved.
//

#import <UIKit/UIKit.h>

#define inputViewHeight  36
#define inputViewWidth 200
#define VerticalPadding 5
#define HorizontalPadding 8

@protocol ChatKeyBoardViewDelegate <NSObject>

/**
 *  发送文字消息
 *  @param text 文字消息
**/
- (void)didSendText:(NSString *)text;

/**
 *  发送语言数据
 *
 *  @param data 语音数据
 */
- (void)didSendVoiceData:(NSData *)data;

/**
 *  计算键盘的高度，更改toolBar高度
 *  @param toHeight 更改toolBar的高度
**/
- (void)didChangeFrameToHeight:(CGFloat)toHeight;


@end
//////////////////////////////////////////////////////

@interface ChatKeyBoardView : UIView

@property(nonatomic,weak) id<ChatKeyBoardViewDelegate>delegate;

@property(nonatomic,strong) UIView * toolBarView;
@property(nonatomic,strong) UIButton * voiceBtn;             // 语音按钮
@property(nonatomic,strong) UIButton * voiceSenderBtn;       // 录音按钮
@property(nonatomic,strong) UITextView * inputTextView;      // 输入文本框
@property(nonatomic,strong) UIButton * faceBtn;              // 表情按钮
@property(nonatomic,strong) UIButton * moreBtn;             // 更多按钮及发送

@property (nonatomic) BOOL isShowButtomView;

- (id)initWithFrame:(CGRect)frame andSuperVC:(UIViewController *)superVC;

- (void)recoverKeyboard;

+(CGFloat)toolBarHeight;


@end


