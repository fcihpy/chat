//
//  MineController.m
//  bussinessChat
//
//  Created by zhisheshe on 15-3-25.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "MineController.h"
#import "PersonInfoController.h"
#import "SettingController.h"
#import "CustomKeyBoard.h"

#import "PersonManager.h"
#import "personModel.h"
#import "BaseSettingTableView.h"
#import "XmppHelper.h"
#import "DiscoverController.h"

#import "BaseCellGroup.h"
#import "BaseCellModel.h"
#import "PersonInfoModel.h"
@interface MineController ()<UITableViewDataSource,UITableViewDelegate>
{
    personModel     *_model;
    XMPPvCardTemp   *_myVcard;
    PersonInfoModel *_personInfo;
}

@property(nonatomic)int page;

@end

@implementation MineController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadModelData];
    
    //基本设置
    [self baseSetting];
    
    [self test];

}

#pragma mark --------------------------------------------基本设置-----------------------------------------------
#pragma mark 基本设置
- (void)baseSetting{
    
    self.isShowLeftItem = YES;

    [super baseSetting];
    
    self.title = @"我的";
    
    _personInfo = [[PersonInfoModel alloc]init];
    
}


- (void)test{
    
    
}


#pragma mark - 数据处理

- (void)loadModelData{
    
    NSString *uid = [AccountTools sharedAccountTools].account.loginName;
    
    
    [PersonManager getPersonInfoWithuid:uid getPersonModelSuccess:^(personModel *model) {
        
        [self addItemGroup1];
        
        [self addItemGroup2];
        
        [self addItemGroup3];
        
        [self addItemGroup4];
        
        [self.tableView reloadData];

        
    } failure:^(NSError *error) {
        
    }];


}


- (void)addItemGroup1{
    
   
/*
    CellImgSubtitleItem *person = [CellImgSubtitleItem itemWithPersonIcon:@"http://openfire.25ren.com/Uploads/2015-04-30/5541ef322d975.png" name:_myVcard.nickname mobile:_myVcard.note];
    person.pushVCClass = [PersonInfoController class];
    
//    __weak typeof(self) weakSelf = self;
    person.operation = ^{
        
        PersonInfoController *per = [[PersonInfoController alloc]init];
//        FCNavigationController *nav = [[FCNavigationController alloc]initWithRootViewController:per];
        [self.navigationController pushViewController:per animated:YES];
    };
    
//    if (_myVcard.photo) {
//        _headIconItem.image = [UIImage imageWithData:_myVcard.photo];
//    }
//    
    //section1
    CellGroupItem *group1 = [[CellGroupItem alloc]init];
    group1.items = @[person];
    
    [_cellModelArry addObject:group1];
 
 */
    
    BaseCellModel *cellModel = [[BaseCellModel alloc]init];
    cellModel.cellType = cellTypeItemImagePhoto;
    cellModel.cellTitle = _personInfo.prsonName;
    cellModel.cellSubTitle = _personInfo.prsonPhone;
    cellModel.cellContentPhoto = _personInfo.personPhoto;
    cellModel.cellPustVC = [[PersonInfoController alloc]init];
    BaseCellGroup *group = [[BaseCellGroup alloc]init];
    [group.groupMemberArray addObject:cellModel];
    [self baseTableViewAddCellElementGroup:group];
    
}

- (void)addItemGroup2{
    
    /*
    CellLabelWithArrowItem *friendCircles = [CellLabelWithArrowItem itemWithIcon:@"discover_friendCircle_icon" title:@"我的朋友圈子"];
    
    //section2
    CellGroupItem *group2 = [[CellGroupItem alloc]init];
    group2.items = @[friendCircles];
    [_cellModelArry addObject:group2];
    */
    
    BaseCellModel *cellModel = [[BaseCellModel alloc]init];
    cellModel.cellTitle = @"我的朋友圈";
    cellModel.cellIcon = [UIImage imageNamed:@"discover_friendCircle_icon"];
    
    BaseCellGroup *group = [[BaseCellGroup alloc]init];
    [group.groupMemberArray addObject:cellModel];
    [self baseTableViewAddCellElementGroup:group];
    
}

- (void)addItemGroup3{

    /*
    CellLabelWithArrowItem *setting = [CellLabelWithArrowItem itemWithIcon:@"mine_setup_icon" title:@"设置"];
    
    setting.pushVCClass = [SettingController class];
    
    //section3
    CellGroupItem *group3 = [[CellGroupItem alloc]init];
    group3.items = @[setting];
    [_cellModelArry addObject:group3];
    */
    
    BaseCellModel *cellModel = [[BaseCellModel alloc]init];
    cellModel.cellTitle = @"设置";
    cellModel.cellIcon = [UIImage imageNamed:@"mine_setup_icon"];
    cellModel.cellPustVC = [[SettingController alloc]init];
    BaseCellGroup *group = [[BaseCellGroup alloc]init];
    [group.groupMemberArray addObject:cellModel];
    [self baseTableViewAddCellElementGroup:group];}

- (void)addItemGroup4{
   
    /*
    CellLabelWithArrowItem *MineApp1 =  [CellLabelWithArrowItem itemWithIcon:@"discover_app_icon1" title:@"我的应用一"];
    
    CellLabelWithArrowItem *MineApp2 = [CellLabelWithArrowItem itemWithIcon:@"discover_app_icon2" title:@"我的应用二"];
    
    //section4
    CellGroupItem *group4 = [[CellGroupItem alloc]init];
    group4.items = @[MineApp1,MineApp2];
    [_cellModelArry addObject:group4];
     */
    
    BaseCellModel *cellModel1 = [[BaseCellModel alloc]init];
    cellModel1.cellTitle = @"我的应用一";
    cellModel1.cellIcon = [UIImage imageNamed:@"discover_app_icon1"];
    
    BaseCellModel *cellModel2 = [[BaseCellModel alloc]init];
    cellModel2.cellTitle = @"我的应用二";
    cellModel2.cellIcon = [UIImage imageNamed:@"discover_app_icon2"];
    
    NSArray *arr = [NSArray arrayWithObjects:cellModel1,cellModel2, nil];
    BaseCellGroup *group = [[BaseCellGroup alloc]initWithGroupArrar:arr];
    [self baseTableViewAddCellElementGroup:group];

}



#pragma mark - -------------------------事件处理---------------

- (void)clickLeftBarItm{
    
}

- (void)clickRightBarItm{
    
    
}

@end
