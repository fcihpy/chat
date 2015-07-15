//
//  PersonInfoController.m
//  BussinessChat
//
//  Created by zhisheshe on 15-4-3.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "PersonInfoController.h"
#import "MoreInfoContrller.h"
#import "ChooseGender.h"
#import "AppDelegate.h"
#import "EditPersonInfoController.h"


#import "BaseCellModel.h"
#import "BaseCellGroup.h"
#import "LazyPhotoPiker.h"
#import "ChooseDatePicker.h"
#import "PersonInfoModel.h"
@interface PersonInfoController ()<UITextFieldDelegate,UIActionSheetDelegate,LazyPhotoPikerDelegate,ChooseGenderDelegate,ChooseDatePickerDelegate>
{
    CellTextFeildItem       *tf2;
    CellLabelWithArrowItem  *t1;

    
    CellImgWithArrowItem    *_headIconItem;
    CellLableItem           *_mobileItem;
    CellLableItem           *_nickNameItem;
    CellLabelWithArrowItem  *_birthDayItem;
    CellLabelWithArrowItem  *_genderItem;
    CellLabelWithArrowItem  *_placeItem;
    
    CellLabelWithArrowItem  *_jobItem;
    CellTextFeildItem       *_siglWordItem;
    
    UIWindow                * _keyWindow;
    NSString                *_checkPhoneNumber;
    
    ChooseGender            *_chooseGenderView;
    PersonInfoModel         *_personInfo;
    LazyPhotoPiker          *_piler;
    UIDatePicker            *_datePicker;
}

@property(nonatomic,strong) personModel *model;

@property(nonatomic,strong) CellLableItem *mobileItem;

@property(nonatomic,strong) CellLableItem *nickNameItem;


@end


@implementation PersonInfoController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initArgs];

    
    //基本设置
    [self baseSetting];
    
    [self addItemGroup1];
    
//  [self addItemGroup2];
    
    [self addItemGroup3];
    
    [self addObserver];
    [self.tableView reloadData];

}

