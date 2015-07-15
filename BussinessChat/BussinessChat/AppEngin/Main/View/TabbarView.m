//
//  TabbarView.m
//  车商官家
//
//  Created by zhisheshe on 14-11-6.
//  Copyright (c) 2014年 zhisheshe. All rights reserved.
//



#import "TabbarView.h"
//筛选按钮的宽高
#define kItemW 80
#define kItemCount 4

@implementation TabbarView



#pragma mark 初始化frame时所做的操作
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //背景色
        self.backgroundColor = kTabrNavBg;

        //添加item
        [self addItems];

    }
    return self;
}


#pragma mark - 添加item
- (void)addItems{
    
    [self addOneItem:@"tabbar_chat_nor" selectIcon:@"tabbar_chat_pre" Title:@"聊天" tag:0];
    [self addOneItem:@"tabbar_contact_nor" selectIcon:@"tabbar_contact_pre" Title:@"联系人" tag:1];
    [self addOneItem:@"tabbar_descov_nor" selectIcon:@"tabbar_descov_pre" Title:@"发现" tag:2];
    [self addOneItem:@"tabbar_my_nor" selectIcon:@"tabbar_my_pre" Title:@"我的" tag:3];
    
}

#pragma mark - 快速添加btn方法

- (void)addOneItem:(NSString *)icon  selectIcon:(NSString *)selectIcon  Title:(NSString *)title tag:(int)tag {
    
    //初始化item
    TabbarItem *item = [[TabbarItem alloc]init];
 
    //设置图片
    [item setIcon:icon selectIcon:selectIcon];
    
    //设置title
    [item setTitle:title];
    
    //添加到item到View上
    [self addSubview:item];

    //调整frame
    item.frame = CGRectMake((screenW /kItemCount) * tag , 0, 0, 0);
//    [self adjustButtonFrames];

    
    //5、标识唯一的item
    item.tag = tag;
    
    // 6.默认选中第0个按钮
    if (tag == 0) {
        
        [self TabbarItemClick:item];
    }
    
//    if (self.subviews.count == 1) {
//        [self TabbarItemClick:item];
//    }

    
    //设置触发事件
    [item addTarget:self action:@selector(TabbarItemClick:) forControlEvents:UIControlEventTouchDown];
   
   
}

#pragma mark 重新调整所有按钮的frame
- (void)adjustButtonFrames{
    
    NSUInteger btnCount = self.subviews.count;
    
   
    for (int i = 0; i <  btnCount; i ++) {
        
        TabbarItem *item = self.subviews[i];
        
        //设置framer
        CGFloat btnY = 0;
        CGFloat btnW = self.frame.size.width / btnCount;
        CGFloat btnX = i *btnW;
        CGFloat btnH = self.frame.size.height;
        
        item.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
        MyLog(@"sss %@",item);
        
    }
    
}


#pragma mark - item点击时的触发事件
- (void)TabbarItemClick:(TabbarItem *)item{
    
   
    //判断代理是否实现，如果实现,则给代理参数赋值
    
    if ([_delegate respondsToSelector:@selector(TabbarView:fromBarItem:toBarItem:)]) {
        [_delegate TabbarView:self fromBarItem:_selectItem.tag toBarItem:item.tag];
    }
    
    
    //根据点击，控制item的状态
    _selectItem.selected = NO;
    item.selected = YES;
    _selectItem = item;

}




@end
