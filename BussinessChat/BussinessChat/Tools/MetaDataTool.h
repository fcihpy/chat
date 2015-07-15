//
//  MetaDataTool.h
//  车商官家
//
//  Created by zhisheshe on 14-11-8.
//  Copyright (c) 2014年 zhisheshe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MetaDataTool : NSObject

singleton_interface(MetaDataTool)



#pragma mark ----------------------------------属性------------------------------------------------------------------

//
//@property (nonatomic, strong) NSMutableDictionary *choosedCity; // 当前选中的城市
//
//@property (nonatomic,strong) NSMutableDictionary *personModelDict;  //个人信息model字典
//
//@property (nonatomic,strong) NSMutableDictionary *addCarChoosedBrand;  //发车时的车型选择
//
//@property (nonatomic,strong) NSMutableDictionary   *pramDict;  //筛选参数字典
//
//#pragma mark -------------------------------------方法---------------------------------------------------------------
//+ (void)SavePersonModelWithKey:(NSString *)idstr  modelValue:(personModel *)modelValue  completion:(void (^)(NSMutableDictionary *personModelDict))completion;
//
//
////根据多个ID获取多个人的信息
//
//+ (void)getPersonsInfoWithParams:(NSDictionary *)Params completion:(void (^)(NSMutableArray *PersonModelArry,NSError *error))completion;
//                                                                    

//
////获取车辆图片接口
//
//
//
//
//
////特卖车列表
//
////41、融资车辆列表
//+(void)getCarFinanceWithParams:(NSDictionary *)Params CarModelSuccess:(void (^)(NSArray *CarModelArry,int totalCount))CarModelSuccess failure:(void (^)(NSError *error))failure;
//
////42、融资申请
//#pragma mark --- -----------------------------------------------------登录注册----------------------------------------------------
////50、用户登录
//
////51、用户注册
//
////52、修改密码
//
////53、忘记密码
//
////54、手机验证码获得接口
//
//
////55、手机验证码判断接口
//
//
//
////56、用户认证
//
////56、获取通知消息
//+ (void)getNotiMessageWithMessagetype:(NSInteger)type page:(NSInteger)page  getNotifModelSuccess: ( void (^)(NSMutableArray *NotifModelArry) ) getNotifModelSuccess failure:( void(^)(NSError *error) )failure;
//
//
////57、获取、修改通知消息
//+ (void)getNotiMessageWithPath:(NSString *)path  Pramas:(NSDictionary *)Pramas  getNotifModelSuccess: ( void (^)(NSString *message) ) getNotifModelSuccess failure:( void(^)(NSError *error) )failure;
//
//
//
//
//
////91、上传点户点击统计信息
//
//+ (void)uploadUserClickWithPramas:(NSDictionary *)Pramas  uploadSuccess:(void (^)(NSString *status)) uploadSuccess uploadFailure:(void(^)(NSError *error))uploadFailure;
//

//
////30、获取个人信息
//+ (void)getPersonInfoWithuid:(NSString *)uid getPersonModelSuccess: ( void (^)(personModel  *PersonModel) ) getPersonModelSuccess failure:( void(^)(NSError *error) )failure;
//
//#pragma mark - 31、修改个人信息---
//+(void)modifyPersonInfoWithPramas:(NSDictionary *)Pramas modifSuccess:(void(^)(NSString *message))modifSuccess  failure:( void(^)(NSError *error) )failure;

//#pragma mark ------------------------------------------------------------其它---------------------------------------------------------
//#pragma mark  检测版本
//+ (void)checkVersion:(NSString *)CurrentVersion  getSuccess:( void (^)(NSString  *versionId,NSString *VersionUrl,NSString *content))getSuccess;
//
//
//#pragma mark  检测APP-STORE版本
//+ (void)checkAPPStoreVersionWithgetSuccess:( void (^)(NSString  *versionId,NSString *VersionUrl))getSuccess;
//
//#pragma mark  获取焦点列表
//+ (void)getHomeSlideWithgetSuccess:( void (^)(NSArray *imgArry))getSuccess failure:( void(^)(NSError *error) )failure;
//

//#pragma mark 上传图片接口
//+ (void)uploadImgWithParams:(NSDictionary *)Params imgName:(UIImage *)imgName  uploadSuccess:( void (^)(NSString  *message,NSString *imgUrlStr))uploadSuccess  uploadFailure:( void(^)(NSError *error) )uploadFailure;

//#pragma mark -  上传车辆片
//


#pragma mark -  获取省份地区
+(void)getProvinceWith:(void (^)(NSArray *provinceModelArry, int totalCount) ) getModelSuccess  getModelFailure:( void(^)(NSError *error) )getModelFailure;

#pragma mark -  获取地区城市
+(void)getCityWithProvince:(NSString *)ProvinceID getModelSuccess:( void (^)(NSArray *cityModelArry, int totalCount) ) getModelSuccess  getModelFailure:( void(^)(NSError *error) )getModelFailure;


//#pragma mark - 获取用户ID
//+ (NSString *)getUid;


//#pragma mark - 获取手机品牌
//+ (NSString *)getPhoneBrand;
//
//#pragma mark - 获取手机系统
//+ (NSString *)getPhoneOS;
//
//#pragma mark - 获取手机型号
//+ (NSString *)getPhoneDevice;
//
//#pragma mark - 获取APP version
//+ (NSString *)getAPPVersion;
//
//


#pragma mark 上传图片接口
//+ (void)uploadImgWithImgName:(UIImage *)imgName  uploadSuccess:( void (^)(NSString  *message,NSString *imgUrlStr))uploadSuccess  uploadFailure:( void(^)(NSError *error) )uploadFailure;


@end
