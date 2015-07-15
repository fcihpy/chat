//
//  ChooseGender.m
//  BussinessChat
//
//  Created by zhisheshe on 15-4-7.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#define Top_Height (screenH - 125) / 2.0
#define Left_Width (screenW - 260) / 2.0

#import "ChooseGender.h"
#import "Cover.h"

@implementation ChooseGender
{
    UIImageView * iconImage;
}


- (id)initWithFrame:(CGRect)frame delegate:(id)delegate window:(UIWindow *)window gender:(NSString *)gender{
    
    if (self = [super initWithFrame:frame]) {
    
        self.delegate = delegate;
        iconImage = [[UIImageView alloc ] initWithFrame:CGRectMake(215, 9, 22, 22)];
        [iconImage setImage:[UIImage imageNamed:@"list_check"]];
        
        //蒙层
        Cover *cover = [Cover coverWithTarget:self action:@selector(viewHidden)];
        cover.frame = window.frame;
        [self addSubview:cover];
        
        
        UIView * sexList = [[UIView alloc ] initWithFrame:CGRectMake(Left_Width, Top_Height, 260, 125)];
        [sexList setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:sexList];
        
        //设置性别
        UILabel * sexLabel = [[UILabel alloc ] initWithFrame:CGRectMake(10, 0, 250, 44)];
        [sexLabel setText:@"性别"];
        [sexLabel setFont:kFont14];
        [sexLabel setTextColor:kButtonPreColor];
        [FCUitility addSingleEvent:sexLabel target:self action:nil];
        [FCUitility addBorderLine:sexLabel position:@"bottom"];
        [sexList addSubview:sexLabel];
        
        
        UILabel * manLabel = [[UILabel alloc ] initWithFrame:CGRectMake(10, 44, 250, 40)];
        [manLabel setText:@"男"];
        [self setLabelInformation:manLabel];
        [sexList addSubview:manLabel];
        if ([gender isEqualToString:@"男"] ) {
            [manLabel addSubview:iconImage];
        }
        
        
        UILabel * womenLabel = [[UILabel alloc ] initWithFrame:CGRectMake(10, 84, 250, 40)];
        [womenLabel setText:@"女"];
        [self setLabelInformation:womenLabel];
        [sexList addSubview:womenLabel];
        if ([gender isEqualToString:@"女"]) {
            [womenLabel addSubview:iconImage];
        }
        
        [window addSubview:self];
    }
    
    return self;
}

- (void)viewHidden{
    
    [self removeFromSuperview];
}
                        
                        
//设置label样式
-(void)setLabelInformation:(UILabel *)label{
    [FCUitility addSingleEvent:label  target:self action:@selector(changeIcon:)];
    [label setFont:kFont14];
    [FCUitility addBorderLine:label position:@"bottom"];
}

//点击的notification
-(void)changeIcon:(UIGestureRecognizer * )recognizer{
    UILabel * view = (UILabel *)recognizer.view;
    [self.delegate ChooseGenderReturnStr:view.text];
    [self viewHidden];
}

                        



@end
