//
//  ChatKeyBoardView.m
//  BusinessTalk
//
//  Created by WQY on 15-3-23.
//  Copyright (c) 2015年 WQY. All rights reserved.
//

#import "ChatKeyBoardView.h"
#import "Constant.h"
#import "XMPP.h"
#import "XmppHelper.h"
#import "VoiceRecordProgerssView.h"
#import "Mp3Recorder.h"
@interface ChatKeyBoardView ()<UITextViewDelegate,Mp3RecorderDelegate>
{
    UIViewController *_superVC;
    UIView *_view;
    NSInteger _playTime;
    NSTimer *_timer;
    Mp3Recorder *_MP3;
}

@end

@implementation ChatKeyBoardView

- (id)initWithFrame:(CGRect)frame andSuperVC:(UIViewController *)superVC;
{
    self = [super initWithFrame:frame];
    if (self) {
        _superVC = superVC;
        [self setStyleWithFrame];
    }
    return self;
    
}
-(UIView *)toolBarView{
    
    if (_toolBarView == nil) {
        _toolBarView = [[UIView alloc ] init];
        _toolBarView.layer.borderWidth = 1;
        _toolBarView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _toolBarView.backgroundColor = COLOR(241, 241, 241, 1);
    }
    return _toolBarView;
}

-(void)setStyleWithFrame{
    _toolBarView = [[UIView alloc ] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, VerticalPadding * 2 + inputViewHeight)];
    [_toolBarView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.toolBarView];
    
    // 录音文件
    _MP3 = [[Mp3Recorder alloc]initWithDelegate:self];
    
    // 语言按钮
    _voiceBtn = [[UIButton alloc ] initWithFrame:CGRectMake(HorizontalPadding, VerticalPadding, inputViewHeight, inputViewHeight)];
     [_voiceBtn setImage:[UIImage imageNamed:@"chat_sound"] forState:UIControlStateNormal];
    [_voiceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_voiceBtn addTarget:self action:@selector(voiceBtnCilck) forControlEvents:UIControlEventTouchUpInside];
    [_toolBarView addSubview:_voiceBtn];
    
    // 录音按钮
    _voiceSenderBtn = [[UIButton alloc]initWithFrame:CGRectMake(HorizontalPadding * 3 + inputViewHeight, VerticalPadding, SCREEN_SIZE.width - inputViewHeight*3 - HorizontalPadding *5, inputViewHeight)];
    [_voiceSenderBtn setTitle:@"按住请讲话" forState:UIControlStateNormal];
    [_voiceSenderBtn setTitle:@"发送" forState:UIControlStateHighlighted];
    [_voiceSenderBtn addTarget:self action:@selector(beginVoiceClick) forControlEvents:UIControlEventTouchDown];
    [_voiceSenderBtn addTarget:self action:@selector(enVoiceClick) forControlEvents:UIControlEventTouchUpInside];
    [_voiceSenderBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _voiceSenderBtn.backgroundColor = [UIColor yellowColor];
    _voiceSenderBtn.hidden = YES;
    [_toolBarView addSubview:_voiceSenderBtn];
    
    // 输入文本消息
    _inputTextView = [[UITextView alloc ] initWithFrame:CGRectMake(HorizontalPadding * 2 + inputViewHeight, VerticalPadding, SCREEN_SIZE.width - inputViewHeight * 3 - HorizontalPadding * 5, inputViewHeight)];
    [_inputTextView setFont:[UIFont systemFontOfSize:15]];
    _inputTextView.scrollEnabled = YES;
    _inputTextView.returnKeyType = UIReturnKeySend;
    _inputTextView.enablesReturnKeyAutomatically = YES; // UITextView内部判断send按钮是否可以用
    _inputTextView.delegate = self;
    _inputTextView.backgroundColor = [UIColor clearColor];
    _inputTextView.layer.borderColor = [UIColor colorWithWhite:0.8f alpha:1.0f].CGColor;
    _inputTextView.layer.borderWidth = 0.65f;
    _inputTextView.layer.cornerRadius = 6.0f;
    [self addSubview:_inputTextView];
    
    // 表情按钮
    _faceBtn = [[UIButton alloc ] initWithFrame:CGRectMake(SCREEN_SIZE.width - inputViewHeight * 2 - HorizontalPadding * 2, VerticalPadding, inputViewHeight, inputViewHeight)];
    [_faceBtn setImage:[UIImage imageNamed:@"chat_face"] forState:UIControlStateNormal];
    [_faceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_faceBtn addTarget:self action:@selector(faceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_toolBarView addSubview:_faceBtn];
    
    _view = [[UIView alloc]initWithFrame:CGRectMake(0,0,screenW, 200)];
    _view.backgroundColor = [[UIColor redColor]colorWithAlphaComponent:0.5];

    
    // 发送及更多
    _moreBtn = [[UIButton alloc ] initWithFrame:CGRectMake(SCREEN_SIZE.width - inputViewHeight -HorizontalPadding, VerticalPadding, inputViewHeight, inputViewHeight)];
    [_moreBtn setImage:[UIImage imageNamed:@"chat_more"] forState:UIControlStateNormal];
    [_moreBtn setImage:[UIImage imageNamed:@"chat_Send"] forState:UIControlStateHighlighted];
    _moreBtn.highlighted = NO;
    [_moreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_toolBarView addSubview:_moreBtn];
    
    // 键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}


#pragma mark ------------------- UIKeyboardNotification
- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    _moreBtn.highlighted = NO;
    
    NSDictionary *userInfo = notification.userInfo;
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        CGRect fromFrame = self.frame;
        self.frame = CGRectMake(fromFrame.origin.x,endFrame.origin.y-46-64, fromFrame.size.width, fromFrame.size.height);
        [self.delegate didChangeFrameToHeight:self.frame.origin.y];
    }];
}


