//
//  AddFriendView.m
//  :
//
//  Created by WQY on 15-5-5.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "AddFriendView.h"
#import "UITextField+FC.h"

@implementation AddFriendView

-(id)initWithFrame:(CGRect)frame delegate:(id)delegate{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kGlobalBg;
        
        [FCUitility addSingleEvent:self target:delegate action:@selector(viewHidden:)];
        
        UISearchBar * search = [[UISearchBar alloc ] initWithFrame:CGRectMake(0, 0, screenW, 40)];
        search.placeholder = @"手机号/昵称";
        search.showsSearchResultsButton = YES;
        search.searchTextPositionAdjustment = UIOffsetMake(0, -2);
        search.delegate = delegate;
        [self addSubview:search];
        
        UIButton *btn = [[UIButton alloc]init];
        [btn addTarget:self action:@selector(addContants) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"从通讯录添加" forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 100, 320,50);
        
        [self addSubview:btn];
        
    }
    return self;
}





@end
