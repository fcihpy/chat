//
//  CustomKeyBoard.m
//  BussinessChat
//
//  Created by WQY on 15-4-1.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "CustomKeyBoard.h"
#import "FCConstant.h"


typeof(id) bself;
@interface CustomKeyBoard()<UITextFieldDelegate,UITextViewDelegate>
@end

@implementation CustomKeyBoard

- (id)initWithFrame:(CGRect)frame style:(NSInteger)style changeFrame:(BOOL)changeFrame delegate:(id)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        _style = style;
        bself = delegate;
        if (style == kNumberKeyBoard) {
            [self creatNumberKeyBoard:changeFrame];
        }else if (style == kDefaultKeyBoard){
            [self creatEnglishKeyBoard:changeFrame];
        }else if (style == kToolBarKeyBoard){
            //            [self creatKeyBoard:delegate];
        }
        
    }
    return self;
}

//创建数字键盘
-(void)creatNumberKeyBoard:(BOOL)changeFrame{
    [self changeFrame:changeFrame];
    UITextField * textField = [[UITextField alloc ] initWithFrame:CGRectZero];
    textField.tag = 101;
    [textField setKeyboardType:UIKeyboardTypeNumberPad];
    [textField becomeFirstResponder];
    textField.delegate = self;
    [self addSubview:textField];
}

//创建UIKeyboardTypeDefault样式键盘
-(void)creatEnglishKeyBoard:(BOOL)changeFrame{
    [self changeFrame:changeFrame];
    UITextView * textView = [[UITextView alloc ] initWithFrame:CGRectZero];
    textView.tag = 102;
    [textView setKeyboardType:UIKeyboardTypeDefault];
    [textView becomeFirstResponder];
    textView.delegate = self;
    [self addSubview:textView];
    
}

-(void)changeFrame:(BOOL)changeFrame{
    if (changeFrame == YES) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
}



#pragma mark --------------------------------------------------UITextViewDelegate---------------------------------------------------------------------------
- (void)textViewDidChange:(UITextView *)textView{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"setNickName" object:textView.text];
}


#pragma  mark ----------------------------------------------- TextFieldDelegate--------------------------------------------------------------------------------

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([string isEqualToString:@"\n"]){
        return YES;
    }
    
    if (_style == kNumberKeyBoard) {
        
        if ([textField.text stringByReplacingCharactersInRange:range withString:string].length <= 11) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"setMobile" object:[textField.text stringByReplacingCharactersInRange:range withString:string]];
            return YES;
            
        }else{
            //提示只能输入11位数
            return NO;
        }
    }
    return YES;
}



-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    //给键盘增加工具条
    UIToolbar *keyBoradToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 33)];
    keyBoradToolbar.backgroundColor = [UIColor grayColor];
    
    
    //定义两个flexibleSpace的button，放在toolBar上，这样完成按钮就会在最右边
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 50, 33);
    [leftButton setTitle:@"取消" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIBarButtonItem * button1 =[[UIBarButtonItem  alloc]initWithCustomView:leftButton];
    UIBarButtonItem * button2 = [[UIBarButtonItem  alloc]initWithBarButtonSystemItem:  UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    
    //定义完成按钮
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 60, 33);
    rightButton.tag = textField.tag;
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    
    if (_style == kNumberKeyBoard) {
        
        [rightButton setTitle:@"完成" forState:UIControlStateNormal];
        [rightButton addTarget:bself action:@selector(clickSure) forControlEvents:UIControlEventTouchUpInside];
        //在toolBar上加上这些按钮
        NSArray * buttonsArray = [NSArray arrayWithObjects:button1,button2,doneButton,nil];
        [keyBoradToolbar setItems:buttonsArray];
        textField.inputAccessoryView = keyBoradToolbar;
        
    }else if (_style == kDefaultKeyBoard){
        
    }else if(_style == kToolBarKeyBoard){
        
        [rightButton addTarget:self action:@selector(nextOrPrevField:) forControlEvents:UIControlEventTouchUpInside];
        
        //根据textField的tag，来确认是显示上一个，还是下一个
        NSString *itemTitle = nil;
        if (textField.tag == 101) {
            itemTitle = @"下一个";
        }else if (textField.tag == 102){
            itemTitle = @"上一个";
        }
        [rightButton setTitle:itemTitle forState:UIControlStateNormal];
        
    }
    return YES;
}


//--------------------------------------------------------------------------------------------------------------------------------------------//
//工具条
#pragma mark - 下一个
- (void)nextOrPrevField:(UIButton *)sender{
    //
    //    if (sender.tag == 101) {
    //        [self.passwordTextField becomeFirstResponder];
    //    }else if (sender.tag == 102){
    //        [self.usernameTextField becomeFirstResponder];
    //    }
}

#pragma mark - 取消
- (void)cancel{
    [self endEditing: YES];
}




#pragma mark ------------------- UIKeyboardNotification
- (void)keyboardWillChangeFrame:(NSNotification *)notification{
    
    NSDictionary *userInfo = notification.userInfo;
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    void(^animations)() = ^{
        [self willShowKeyboardFromFrame:beginFrame toFrame:endFrame];
    };
    
    void(^completion)(BOOL) = ^(BOOL finished){};
    [UIView animateWithDuration:duration delay:0.0f options:(curve << 16 | UIViewAnimationOptionBeginFromCurrentState) animations:animations completion:completion];
}

- (void)willShowKeyboardFromFrame:(CGRect)beginFrame toFrame:(CGRect)toFrame{
    
    if (beginFrame.origin.y == [[UIScreen mainScreen] bounds].size.height){
        [self willShowBottomHeight:toFrame.size.height];
    }else if (toFrame.origin.y == [[UIScreen mainScreen] bounds].size.height){
        [self willShowBottomHeight:0];
    }else{
        [self willShowBottomHeight:toFrame.size.height];
    }
}

#pragma mark -------------- change frame
- (void)willShowBottomHeight:(CGFloat)bottomHeight{
    
    CGRect fromFrame = self.frame;
    CGFloat toHeight = bottomHeight;
    CGRect toFrame = CGRectMake(fromFrame.origin.x, fromFrame.origin.y + (fromFrame.size.height - toHeight), fromFrame.size.width, toHeight);
    
    self.frame = toFrame;
    
    if (_delegate && [_delegate respondsToSelector:@selector(didChangeFrameToHeight:)]) {
        [_delegate didChangeFrameToHeight:toHeight];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    }
}


@end
