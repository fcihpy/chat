//
//  CityInfoController.m
//  BussinessChat
//
//  Created by zhisheshe on 15-4-2.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "CityInfoController.h"
#import "Cover.h"
#import "ProvinceModel.h"
#import "CityModel.h"

@interface CityInfoController () <UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    UITableView *_subTableView;
    Cover *_cover;
    
    
    NSMutableArray *_cellModelArry;
    NSMutableArray *_subCellModelArry;
    
    
    
    NSString *_provinceid ;
    NSString *_cityid;
    NSString *_provinceName;
    NSString *_cityName;
}

@end

@implementation CityInfoController

- (void)viewDidLoad{
    
    [self baseSetting];
    
    //获取省份信息
    [self getProvinceData];
    
    //添加tableView
    [self addTableView];
    [self.view addSubview:_tableView];
    
    [self addSubTableView];
    [self.view addSubview:_subTableView];
    
}



#pragma mark --------------------------------------------基本设置-----------------------------------------------
#pragma mark 基本设置
- (void)baseSetting{
    
    self.title = @"城市选择";
    
    self.view.backgroundColor = COLOR(241, 241, 241, 1);
    

    //leftNavItem
    UIButton *backBartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBartBtn.frame = CGRectMake(0, 0, 22, 22);
    [backBartBtn setBackgroundImage:[UIImage imageNamed:@"nav_icon_return"] forState:UIControlStateNormal];
    [backBartBtn addTarget:self action:@selector(backPrev) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:backBartBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;

}


#pragma mark - ------------------------------------buildUI-------------------------------------------



- (UITableView *)addTableView
{
    if (_tableView == nil)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, screenH - 64) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.backgroundColor = COLOR(44, 39, 33, 1);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tag = 288;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
    }
    
    return _tableView;
}


- (UITableView *)addSubTableView
{
    if (_subTableView == nil)
    {
        _subTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _subTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _subTableView.delegate = self;
        _subTableView.dataSource = self;
        _subTableView.tag = 299;
        _subTableView.hidden = YES;
//       _subTableView.backgroundColor = COLOR(38, 34, 27, 1);
        _subTableView.frame = CGRectMake(160, 0, 160, screenH - 97);
    }
    
    return _subTableView;
}


#pragma mark-  -------------------------------------------事件处理处理-----------------------------------------

#pragma mark -返回
-(void)backPrev{
    
    [self.navigationController popViewControllerAnimated:YES];;
    
}





#pragma mark - ------------------------------------数据处理-------------------------------------------

#pragma mark 获取省份信息
- (void)getProvinceData{
    
    _cellModelArry = [NSMutableArray array];
    ProvinceModel *Pmodel = [[ProvinceModel alloc]init];
    Pmodel.provinceName = @"全国";
    Pmodel.provinceID = @"0";
    [_cellModelArry addObject:Pmodel];
    
    [MetaDataTool getProvinceWith:^(NSArray *provinceModelArry, int totalCount) {
        
        [_cellModelArry addObjectsFromArray:provinceModelArry];
        [_tableView reloadData];
        
    } getModelFailure:^(NSError *error) {
        
    }];
    
}

#pragma mark 获取城市信息
- (void)getCity:(NSString *)provinceID{
    
    _subCellModelArry = [NSMutableArray array];
    CityModel *cModel = [[CityModel alloc]init];
    cModel.cityName = @"不限";
    cModel.cityID = @"0";
    [_subCellModelArry addObject:cModel];
    
    
    [MetaDataTool getCityWithProvince:provinceID getModelSuccess:^(NSArray *cityModelArry, int totalCount) {
        
        [_subCellModelArry  addObjectsFromArray:cityModelArry];
        [_subTableView reloadData];
        
    } getModelFailure:^(NSError *error) {
        
    }];
}

#pragma mark - -----------------Table view data source------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows;
    
    if (tableView.tag == 288) {
        numberOfRows = _cellModelArry.count;
        
    }else if (tableView.tag == 299){
        numberOfRows = _subCellModelArry.count;
    }
    
    return numberOfRows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuse = @"cell";
    
    NSString *cellTitle;
    if (cellTitle == nil) {
        cellTitle = [NSString string];
    }
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:reuse];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    
    if (tableView.tag ==288) {
        
        ProvinceModel *pModel = _cellModelArry[indexPath.row];
        cellTitle = pModel.provinceName;
        cell.backgroundColor = kLabelColor;
        
    }else{
        
        CityModel *seriesmodel = _subCellModelArry[indexPath.row];
        cellTitle = seriesmodel.cityName;
        cell.backgroundColor = kLabelColor;
    }
    
    cell.textLabel.text = cellTitle;
    cell.textLabel.textColor = kButtonPreColor;
    cell.textLabel.font = kFont15;
    
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 43.5, 320, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [cell.contentView addSubview:lineView];
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
       if (tableView.tag == 288) {  //省份
        ProvinceModel *model = _cellModelArry[indexPath.row];
        
        _provinceid = model.provinceID;
        _provinceName = model.provinceName;
           
        [self getCity:model.provinceID];
           
            if (indexPath.row == 0) {       //全国
                _cityid = @"";
                _cityName = @"";
                
            }else{
                _subTableView.hidden = NO;
            }
            
            
        }else{                      //城市
            
            if (indexPath.row == 0) {  //不限
                _cityid = @"";
                _cityName = @"";
            }else{
                CityModel *citymodel = _subCellModelArry[indexPath.row];
                _cityid = citymodel.cityID;
                _cityName = citymodel.cityName;
                
            }
            
            _subTableView.hidden = YES;
            
            
            if ([_cityName isEqualToString:@""] || [_cityName isEqualToString:@"不限"]) {
                _cityName = _provinceName;
            }
           
            
            //发送品牌参数字典
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeCity"
                                                                object:self userInfo:@{
                                                                                       @"provinceid":_provinceid,
                                                                                       @"provinceName":_provinceName,
                                                                                       @"cityid":_cityid,
                                                                                       @"cityName":_cityName
                                                                                       }];
            UIViewController *vc = [self.navigationController.viewControllers objectAtIndex:(self.navigationController.viewControllers.count -2)];
            [self.navigationController popToViewController:vc animated:YES];

        }

}



@end
