//
//  AddressController.m
//  BussinessChat
//
//  Created by zhisheshe on 15-4-30.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "AddressController.h"
#import "AddressModel.h"
#import "AddressCell.h"
#import "AddressBookHelper.h"

@interface AddressController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    UITableView *_tableView;
    NSArray *_cellModelArry;
}
@end

@implementation AddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //基本设置
    [self baseSetting];
    
    [ self addTableView];
    [self.view addSubview:_tableView];
    
    
    [self loadModelData];

    
}



#pragma mark --------------------------------------------基本设置-----------------------------------------------
#pragma mark 基本设置
- (void)baseSetting{
    
    self.title = @"通讯录";
    self.view.backgroundColor = [UIColor redColor];
    
}

#pragma mark - ------------------------------------------buildBUI---------------------------------------

#pragma mark  添加tableView
- (UITableView *)addTableView
{
    if (_tableView == nil)
    {
        UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        
        tableView.delegate = self;
        tableView.dataSource = self;
        
        // 设置背景
        tableView.backgroundView = nil;
        
        
        //group状态下
        //        tableView.sectionFooterHeight = 0;
        //        tableView.sectionHeaderHeight = 20;
        
        
        // 隐藏分隔线
        
        _tableView = tableView;
        
        //注册cell
        [_tableView registerNib:[AddressCell loadNib] forCellReuseIdentifier:@"cell"];
        
    }
    return _tableView;
}


#pragma mark - 数据处理
- (void)loadModelData{
    
    _cellModelArry = [NSArray array];
    [AddressBookHelper sortDataArry:^(NSArray *contacts) {
        MyLog(@"aaaaaa %@ %d",contacts,contacts.count);
        _cellModelArry = contacts;
        [_tableView reloadData];
    }];
    
}



#pragma mark - 事件处理


#pragma mark - ---------tableView delegate


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _cellModelArry.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_cellModelArry[section] count];
}

#pragma mark 每当有一个cell进入视野范围内就会调用，返回当前这行显示的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建一个ILSettingCell
    
    
    
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell initWithDelegate:self];
    
    AddressModel *model = _cellModelArry[indexPath.section][indexPath.row];
    cell.model = model;
    
    
    return cell;
}

#pragma mark 点击了cell后的操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 去除选中时的背景
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

#pragma mark 返回每一组的header标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSMutableArray *existTitles = [NSMutableArray array];
    
    UILocalizedIndexedCollation *indexCollation = [UILocalizedIndexedCollation currentCollation];
    NSMutableArray *sectionTitles = [NSMutableArray arrayWithArray:[indexCollation sectionIndexTitles]];
    
    //section数组为空的title过滤掉，不显示
    for (int i = 0; i < sectionTitles.count; i ++) {
        if ([_cellModelArry[i] count] > 0) {
            [existTitles addObject:sectionTitles[i]];
        }else{
            
            [existTitles addObject:@""];
        }
        
    }
    
    return existTitles[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if ([_cellModelArry[section] count] == 0    ) {
        return 0.1;
    }else{
        return 30;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
