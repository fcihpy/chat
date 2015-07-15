//
//  BaseTableView.m
//  pinchehui
//
//  Created by zhisheshe on 15-3-13.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

- (void)viewDidLoad{
    
    [super viewDidLoad];
  
    //基本设置
    [self baseSetting];
    
    //添加tableView
    [self addTableView];
    [self.view addSubview:_tableView];
    
    
}

#pragma mark --------------------------------------------基本设置-----------------------------------------------
#pragma mark 基本设置
- (void)baseSetting{
    
    //返回  - left
    UIButton * backBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backBarButton.frame = CGRectMake(0, 0, 50, 44);
    backBarButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBarButton setImage:[UIImage imageNamed:@"back_arrow.png"] forState:UIControlStateNormal];
    [backBarButton addTarget:self action:@selector(clickBackBarButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBarButton = [[UIBarButtonItem alloc]initWithCustomView:backBarButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    self.view.backgroundColor = kGlobalBg;
   
}

#pragma mark - ------------------------------------------buildBUI---------------------------------------
#pragma mark  添加tableView
- (UITableView *)addTableView
{
    if (_tableView == nil)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 15, screenW, screenH) style:UITableViewStylePlain];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}



#pragma mark-  -------------------------------------------事件处理处理-----------------------------------------

- (void)clickBackBarButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setNavTitle:(NSString *)navTitle{
    _navTitle = navTitle;
    self.title = _navTitle;
}

#pragma mark - ---------------------------------------Table view data source------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.cellModelArry.count;
}



@end
