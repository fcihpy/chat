//
//  BaseTableView.h
//  pinchehui
//
//  Created by zhisheshe on 15-3-13.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableView : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic,copy) NSString *navTitle;                                 //提供给子类可修改的title

@property (nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *cellModelArry;



@end
