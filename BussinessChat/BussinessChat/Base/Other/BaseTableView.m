//
//  BaseTableView.m
//  pinchehui
//
//  Created by zhisheshe on 15-3-13.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "BaseTableView.h"
#import "ProvinceModel.h"
#import "CityModel.h"

@implementation BaseTableView

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.view.backgroundColor = kGlobalBg;
    
    //leftNavItem
    UIButton *backBartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBartBtn.frame = CGRectMake(0, 0, 22, 22);
    [backBartBtn setBackgroundImage:[UIImage imageNamed:@"nav_icon_return"] forState:UIControlStateNormal];
    [backBartBtn addTarget:self action:@selector(backPrev) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:backBartBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
   
    
    //添加tableView
    [self addTableView];
    
}

#pragma mark --------------------------------------------基本设置-----------------------------------------------
#pragma mark 基本设置


#pragma mark - ------------------------------------------buildBUI---------------------------------------
#pragma mark  添加tableView
- (UITableView *)addTableView
{
    if (_tableView == nil)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenH - 64) style:UITableViewStylePlain];
        
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}



#pragma mark -返回
-(void)backPrev{
    
    [self.navigationController popViewControllerAnimated:YES];;
    
}


#pragma mark-  -------------------------------------------事件处理处理-----------------------------------------



- (void)setNavTitle:(NSString *)navTitle{
    _navTitle = navTitle;
    self.title = _navTitle;
}

#pragma mark - ---------------------------------------Table view data source------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _cellModelArry.count;
}





@end
