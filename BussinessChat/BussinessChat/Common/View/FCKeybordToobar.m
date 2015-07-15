//
//  FCKeybordToobar.m
//  BussinessChat
//
//  Created by zhisheshe on 15-4-9.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "FCKeybordToobar.h"

@interface FCKeybordToobar()
{
    
}

+(void) keyboardWillShow : (NSNotification*) notification;
+(void) keyboardWillHide : (NSNotification*) notification;
+(void) addObservers;
+(void) removeObservers;

@end

@implementation FCKeybordToobar

//初始化控件和变量
-(id)init{
    if((self = [super init])) {
        _prevButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"上一项" style:UIBarButtonItemStyleBordered target:self action:@selector(showPrevious)];
        _nextButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一项" style:UIBarButtonItemStyleBordered target:self action:@selector(showNext)];
        _hiddenButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"隐藏键盘" style:UIBarButtonItemStyleBordered target:self action:@selector(HiddenKeyBoard)];
        _spaceButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        _toobarview = [[UIToolbar alloc] initWithFrame:CGRectMake(0,480,320,44)];
        _toobarview.barStyle = UIBarStyleBlackTranslucent;
        _toobarview.items = [NSArray arrayWithObjects:_prevButtonItem,_nextButtonItem,_spaceButtonItem,_hiddenButtonItem,nil];
        _allowShowPreAndNext = YES;
        textFields = nil;
        _isInNavigationController = YES;
        _currentTextField = nil;
    }
    return self;
//    [[FCMob sharedInstance] OauthManger] asyncLoginWithUsername:<#(NSString *)#> password:<#(NSString *)#> completion:^(NSDictionary *loginInfo, int *error) {
    
//    } onQueue:nil)];
}

//设置是否在导航视图中
-(void)setIsInNavigationController:(BOOL)isbool{
    _isInNavigationController = isbool;
}

//显示上一项
-(void)showPrevious{
    if (textFields==nil) {
        return;
    }
    NSInteger num = -1;
    for (NSInteger i=0; i<[textFields count]; i++) {
        if ([textFields objectAtIndex:i]==_currentTextField) {
            num = i;
            break;
        }
    }
    if (num>0){
        [[textFields objectAtIndex:num] resignFirstResponder];
        [[textFields objectAtIndex:num-1 ] becomeFirstResponder];
        [self showBar:[textFields objectAtIndex:num-1]];
    }
}

//显示下一项
-(void)showNext{
    if (textFields==nil) {
        return;
    }
    NSInteger num = -1;
    for (NSInteger i=0; i<[textFields count]; i++) {
        if ([textFields objectAtIndex:i]==_currentTextField) {
            num = i;
            break;
        }
    }
    if (num<[textFields count]-1){
        [[textFields objectAtIndex:num] resignFirstResponder];
        [[textFields objectAtIndex:num+1] becomeFirstResponder];
        [self showBar:[textFields objectAtIndex:num+1]];
    }
}

//显示工具条
-(void)showBar:(UITextField *)textField{
    _currentTextField = textField;
    if (_allowShowPreAndNext) {
        [_toobarview setItems:[NSArray arrayWithObjects:_prevButtonItem,_nextButtonItem,_spaceButtonItem,_hiddenButtonItem,nil]];
    }
    else {
        [_toobarview setItems:[NSArray arrayWithObjects:_spaceButtonItem,_hiddenButtonItem,nil]];
    }
    if (textFields==nil) {
        _prevButtonItem.enabled = NO;
        _nextButtonItem.enabled = NO;
    }
    else {
        NSInteger num = -1;
        for (NSInteger i=0; i<[textFields count]; i++) {
            if ([textFields objectAtIndex:i]==_currentTextField) {
                num = i;
                break;
            }
        }
        if (num>0) {
            _prevButtonItem.enabled = YES;
        }
        else {
            _prevButtonItem.enabled = NO;
        }
        if (num<[textFields count]-1) {
            _nextButtonItem.enabled = YES;
        }
        else {
            _nextButtonItem.enabled = NO;
        }
    }
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    if (_isInNavigationController) {
        _toobarview.frame = CGRectMake(0, 201-40, 320, 44);
    }
    else {
        _toobarview.frame = CGRectMake(0, 201, 320, 44);
    }
    [UIView commitAnimations];
}

//设置输入框数组
-(void)setTextFieldsArray:(NSArray *)array{
    textFields = array;
}

//设置是否显示上一项和下一项按钮
-(void)setAllowShowPreAndNext:(BOOL)isShow{
    _allowShowPreAndNext = isShow;
}

//隐藏键盘和工具条
-(void)HiddenKeyBoard{
    if (_currentTextField!=nil) {
        [_currentTextField  resignFirstResponder];
    }
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    _toobarview.frame = CGRectMake(0, 480, 320, 44);
    [UIView commitAnimations];
}

///////////////////
+(void) keyboardWillShow : (NSNotification*) notification {
    
//    [self setIsKeyboardShow:YES];
//    
//    NSDictionary *userInfo = [notification userInfo];
//    [self setKeyboardAnimationDutation:[[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
//    [self setKeyboardRect:[[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue]];
//    
//    [self dodgeKeyboardAnimation];
    
}

+(void) keyboardWillHide : (NSNotification*) notification {
    
//    [self setIsKeyboardShow:NO];
//    [self dodgeKeyboardAnimation];
    
}

+(void) addObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

+(void) removeObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}


#pragma mark - class method

+(void) addRegisterTheViewNeedDodgeKeyboard : (UIView*) view {
    
//    [self setObserverView:view];
//    [self setOriginalViewFrame:view.frame];
//    [self setIsKeyboardShow:NO];
    
    [self addObservers];
    
}

+(void) removeRegisterTheViewNeedDodgeKeyboard {
    
//    objc_removeAssociatedObjects(self);
    
    [self removeObservers];
    
}

@end
