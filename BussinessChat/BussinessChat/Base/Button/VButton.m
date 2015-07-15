//
//  VButton.m
//  pinchehui
//
//  Created by zhisheshe on 15-1-22.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "VButton.h"

#define kImgRatio 0.7

@implementation VButton

#pragma mark - --设置Frame
#pragma mark 初始化frame时所做的操作
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        // 1.文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        // 2.文字大小
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        
//        self.backgroundColor = kBackGround;
        
        //3、设置文字各种状态的颜色
        [self setTitleColor:kButtonNorColor forState:UIControlStateNormal];
        [self setTitleColor:kButtonPreColor forState:UIControlStateSelected];
        
        // 4.图片的内容模式
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}



#pragma mark - --设置不同状态时的文字的图片
#pragma mark 设置item不同状态时的文字title
- (void)setIcon:(NSString *)icon selectIcon:(NSString *)selectIcon{
    
    [self setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:selectIcon] forState:UIControlStateSelected];
    
}

#pragma mark 设置item不同状态时的文字
-(void)setNormalTitle:(NSString *)normalTitle selectTitle:(NSString *)selectTitle{
    
    [self setTitle:normalTitle forState:UIControlStateNormal];
    [self setTitle:normalTitle forState:UIControlStateSelected];
}

#pragma mark 设置item不同状态时的文字颜色
- (void)setNormalTitleColor:(UIColor *)normalTitleColor selectTitleColor:(UIColor *)selectTitleColor{
    
    [self setTitleColor:normalTitleColor forState:UIControlStateNormal];
    [self setTitleColor:selectTitleColor forState:UIControlStateSelected];
    
}


-(void)setHighlighted:(BOOL)highlighted
{
    
}


#pragma mark  重写item的frame，内定自己的宽高等选项，不让外界修改
//- (void)setFrame:(CGRect)frame{
//
////    frame.size = CGSizeMake(kItemW, kItemH);
//
//    //设置图片属性，如居中
//    self.imageView.contentMode = UIViewContentModeCenter;
//
//    [super setFrame:frame];
//}

#pragma mark 调整内部ImageView的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageWidth = contentRect.size.width;
    CGFloat imageHeight = contentRect.size.height * kImgRatio;
    return CGRectMake(imageX, imageY, imageWidth, imageHeight);

    
}

#pragma mark 调整内部UILabel的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleHeight = contentRect.size.height * (1- kImgRatio);
    CGFloat titleY = contentRect.size.height - titleHeight ;
    CGFloat titleWidth = contentRect.size.width;
    return CGRectMake(titleX, titleY, titleWidth, titleHeight);
}



@end