#pragma mark -------------- change frame
- (void)willShowBottomHeight:(CGFloat)bottomHeight
{
    CGRect fromFrame = self.frame;
    CGFloat toHeight = self.toolBarView.frame.size.height + bottomHeight;
    CGRect toFrame = CGRectMake(fromFrame.origin.x, fromFrame.origin.y + (fromFrame.size.height - toHeight), fromFrame.size.width, toHeight);
    //如果需要将所有扩展页面都隐藏，而此时已经隐藏了所有扩展页面，则不进行任何操作
    if(bottomHeight == 0 && self.frame.size.height == self.toolBarView.frame.size.height)
    {
        return;
    }
    
    if (bottomHeight == 0) {
        self.isShowButtomView = NO;
    }
    else{
        self.isShowButtomView = YES;
    }
    
    self.frame = toFrame;
    if (_delegate && [_delegate respondsToSelector:@selector(didChangeFrameToHeight:)]) {
        [_delegate didChangeFrameToHeight:toHeight];
    }
}

- (void)willShowKeyboardFromFrame:(CGRect)beginFrame toFrame:(CGRect)toFrame
{
    if (beginFrame.origin.y == [[UIScreen mainScreen] bounds].size.height)
    {
        // 键盘开启，传入：253高度
        [self willShowBottomHeight:toFrame.size.height];
    }
    else if (toFrame.origin.y == [[UIScreen mainScreen] bounds].size.height)
    {
        // 键盘收起
        [self willShowBottomHeight:0];
    }
    else{
        [self willShowBottomHeight:toFrame.size.height];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        if ([self.delegate respondsToSelector:@selector(didSendText:)]) {
            [self.delegate didSendText:textView.text];
            self.inputTextView.text = @"";
        }
        
        return NO;
    }
  
       return YES;
}


- (void)textViewDidChange:(UITextView *)textView
{

    if (textView.text.length >0) {
        _moreBtn.highlighted = YES;
    }else {
        _moreBtn.highlighted = NO;
    }

}

+(CGFloat)toolBarHeight{
    
    return inputViewHeight + VerticalPadding * 2;
}

#pragma mark   -----------------复原keyBoard-----------------------------
- (void)recoverKeyboard
{
    _faceBtn.selected = NO;
    _faceBtn.backgroundColor = [UIColor whiteColor];
    _inputTextView.inputView = UIKeyboardAppearanceDefault;
    [self endEditing:YES];
    
}

#pragma mark -------------------BtnAction-按钮事件------------------------

- (void)faceBtnClick
{
    _faceBtn.selected = !_faceBtn.selected;
    if(_faceBtn.selected)
    {
        [_inputTextView resignFirstResponder];
        _inputTextView.inputView = _view;
        [_inputTextView becomeFirstResponder];
        _faceBtn.backgroundColor = [UIColor redColor];
    }
    else
    {
        _faceBtn.backgroundColor = [UIColor whiteColor];
        [_inputTextView resignFirstResponder];
        _inputTextView.inputView = UIKeyboardAppearanceDefault;
        [_inputTextView becomeFirstResponder];

    }
    
}



- (void)voiceBtnCilck
{
    _inputTextView.hidden = !_inputTextView.hidden;
    _moreBtn.hidden = !_moreBtn.hidden;
    _faceBtn.hidden = !_faceBtn.hidden;
    _voiceSenderBtn.hidden = !_voiceSenderBtn.hidden;
    [self recoverKeyboard];
    
    _voiceBtn.selected = !_voiceBtn.selected;
    if(_voiceBtn.selected)
    {
        [_voiceBtn setBackgroundColor:[UIColor redColor]];
    }
    else
    {
        [_voiceBtn setBackgroundColor:[UIColor clearColor]];
    }
}

#pragma mark -录音事件
- (void)beginVoiceClick
{
    _playTime = 0;
    [_MP3 startRecord];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countVoiceTime) userInfo:nil repeats:YES];
    [VoiceRecordProgerssView show];
}
- (void)enVoiceClick
{
    if(_timer)
    {
        [_MP3 stopRecord];
        [_timer invalidate];
        _timer = nil;
    }
    [VoiceRecordProgerssView dismissWithError:@"取消"];
}

- (void)countVoiceTime
{
    _playTime++;
    if(_playTime>=60)
    {
        [self enVoiceClick];
    }
}

#pragma mark -MP3Recorder代理方法

// 成功录音
- (void)endConvertWithData:(NSData *)voiceData
{
    [VoiceRecordProgerssView dismissWithSuccess:@"完成"];
    if([self.delegate respondsToSelector:@selector(didSendVoiceData:)])
    {
        [self.delegate didSendVoiceData:voiceData];
    }
    
    _voiceSenderBtn.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _voiceSenderBtn.enabled = YES;
    });
    
}


// 录音失败
- (void)failRecord
{
    [VoiceRecordProgerssView dismissWithError:@"时间太短"];
    _voiceSenderBtn.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _voiceSenderBtn.enabled = YES;
    });
    
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter ] removeObserver:self];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self recoverKeyboard];
}

@end