- (void)initArgs{
    
    //拿到我的电子名片的数据模型
    _personInfo = [[PersonInfoModel alloc]init];
    
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}
- (void)loadCellModelData{
    
    NSString *uid = [AccountTools sharedAccountTools].account.loginName;
    
    [PersonManager getPersonInfoWithuid:uid getPersonModelSuccess:^(personModel *model) {
        
        self.model = model;

        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (void)addObserver{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityChange:) name:@"changeCity" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}


#pragma mark --------------------------------------------基本设置-----------------------------------------------
#pragma mark 基本设置
- (void)baseSetting{
    
    [super baseSetting];
    
    self.title = @"个人资料";
    
    self.isShowLeftItem = YES;
    self.isShowRightItem = YES;
    _keyWindow = [UIApplication sharedApplication].keyWindow;
    
    //rightBarItem
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交"style:UIBarButtonItemStylePlain target:self action:@selector(moreinfo)];
}


- (void)addItemGroup1{

    
    NSArray *titleArr = [NSArray arrayWithObjects:@"头像",@"手机:",@"昵称:",@"性别:",@"出生日期:", nil];
    NSArray *contentArr = [NSArray arrayWithObjects:_personInfo.personPhoto,
                                                    _personInfo.prsonPhone,
                                                    _personInfo.prsonName,
                                                    _personInfo.prsonGender,
                                                    _personInfo.prsonBday, nil];
    NSMutableArray *dataArr = [[NSMutableArray alloc]init];
    
    __weak typeof(self) weakself = self;
    for (int i=0;i<titleArr.count;i++)
    {
        NSString *title = [titleArr objectAtIndex:i];
        BaseCellModel *cellModel = [[BaseCellModel alloc]initWithTitle:title];
        if([title isEqualToString:@"头像"])
        {
            cellModel.cellType = cellTypeItemImageIcno;
            cellModel.cellContentIcon =_personInfo.personPhoto;
            cellModel.cellClick = ^{
                //选择图片
                [self openPics];
            };

        }else
        {

            cellModel.cellType = cellTypeItemLabel;
            cellModel.cellContent = [contentArr objectAtIndex:i];

            if([title isEqualToString:@"性别:"])
            {
                cellModel.cellClick = ^{[weakself callGenderKeyBord:_personInfo.prsonGender];};
            }
           else if([title isEqualToString:@"出生日期:"])
            {
                cellModel.cellClick = ^{[self createDatePicker];};
                
            }
            else
            {
                EditPersonInfoController *edit = [[EditPersonInfoController alloc]init];
                edit.editTitle = cellModel.cellTitle;
                edit.personInfo = _personInfo;
                cellModel.cellPustVC = edit;
            }
        }
        
        [dataArr addObject:cellModel];
    }
    BaseCellGroup *group = [[BaseCellGroup alloc]initWithGroupArrar:dataArr];
    [self baseTableViewAddCellElementGroup:group];
    
}

- (void)addItemGroup2{

 /*
    CellLabelWithArrowItem *erweima = [CellLabelWithArrowItem itemWithTitle:@"二维码"];
    CellGroupItem *group2 = [[CellGroupItem alloc]init];
    group2.items = @[erweima];
    [_cellModelArry addObject:group2]; */
    
    
}



- (void)addItemGroup3{

/*
    __weak PersonInfoController *person = self;
    _jobItem = [CellLabelWithArrowItem itemWithTitle:@"从事行业"];
    _jobItem.lablelText = @"IT";
    if (_jobItem.lablelText.length == 0) {
        _jobItem.lablelText = @"请选择行业";
    }
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _genderItem = [CellLabelWithArrowItem itemWithTitle:@"性别"];
    });
    
    
    _placeItem = [CellLabelWithArrowItem itemWithTitle:nil];
    _placeItem = [CellLabelWithArrowItem itemWithTitle:@"所在地"];
    _placeItem.lablelText = _myVcard.orgName;
    _placeItem.pushVCClass = [CityInfoController class];
    if (_placeItem.lablelText.length == 0) {
        _placeItem.lablelText = @"请选择城市";
    }
    _placeItem.operation = ^{
        
        CityInfoController *city =  [[CityInfoController alloc]init];
        [person.navigationController pushViewController:city animated:YES];
    };
    
    
    
    _siglWordItem = [CellTextFeildItem itemWithTitle:@"个性签名"];
    _siglWordItem.textFeildText = _model.gxjm;
    _siglWordItem.placeHoldText = @"说点什么吧，让大家认识你";
    [kUserDefaults setObject:@"placeHoldColor" forKey:@"placeHoldColor"];
    
    _siglWordItem.operation = ^{
        UITextField *temptf = [[UITextField alloc]init];
        temptf.tag = 203;
        temptf.delegate = person;
    };
 
    
    CellGroupItem *group3 = [[CellGroupItem alloc]init];
//    group3.items = @[_jobItem,_placeItem,_siglWordItem];
    
    group3.items = @[_placeItem];
    [_cellModelArry addObject:group3];
    
*/
    
    __weak PersonInfoController *person = self;
    NSDictionary *modelDict = [[NSDictionary alloc]initWithObjectsAndKeys:_personInfo.prsonFamilyAddresses,@"所在地:",
                                                                          _personInfo.prsonTitle,@"个性签名:", nil];
    NSMutableArray *cellArray = [[NSMutableArray alloc]init];
    for (NSString *titel in modelDict.allKeys)
    {
        BaseCellModel *cellModel = [[BaseCellModel alloc]initWithTitle:titel];
        cellModel.cellType = cellTypeItemLabel;
        cellModel.cellContent = [modelDict objectForKey:titel];
        if([titel isEqualToString:@"所在地:"])
        {
            cellModel.cellClick = ^{
             
                CityInfoController *city =  [[CityInfoController alloc]init];
                [person.navigationController pushViewController:city animated:YES];

            };
        }
        else
        {
            if([_personInfo.prsonTitle isEqualToString:@""] || _personInfo.prsonTitle == nil)
            {
                cellModel.cellContent = @"说点什么吧，让大家认识你";
            }
            EditPersonInfoController *edit = [[EditPersonInfoController alloc]init];
            edit.editTitle = titel;
            edit.personInfo = _personInfo;
            cellModel.cellPustVC = edit;
        }
        [cellArray addObject:cellModel];
    }
    BaseCellGroup *group = [[BaseCellGroup alloc]initWithGroupArrar:cellArray];
    [self baseTableViewAddCellElementGroup:group];
    
}

- (void)moreinfo{
    
    [_personInfo personInfoSave];
    FCAlert(@"修改成功");
   
}


#pragma mark - -------------------------事件处理---------------
- (void)backPrev{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

//设置性别
- (UIView *)callGenderKeyBord:(NSString *)gender {
    
    return   [[ChooseGender alloc]initWithFrame:_keyWindow.frame delegate:self window:_keyWindow gender:gender];
    
}

- (void)ChooseGenderReturnStr:(NSString *)returnStr{
    
    _personInfo.prsonGender = returnStr;
    [self baseTableViewRevampCellElementTitle:@"性别:" andElementValue:returnStr];
}


// 设置出生日期
- (UIView *)createDatePicker
{
   return  [[ChooseDatePicker alloc]initWithWindow:_keyWindow andDelegate:self andDateString:_personInfo.prsonBday];
}

- (void)ChooseDatePickerReturnDate:(NSString *)returnDate
{
    _personInfo.prsonBday = returnDate;
    [self baseTableViewRevampCellElementTitle:@"出生日期:" andElementValue:returnDate];

}

- (void)cityChange:(NSNotification *)noti{
    
    NSDictionary *dict = noti.userInfo;
    _personInfo.prsonFamilyAddresses = [NSString stringWithFormat:@"%@ %@",dict[@"provinceName"],dict[@"cityName"]];
    [self baseTableViewRevampCellElementTitle:@"所在地:" andElementValue:_personInfo.prsonFamilyAddresses];
    
}


//打开相册
- (void)openPics{
    
    _piler = [[LazyPhotoPiker alloc]init];
    _piler.delegateController = self;
    [_piler presentPikerInController:self];
}

- (void)didFinishPostSelectImage:(UIImage *)selectImage
{
    _personInfo.personPhoto = selectImage;
    [self baseTableViewRevampCellElementTitle:@"头像" andElementValue:selectImage];
}


- (void)setModel:(personModel *)model{
    
    _model = model;
   
    
    _headIconItem.imgName = _model.img;
    _mobileItem.lablelText = _model.phone;
     _nickNameItem.lablelText = _model.truename;
    _genderItem.lablelText = _model.sex;
    
    _placeItem.lablelText = _model.city;
    _siglWordItem.textFeildText = _model.gxjm;
    
    
    [self.tableView reloadData];
    
}


@end
