//
//  TabbarItem.m
//  车商官家
//
//  Created by zhisheshe on 14-11-6.
//  Copyright (c) 2014年 zhisheshe. All rights reserved.
//

//筛选按钮的宽高
#define kItemW 80
#define kItemH 49

#define kImgRatio 0.6

#import "TabbarItem.h"

@implementation TabbarItem


#pragma mark - --设置Frame
#pragma mark 初始化frame时所做的操作
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        // 1.文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        // 2.文字大小
        self.titleLabel.font = kFont11;
        
       

        //3、设置文字各种状态的颜色
        [self setTitleColor:kTabrNorColor forState:UIControlStateNormal];
        [self setTitleColor:kTabrPreColor forState:UIControlStateSelected];
  
    }
    return self;
}

#pragma mark - --设置不同状态时的文字的图片
#pragma mark 设置item不同状态时的文字title
- (void)setIcon:(NSString *)icon selectIcon:(NSString *)selectIcon{
    
    [self setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:selectIcon] forState:UIControlStateSelected];

}

#pragma mark 设置item不同状态时的图片
- (void)setTitle:(NSString *)title{
    
    [self setTitle:title forState:UIControlStateNormal];
    
    [self setTitle:title forState:UIControlStateSelected];

}


-(void)setHighlighted:(BOOL)highlighted
{
    
}


#pragma mark  重写item的frame，内定自己的宽高等选项，不让外界修改
- (void)setFrame:(CGRect)frame{
    
    frame.size = CGSizeMake(kItemW, kItemH);
    
    //设置图片属性，如居中
    self.imageView.contentMode = UIViewContentModeCenter;
    
    [super setFrame:frame];
}

#pragma mark 调整内部ImageView的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{

    CGFloat imageX = 0;
    CGFloat imageY = 2;
    CGFloat imageWidth = contentRect.size.width;
    CGFloat imageHeight = contentRect.size.height * kImgRatio;
    return CGRectMake(imageX, imageY, imageWidth, imageHeight);
    
    
    
}

#pragma mark 调整内部UILabel的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleHeight = contentRect.size.height * (1- kImgRatio);
    CGFloat titleY = contentRect.size.height - titleHeight -2;
    CGFloat titleWidth = contentRect.size.width;
    return CGRectMake(titleX, titleY, titleWidth, titleHeight);

}




@end
