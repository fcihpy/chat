//
//  MetaDataTool.m
//  车商官家
//
//  Created by zhisheshe on 14-11-8.
//  Copyright (c) 2014年 zhisheshe. All rights reserved.
//

#define kChoosedCityPlist [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"city.plist"]

#import "MetaDataTool.h"
#import "ProvinceModel.h"
#import "CityModel.h"

//#import "BrandModel.h"
//#import "BrandSectionModel.h"
//#import "CityModel.h"
//#import <CommonCrypto/CommonDigest.h>


@implementation MetaDataTool

singleton_implementation(MetaDataTool)

- (id)init
{
    if (self = [super init]) {
 
    }
    return self;
}




//
//+ (void)SavePersonModelWithKey:(NSString *)idstr  modelValue:(personModel *)modelValue  completion:(void (^)(NSMutableDictionary *personModelDict))completion{
//    
//    
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setObject:modelValue forKey:idstr];
//    
//    if (completion) {
//        completion(dict);
//        
//    }
// 
//}
//

//#pragma mark - fromidtopersoninfo
//+ (void)getPersonsInfoWithParams:(NSDictionary *)Params completion:(void (^)(NSMutableArray *PersonModelArry,NSError *error))completion{
//    
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    
//        [mgr GET:[NSString stringWithFormat:@"%@api.php?c=member&a=getdata_byids",URL_HEAD_STR] parameters:Params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//          
//            NSArray *modelFromResponse = [responseObject valueForKeyPath:@"list"];
//            NSMutableArray *mutableModels = [NSMutableArray arrayWithCapacity:[modelFromResponse count]];
//            int errorNumber = [[responseObject valueForKey:@"error"] intValue];
//            if (errorNumber != 0) {
//                UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:responseObject[@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                [alertView show];
//                
//            }else{
//
//                for (NSDictionary *attributes in modelFromResponse) {
//                EMChatModel *ChatModel = [[EMChatModel alloc]initWithDict:attributes];
//    
//                [mutableModels addObject:ChatModel];
//            }
//    
//            if (completion) {
//                completion(mutableModels, nil);
//            }
//          }
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            if (completion) {
//                completion([NSMutableArray array],error);
//            }
//            
//        }];
//
//    
//}
//
//
//
//#pragma mark --- -----------------------------------------------------登录注册----------------------------------------------------
//
//#pragma mark - 修改个人信息
//
//+ (void)modifyPersonInfoWithPramas:(NSDictionary *)Pramas modifSuccess:(void (^)(NSString *message))modifSuccess failure:(void (^)(NSError *))failure{
//  
//    NSString *uid = [self getUid];
//   
//    [[NetWorkClient sharedClient] POST:[NSString stringWithFormat:@"api.php?c=member&a=modifymember&userid=%@",uid] parameters:Pramas success:^(NSURLSessionDataTask *task, id responseObject) {
//        MyLog(@"respone is %@",responseObject);
//        
////        //获取错误码
////        int errorNumber = [[responseObject valueForKey:@"error"] intValue];
//        NSString *message = responseObject[@"message"];
//        
//        if (modifSuccess) {
//            modifSuccess(message);
//        }
//
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//        if (failure) {
//            failure(error);
//        }
//    }];
//    
//
//    
//    
////    
////    [mgr POST:[NSString stringWithFormat:@"%@/api.php?c=member&a=modifymember&userid=%@",URL_HEAD_STR,uid] parameters:Pramas success:^(AFHTTPRequestOperation *operation, id responseObject) {
////        MyLog(@"respone is %@",responseObject);
////        int errorNumber = [[responseObject valueForKey:@"error"] intValue];
////        if (errorNumber != 0) {
////            
////            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:responseObject[@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
////            [alertView show];
////
////        }else{
////            
////           
////            if (modifSuccess) {
////                modifSuccess(responseObject[@"message"]);
////            }
////    
////        }
////        
////        
////    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
////       
////        if (failure) {
////            failure(error);
////        }
////
////    }];
////
//    
//}
//
//
//
//#pragma mark - 获取个人信息
//+ (void)getPersonInfoWithuid:(NSString *)uid getPersonModelSuccess:(void (^)(personModel *))getPersonModelSuccess failure:(void (^)(NSError *))failure{
//    
//    
//    [[NetWorkClient sharedClient] GET:[NSString stringWithFormat:@"/api.php?c=member&a=getdata_byid&userid=%@",uid] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//        //获取错误码
//        int errorNumber = [[responseObject valueForKey:@"error"] intValue];
//        
//               
//        //根据错误码进行判断，如是0进行解析，否则弹出alter
//        if (errorNumber != 0) {
//            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:responseObject[@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alertView show];
//            
//        }else{
//            
//            
//            //初始一个临时数组，用于接收list对应的字段内容
//            NSArray *JsonArry = [NSArray array];
//            
//            //解析json数据,读取字典中List字段的数据，形成数组
//            JsonArry = responseObject[@"list"];
//            
//            //先判断数组是否为空，防止数组越界引起系统崩溃
//            if (JsonArry !=nil && ![JsonArry isKindOfClass:[NSNull class]]  && JsonArry.count !=0) {
//                
//                
//                //遍历数组，并将字典转换为模型，存放到临时数组中。
//                for (NSDictionary *JsonDict in JsonArry) {
//                    
//                    //判断字典内容是否为空
//                    if (JsonDict !=nil && ![JsonDict isKindOfClass:[NSNull class]]){
//                        
//                        personModel *model = [[personModel alloc]initWithDict:JsonDict];
//                        if (getPersonModelSuccess) {
//                            getPersonModelSuccess(model);
//                        }
//
//                    }
//                    
//                }
//                
//            }
//            
//        }
//
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//        
//    }];
//    
//    
//    
//    
//    
//    
////    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
////    
////    [mgr GET:[NSString stringWithFormat:@"%@/api.php?c=member&a=getdata_byid&userid=%@",URL_HEAD_STR,uid]parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
////        
////        int errorNumber = [[responseObject valueForKey:@"error"] intValue];
////        if (errorNumber != 0) {
////            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:responseObject[@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
////            [alertView show];
////            
////        }else{
////            //初始化一个存放模型数据的字典
////            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
////
////            
////            //解析json数据,读取字典中List字段的数据，形成进一步的字典
////            dict = responseObject[@"list"];
////            
////            //将字典转换为模型，然后存放到block中
////            personModel *model = [[personModel alloc]initWithDict:responseObject[@"list"][0]];
////            if (getPersonModelSuccess) {
////                 getPersonModelSuccess(model);
////            }
////           
////     
////        }
////        
////    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
////        failure(error);
////    }];
////
//    
//}
//
//#pragma mark - 获取通知消息
//+ (void)getNotiMessageWithMessagetype:(NSInteger)type page:(NSInteger)page  getNotifModelSuccess: ( void (^)(NSMutableArray *NotifModelArry) ) getNotifModelSuccess failure:( void(^)(NSError *error) )failure;{
//    
//    NSString *uid = [self getUid];
//    [[NetWorkClient sharedClient] GET:[NSString stringWithFormat:@"api.php?c=Message&a=get_message&uid=%@&type=%ld&page=%ld",uid,type,page] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//        MyLog(@"pushNotif-message--- %@",responseObject);
//        int errorNumber = [[responseObject valueForKey:@"error"] intValue];
//        if (errorNumber != 0) {
////            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:responseObject[@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
////            [alertView show];
//            
//        }else{
//            
//            //初始化一个存放模型数据的可变数组
//            NSMutableArray *modelarry = [NSMutableArray array];
//            
//            NSArray *JsonArry = [NSArray array];
//            
//            //解析json数据,读取字典中List字段的数据，形成数组
//            JsonArry = responseObject[@"list"];
//            
//            
//            if (arryAndDicIsNotNull(JsonArry)) {
//                //遍历数组，并将字典转换为模型，存放到数组中。
//                for (NSDictionary *dict in JsonArry) {
//                    if (arryAndDicIsNotNull(dict)) {
//                        NSString *messageid = dict[@"id"];
//                        MyLog(@"adasgsdgaerwgw %@",messageid);
//                        if (stringIsNotNull(messageid)) {
//                            notifModel *model = [[notifModel alloc]initWithDict:dict];
//                            
//                            [modelarry addObject:model];
//                        }
//                       
//                    }
//                   
//                    
//                }
//            }
//            
//           
//            if (getNotifModelSuccess) {
//                getNotifModelSuccess(modelarry);
//            }
//            
//        }
//        
//
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
//    
//    
//    
////    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
////    
////    [mgr GET:[NSString stringWithFormat:@"%@/api.php?c=Message&a=get_message&uid=%@&page=%ld&type=%ld",URL_HEAD_STR,uid,(long)page,(long)type] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
////        MyLog(@"notifi is %@",responseObject);
////        int errorNumber = [[responseObject valueForKey:@"error"] intValue];
////        if (errorNumber != 0) {
////            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:responseObject[@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
////            [alertView show];
////            
////        }else{
////            
////            //初始化一个存放模型数据的可变数组
////            NSMutableArray *modelarry = [NSMutableArray array];
////            
////            NSArray *JsonArry = [NSArray array];
////            
////            //解析json数据,读取字典中List字段的数据，形成数组
////            JsonArry = responseObject[@"list"];
////            
////            //遍历数组，并将字典转换为模型，存放到数组中。
////            for (NSDictionary *dict in JsonArry) {
////                notifModel *model = [[notifModel alloc]initWithDict:dict];
////                
////                [modelarry addObject:model];
////                
////            }
////            if (getNotifModelSuccess) {
////                getNotifModelSuccess(modelarry);
////            }
////            
////        }
////        
////    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
////        if (failure) {
////            failure(error);
////        }
////    }];
// 
//}
//
//
//#pragma mark - 获取、修改消息
//+ (void)getNotiMessageWithPath:(NSString *)path Pramas:(NSDictionary *)Pramas getNotifModelSuccess:(void (^)(NSString *message))getNotifModelSuccess failure:(void (^)(NSError *))failure{
//   
//   
//    NSString *uid = [self getUid];
//    
//    
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    
//    [mgr GET:[NSString stringWithFormat:@"%@/api.php?c=Message&%@&uid=%@",URL_HEAD_STR,path,uid] parameters:Pramas success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        MyLog(@"notifi is %@",responseObject);
//        int errorNumber = [[responseObject valueForKey:@"error"] intValue];
//        if (errorNumber != 0) {
//            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:responseObject[@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alertView show];
//            
//        }else{
//
//            if (getNotifModelSuccess) {
//                getNotifModelSuccess([responseObject valueForKey:@"message"]);
//            }
//            
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
//}
//
//#pragma mark - 获取用户ID
//+ (NSString *)getUid{
//    NSString *uid = [NSString string];
//    uid = [AccountTools sharedAccountTools].account.uid;
//    return uid;
//}
//
//
//
//
//#pragma mark ------------------------------------------------------------车源------------------------------------------------------
//
//
//#pragma mark - 10、获取车源列表
//+ (void)getCarDataWithPath:(NSString *)path Params:(NSDictionary *)Params getModelSuccess:(void (^)(NSArray *, int))getModelSuccess getModelFailure:(void (^)(NSError *))getModelFailure{
//
//    
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//
//    [mgr GET:[NSString stringWithFormat:@"%@/api.php?c=auto&%@",URL_HEAD_STR,path]parameters:Params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//      //获取错误码
//        int errorNumber = [[responseObject valueForKey:@"error"] intValue];
//       //获取总条数
//       // int totalcount = [[responseObject valueForKey:@"count"] valueForKey:@"count" ]intValue];  //接口用
//        int totalcount = [[responseObject valueForKey:@"count"]intValue];
//        
//        //根据错误码进行判断，如是0进行解析，否则弹出alter
//        if (errorNumber != 0) {
//            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:responseObject[@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alertView show];
//            
//        }else{
//            
//            //初始一个临时数组,用于存放model数据
//            NSMutableArray *tempArry = [NSMutableArray array];
//            
//             //初始一个临时数组，用于接收list对应的字段内容
//            NSArray *JsonArry = [NSArray array];
//            
//            //根据取出List对应的数据进行判断，有值再进行解析
//            if (responseObject[@"list"]) {
//                
//                //解析json数据,读取字典中List字段的数据，形成数组
//                JsonArry = responseObject[@"list"];
//                
//                //遍历数组，并将字典转换为模型，存放到临时数组中。
//                for (NSDictionary *dict in JsonArry) {
//                    CarResourceModel *model = [[CarResourceModel alloc]initWithDict:dict];
//                    [tempArry addObject:model];
//                }
//                
//                //初始化一个存放模型数据的不可变数组
//                NSArray *modelarry = [NSArray arrayWithArray:tempArry];
//                
//                if (getModelSuccess) {
//                    getModelSuccess(modelarry,totalcount);
//                }
//            }
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        getModelFailure(error);
//    }];
//
//}
//
//#pragma mark - 13、获取在售车辆
//
//+ (void)getCarSaleWithParams:(NSDictionary *)Params CarModelSuccess:(void (^)(NSArray *CarModelArry, int))CarModelSuccess failure:(void (^)(NSError *))failure{
//    
//    
//    [self getCarDataWithPath:@"a=getautolistbystatus&" Params:Params getModelSuccess:^(NSArray *CarModelArry, int totalCount) {
//        if (CarModelSuccess) {
//            CarModelSuccess(CarModelArry,totalCount);
//        }
//    } getModelFailure:^(NSError *error) {
//        
//        if (failure) {
//            failure(error);
//        }
//    }];
//}
//
//
//#pragma mark - 14、获取已售车辆
//
//+ (void)getCarSoleWithParams:(NSDictionary *)Params CarModelSuccess:(void (^)(NSArray *CarModelArry, int))CarModelSuccess failure:(void (^)(NSError *))failure{
//    
//    [self getCarDataWithPath:@"a=getautolistbystatus&" Params:Params getModelSuccess:^(NSArray *CarModelArry, int totalCount) {
//        if (CarModelSuccess) {
//            CarModelSuccess(CarModelArry,totalCount);
//        }
//    } getModelFailure:^(NSError *error) {
//        
//        if (failure) {
//            failure(error);
//        }
//    }];
//
//}
//
//
//#pragma mark - 15、获取下架车列表
//+ (void)getCarOffWithParams:(NSDictionary *)Params CarModelSuccess:(void (^)(NSArray *CarModelArry, int))CarModelSuccess failure:(void (^)(NSError *))failure{
//    
//    [self getCarDataWithPath:@"a=getautolistbystatus&" Params:Params getModelSuccess:^(NSArray *CarModelArry, int totalCount) {
//        if (CarModelSuccess) {
//            CarModelSuccess(CarModelArry,totalCount);
//        }
//    } getModelFailure:^(NSError *error) {
//        
//        if (failure) {
//            failure(error);
//        }
//    }];
//}
//
//#pragma mark - 16、获取收藏车列表
//+ (void)getFavorieCarModelWithUid:(NSString *)uid page:(int)page getFavorieCarModelSuccess:(void (^)(NSMutableArray *))getFavorieCarModelSuccess failure:(void (^)(NSError *))failure{
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    [mgr GET:[NSString stringWithFormat:@"%@/api.php?m=api&c=favorite&a=getallfavorite&uid=%@&page=%d",URL_HEAD_STR,uid,page]parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        int errorNumber = [[responseObject valueForKey:@"error"] intValue];
//        if (errorNumber != 0) {
//            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:responseObject[@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alertView show];
//            
//        }else{
//            //初始化一个存放模型数据的可变数组
//            NSMutableArray *modelarry = [NSMutableArray array];
//            
//            NSArray *JsonArry = [NSArray array];
//            
//            //解析json数据,读取字典中List字段的数据，形成数组
//            
//            if (responseObject[@"list"]) {
//                JsonArry = responseObject[@"list"];
//                if (JsonArry.count == 0) {
//                    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还没有收藏车辆" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                    [alertView show];
//
//                }
//                
//                //遍历数组，并将字典转换为模型，存放到数组中。
//                for (NSDictionary *dict in JsonArry) {
//                    CarResourceModel *model = [[CarResourceModel alloc]initWithDict:dict];
//                    
//                    [modelarry addObject:model];
//                    
//                    
//                }
//                if (getFavorieCarModelSuccess) {
//                    getFavorieCarModelSuccess(modelarry);
//                }
//                
//
//            }
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failure(error);
//    }];
//    
//}
//
//
///#pragma mark - 获取统计信息
//+ (void)getstatisWithParams:(NSDictionary *)Params getSuccess:(void (^)(StatisModel *))getSuccess failure:(void (^)(NSError *))failure{
//    
//    
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    
//    [mgr GET:[NSString stringWithFormat:@"%@/api.php?c=auto&a=my_count",URL_HEAD_STR]parameters:Params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        MyLog(@"getstatis json is %@",responseObject);
//        int errorNumber = [[responseObject valueForKey:@"error"] intValue];
//        if (errorNumber != 0) {
//            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:responseObject[@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alertView show];
//            
//        }else{
//            //初始化一个存放模型数据的字典
//            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//            
//            
//            //解析json数据,读取字典中List字段的数据，形成进一步的字典
//            dict = responseObject[@"list"];
//            
//            //将字典转换为模型，然后存放到block中
//            StatisModel *model = [[StatisModel alloc]initWithDict:dict];
//            if (getSuccess) {
//                getSuccess(model);
//            }
//            
//            
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failure(error);
//    }];
//    
//}
//
//
//
//
//#pragma mark - 41、融资车辆列表
//+(void)getCarFinanceWithParams:(NSDictionary *)Params CarModelSuccess:(void (^)(NSArray *, int))CarModelSuccess failure:(void (^)(NSError *))failure{
//    
//    [self getCarDataWithPath:@"a=get_isfinance&" Params:Params getModelSuccess:^(NSArray *CarModelArry, int totalCount) {
//        if (CarModelSuccess) {
//            CarModelSuccess(CarModelArry,totalCount);
//        }
//        
//    } getModelFailure:^(NSError *error) {
//        
//        if (failure) {
//            failure(error);
//        }
//    }];
//}
//
//#pragma mark ------------------------------------------------------------其它-------------------------------------
//
//#pragma mark - 91、上传点户点击统计信息
//
//+ (void)uploadUserClickWithPramas:(NSDictionary *)Pramas uploadSuccess:(void (^)(NSString *))uploadSuccess uploadFailure:(void (^)(NSError *))uploadFailure{
//    
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    
//    SetGetUIDCID * getUID = [[SetGetUIDCID alloc]init];
//    NSString *uid = [NSString stringWithFormat:@"%d",[getUID getUID]];
//
//    
//    [mgr GET:[NSString stringWithFormat:@"%@/api.php?m=api&c=Count&a=count_add&kuid=%@",URL_HEAD_STR,uid]parameters:Pramas success:^(AFHTTPRequestOperation *operation, id responseObject) {
//
//        int errorNumber = [[responseObject valueForKey:@"error"] intValue];
//        
//        if (errorNumber != 0) {
//            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:responseObject[@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alertView show];
//            
//        }else{
//
//            if (uploadSuccess) {
//                uploadSuccess(responseObject[@"message"]);
//            }
//        }
//   
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
//    {
//        uploadFailure(error);
//    }];
//    
//}
//
#pragma mark 上传图片接口
+ (void)uploadImgWithImgName:(UIImage *)imgName  uploadSuccess:( void (^)(NSString  *message,NSString *imgUrlStr))uploadSuccess  uploadFailure:( void(^)(NSError *error) )uploadFailure{
    
    
    [[NetWorkClient sharedClient] POST:@"home/index/upload_img" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:UIImageJPEGRepresentation(imgName, 0.05) name:@"carImage" fileName:@"iconImage.jpg" mimeType:@"jpg"];
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
//        // 获取错误码
//        int errorNumber = [[responseObject valueForKey:@"error"] intValue];
//        
//        //根据错误码进行判断，如是0进行解析，否则弹出alter
//        if (errorNumber != 0) {
//            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:responseObject[@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alertView show];
//            
//        }else{
//            //初始一个临时数组，用于接收list对应的字段内容
//            NSArray *JsonArry = [NSArray array];
//            
//            //解析json数据,读取字典中List字段的数据，形成数组
//            JsonArry = responseObject[@"list"];
//            
//            //根据取出List对应的数据进行判断，有值再进行解析
//            if (arryAndDicIsNotNull(JsonArry)) {
//                NSDictionary *dict = responseObject[@"list"][0];
//                
//                if (arryAndDicIsNotNull(dict)) {
//                    NSString *imgUrlStr =  dict[@"img"];
//                    
//                    if (stringIsNotNull(imgUrlStr)) {
//                        if (uploadSuccess) {
//                            uploadSuccess(@"图片上传成功",imgUrlStr);
//                        }
//                        
//                    }
//                }
//                
//            }
//            
//            
//        }
        
        MyLog(@"tetata uploadimg %@",responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
         FCAlert(error.description);
    }];
    
}
//
//
//#pragma mark - 检测版本
//+ (void)checkVersion:(NSString *)CurrentVersion  getSuccess:( void (^)(NSString  *versionId,NSString *VersionUrl,NSString *content))getSuccess {
//    
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    [mgr GET:[NSString stringWithFormat:@"%@/api.php?m=api&c=Sysclassdata&a=getdate&codename=app_version_ios",URL_HEAD_STR]parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        MyLog(@"respngagag %@",responseObject);
//        int errorNumber = [[responseObject objectForKey:@"error"] intValue];
//        
//        if (errorNumber != 0) {
//            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"检测到新版本" message:responseObject[@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alertView show];
//        }else{
//            
//            
//            //初始一个字典,用于存放解析后json数据
//            NSDictionary *dict = [NSDictionary  dictionary];
//            
//            //初始一个临时数组，用于接收list对应的字段内容
//            NSArray *JsonArry = [NSArray array];
//            
//            //解析json数据,读取字典中List字段的数据，形成数组
//            JsonArry = responseObject[@"list"];
//            
//            if (arryAndDicIsNotNull(JsonArry)) {
//                
//                dict = JsonArry[0];
//                if (arryAndDicIsNotNull(dict)) {
//                    
//                    NSString *versionUrl = dict[@"url"];
//                    NSString *versionId = dict[@"name"];
//                    NSString *content = dict[@"content"];
//                    
//                    if (getSuccess) {
//                        getSuccess(versionId,versionUrl,content);
//                    }
//                }
//            }
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
//     {
//        MyLog(@"ggsadgasg");
//     }];
//
//}
//
//#pragma mark  检测APP-STORE版本
//+ (void)checkAPPStoreVersionWithgetSuccess:( void (^)(NSString  *versionId,NSString *VersionUrl))getSuccess{
//    
//    [[AFHTTPRequestOperationManager manager] GET:APP_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        
//        NSDictionary *dict = responseObject[@"results"][0];
//        
//        if (arryAndDicIsNotNull(dict)) {
//            
//            NSString *versionUrl = dict[@"trackViewUrl"];
//            NSString *versionId = dict[@"version"];
//            
//            if (getSuccess) {
//                getSuccess(versionId,versionUrl);
//            }
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//    }];
//}
//
//
//#pragma mark -  获取焦点列表
//+ (void)getHomeSlideWithgetSuccess:( void (^)(NSArray *imgArry))getSuccess failure:( void(^)(NSError *error) )failure{
//    
//    [[NetWorkClient sharedClient] GET:kHomeSlide parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        //获取错误码
//        int errorNumber = [[responseObject valueForKey:@"error"] intValue];
//        
//        //根据错误码进行判断，如是0进行解析，否则弹出alter
//        if (errorNumber != 0) {
//            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:responseObject[@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alertView show];
//            
//        }else{
//            MyLog(@"responseObject====%@",responseObject);
//            //初始一个字典,用于存放解析后json数据
//            NSMutableArray *tempArry = [NSMutableArray  array];
//            
//            //初始一个临时数组，用于接收list对应的字段内容
//            NSArray *JsonArry = [NSArray array];
//            
//            //初始化一个字符串
//            NSString *imgurl = [NSString string];
//            NSString *url = [NSString string];
//            NSString *name = [NSString string];
//            
//            //解析json数据,读取字典中List字段的数据，形成数组
//            JsonArry = responseObject[@"list"];
//            
//            //先判断数组是否为空，防止数组越界引起系统崩溃
//            if (arryAndDicIsNotNull(JsonArry)) {
//                
//                //遍历数组，并将字典转换为模型，存放到临时数组中。
//                for (NSDictionary *JsonDict in JsonArry) {
//                    
//                    //判断字典内容是否为空
//                    if (arryAndDicIsNotNull(JsonDict))
//                        
//                    imgurl  = JsonDict[@"pic"];
//                    url = JsonDict[@"url"];
//                    name = JsonDict[@"name"];
//                    
//                    NSMutableArray * array = [NSMutableArray array];
//                    [array addObject:imgurl];
//                    [array addObject:url];
//                    [array addObject:name];
//                    
//                    [tempArry addObject:array];
//                    
//                }
//            }
//            NSArray *imgArry = [NSArray arrayWithArray:tempArry];
//            
//            if (getSuccess) {
//                getSuccess(imgArry);
//            }
//        }
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
//}
//
//#pragma mark - 获取车型-品牌
//+(void)getBrandWith:( void (^)(NSArray *modelArry,int totalCount) ) getModelSuccess  getModelFailure:( void(^)(NSError *error) )getModelFailure{
//    
//   [[NetWorkClient sharedClient] GET:@"api.php?c=auto&a=getbrandfz" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//       
//       //获取错误码
//       int errorNumber = [[responseObject valueForKey:@"error"] intValue];
//       //获取总条数
//       // int totalcount = [[responseObject valueForKey:@"count"] valueForKey:@"count" ]intValue];  //接口用
//       //   int totalcount = [[responseObject valueForKey:@"count"]intValue];
//       
//       if (errorNumber != 0) {
//           UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:responseObject[@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//           [alertView show];
//           
//          
//       }else{
//       
//           //初始一个临时数组,用于存放model数据
//           NSMutableArray *tempArry = [NSMutableArray array];
//           
//           //建立索引的核心,作为Key值
//           UILocalizedIndexedCollation *indexCollation = [UILocalizedIndexedCollation currentCollation];
//           
//           //根据索引创建空数组，返回27，是a－z和＃  创造一个包含a－z的key值数组
//           NSMutableArray *sectionTitleArray = [NSMutableArray array];
//           [sectionTitleArray addObjectsFromArray:[indexCollation sectionTitles]];
//           
//           //初始一个临时数组，用于接收list对应的字段内容
//           NSArray *JsonArry = [NSArray array];
//           
//           //解析json数据,读取字典中List字段的数据，形成数组
//           JsonArry = responseObject[@"list"];
//           
//           //根据取出List对应的数据进行判断，有值再进行解析
//           if (arryAndDicIsNotNull(JsonArry)) {
//               
//               //根据Key值，取出value,返回的是一个数组，
//               for (int i = 0; i < sectionTitleArray.count; i ++) {
//                   //取出每个索引字母对应的数组,并加入到section数组中
//                   NSArray *arry = [responseObject[@"list"] valueForKey:sectionTitleArray[i]];
//                   if (arryAndDicIsNotNull(arry)) {
//                       BrandSectionModel  *brandSectionModel = [[BrandSectionModel alloc]initWithArry:arry];  //转换成model
//                       
//                       [tempArry addObject:brandSectionModel];
//                   }
//               }
//               NSArray *modeArry = [NSArray arrayWithArray:tempArry];
//               
//               if (getModelSuccess) {
//                   getModelSuccess(modeArry,27);
//               }
//           }
//       }
//       
//   } failure:^(NSURLSessionDataTask *task, NSError *error) {
//       if (getModelFailure) {
//           getModelFailure(error);
//       }
//       
//   }];
//}
//
//#pragma mark - 获取车型--系列
//+(void)getSeriesWithPid:(NSString *)PID  getModelSuccess:( void (^)(NSArray *modelArry, int totalCount) ) getModelSuccess  getModelFailure:( void(^)(NSError *error) )getModelFailure{
//    
//    [[NetWorkClient sharedClient] GET:[NSString stringWithFormat:@"api.php?c=auto&a=getautobrand&pid=%@",PID] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//       
//        //获取错误码
//        int errorNumber = [[responseObject valueForKey:@"error"] intValue];
//        //获取总条数
//        // int totalcount = [[responseObject valueForKey:@"count"] valueForKey:@"count" ]intValue];  //接口用
//        //   int totalcount = [[responseObject valueForKey:@"count"]intValue];
//        
//        //根据错误码进行判断，如是0进行解析，否则弹出alter
//        if (errorNumber != 0) {
//            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:responseObject[@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alertView show];
//            
//        }else{
//            
//            //初始一个临时数组,用于存放model数据
//            NSMutableArray *tempArry = [NSMutableArray array];
//            
//            //初始一个临时数组，用于接收list对应的字段内容
//            NSArray *JsonArry = [NSArray array];
//            
//            //解析json数据,读取字典中List字段的数据，形成数组
//            JsonArry = responseObject[@"list"];
//            
//            //根据取出List对应的数据进行判断，有值再进行解析
//            if (arryAndDicIsNotNull(JsonArry)) {
//                SeriesModel *model79999 = [[SeriesModel alloc]init];
//                model79999.seriesID = @"79999";
//                model79999.seriesName = @"不限";
//                [tempArry addObject:model79999];
//                //遍历数组，并将字典转换为模型，存放到临时数组中。
//                for (NSDictionary *dict in JsonArry) {
//                  
//                    if (arryAndDicIsNotNull(dict)) {
//                        SeriesModel *model = [[SeriesModel alloc]initWithDict:dict];
//                        
//                        [tempArry addObject:model];
//
//                    }
//                }
//                
//                //初始化一个存放模型数据的不可变数组
//                NSArray *modelarry = [NSArray arrayWithArray:tempArry];
//                
//                if (getModelSuccess) {
//                    getModelSuccess(modelarry,99);
//                }
//            }
//        }
//        
//      
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//        if (getModelFailure) {
//            getModelFailure(error);
//        }
//        
//    }];
//
//}
//
//#pragma mark - 获取车型--款系
//+(void)getStyleWithSeriesID:(NSString *)SeriesID  getModelSuccess:( void (^)(NSArray *modelArry, int totalCount) ) getModelSuccess  getModelFailure:( void(^)(NSError *error) )getModelFailure{
//    
//    [[NetWorkClient sharedClient] GET:[NSString stringWithFormat:@"api.php?c=auto&a=getautobrand&pid=%@",SeriesID] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        MyLog(@"gagaga.%@.",responseObject);
//        
//        //获取错误码
//        int errorNumber = [[responseObject valueForKey:@"error"] intValue];
//        //获取总条数
//        // int totalcount = [[responseObject valueForKey:@"count"] valueForKey:@"count" ]intValue];  //接口用
//        //   int totalcount = [[responseObject valueForKey:@"count"]intValue];
//        
//        //根据错误码进行判断，如是0进行解析，否则弹出alter
//        if (errorNumber != 0) {
//            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:responseObject[@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alertView show];
//            
//        }else{
//            
//            //初始一个临时数组,用于存放model数据
//            NSMutableArray *tempArry = [NSMutableArray array];
//            
//            //初始一个临时数组，用于接收list对应的字段内容
//            NSArray *JsonArry = [NSArray array];
//            
//            //解析json数据,读取字典中List字段的数据，形成数组
//            JsonArry = responseObject[@"list"];
//            
//            //根据取出List对应的数据进行判断，有值再进行解析
//            if (arryAndDicIsNotNull(JsonArry)) {
//                StyleModel *model8999 = [[StyleModel alloc]init];
//                model8999.styleID = @"0";
//                model8999.styleName = @"不限";
//                [tempArry addObject:model8999];
//                
//                
//                //遍历数组，并将字典转换为模型，存放到临时数组中。
//                for (NSDictionary *dict in JsonArry) {
//                    
//                    if (arryAndDicIsNotNull(dict)) {
//                        StyleModel *model = [[StyleModel alloc]initWithDict:dict];
//                        [tempArry addObject:model];
//                        
//                    }
//                }
//                
//                //初始化一个存放模型数据的不可变数组
//                NSArray *modelarry = [NSArray arrayWithArray:tempArry];
//                
//                if (getModelSuccess) {
//                    getModelSuccess(modelarry,99);
//                }
//            }
//        }
//        
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//        if (getModelFailure) {
//            getModelFailure(error);
//        }
//        
//    }];
//
//    
//    
//}
//
//#pragma mark -  获取省份地区城市
//+(void)getCityWith:( void (^)(NSArray *cityModelArry, int totalCount) ) getModelSuccess  getModelFailure:( void(^)(NSError *error) )getModelFailure{
//    
//    [[NetWorkClient sharedClient] GET:@"api.php?c=District&a=getdata_byarg&arg=0" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//        //获取错误码
//        int errorNumber = [[responseObject valueForKey:@"error"] intValue];
//
//        
//        //根据错误码进行判断，如是0进行解析，否则弹出alter
//        if (errorNumber != 0) {
//            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:responseObject[@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alertView show];
//            
//        }else{
//            
//            //初始一个临时数组,用于存放model数据
//            NSMutableArray *tempArry = [NSMutableArray array];
//            
//            //初始一个临时数组，用于接收list对应的字段内容
//            NSArray *JsonArry = [NSArray array];
//            
//            //解析json数据,读取字典中List字段的数据，形成数组
//            JsonArry = responseObject[@"list"];
//            
//            //根据取出List对应的数据进行判断，有值再进行解析
//            if (arryAndDicIsNotNull(JsonArry)) {
//                
//                //遍历数组，并将字典转换为模型，存放到临时数组中。
//                for (NSDictionary *dict in JsonArry) {
//                    
//                    if (arryAndDicIsNotNull(dict)) {
//                        CityModel *model = [[CityModel alloc]initWithDict:dict];
//                        [tempArry addObject:model];
//                    }
//                    
//                }
//                
//                //初始化一个存放模型数据的不可变数组
//                NSArray *modelarry = [NSArray arrayWithArray:tempArry];
//                
//                if (getModelSuccess) {
//                    getModelSuccess(modelarry,99);
//                }
//            }
//        }
//
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//        if (getModelFailure) {
//            getModelFailure(error);
//        }
//    }];
//    
//}


//#pragma mark -------------------------------------红包------------------------------
//#pragma mark - 使用规则
//+(void)getMonyBoxWithSuccess:( void (^)(NSMutableArray *messageArry) ) Success  getFailure:( void(^)(NSError *error) )getFailure{
//    
//    [[NetWorkClient sharedClient] GET:@"api.php?c=Red&a=sel_red_rule" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        MyLog(@"agagafgaegag %@",responseObject);
//        
//        //获取错误码
//        int errorNumber = [[responseObject valueForKey:@"error"] intValue];
//   
//        
//        //根据错误码进行判断，如是0进行解析，否则弹出alter
//        if (errorNumber != 0) {
//            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:responseObject[@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alertView show];
//            
//        }else{
//             NSMutableArray *messageArry = [NSMutableArray array];
//            
//            //初始一个字典,用于存放解析后json数据
//            NSDictionary *jsonDict = [NSDictionary  dictionary];
//            
//            //初始一个临时数组，用于接收list对应的字段内容
//            NSArray *JsonArry = [NSArray array];
//            
//            //解析json数据,读取字典中List字段的数据，形成数组
//            jsonDict = responseObject[@"list"];
//            if (arryAndDicIsNotNull(jsonDict)) {
//                
//                JsonArry = jsonDict[@"remark"];
//                for (NSString *str in JsonArry) {
//                    [messageArry addObject:str];
//                }
//                if (Success) {
//                    Success(messageArry);
//                }
//
//               
//              
//            }
//        }
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//    }];
//    
//}
//
//#pragma mark - 提取红包金额
//+ (void)getMoneyBoxNumberWithCode:(NSString *)code getSucess:(void(^)(NSString *money))getSucess getFailure:( void(^)(NSError *error) )getFailure{
//    NSString *uid = [AccountTools sharedAccountTools].account.uid;
//    
//    [[NetWorkClient sharedClient] GET:[NSString stringWithFormat:@"/api.php?c=Red&a=sel_red_count&uid=%@&yz=%@",uid,code] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//        //获取错误码
//        int errorNumber = [[responseObject valueForKey:@"error"] intValue];
//        
//        
//        //根据错误码进行判断，如是0进行解析，否则弹出alter
//        if (errorNumber != 0) {
//            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:responseObject[@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alertView show];
//            
//        }else{
//        
//            //初始一个字典,用于存放解析后json数据
//            NSDictionary *jsonDict = [NSDictionary  dictionary];
//            
//            //解析json数据,读取字典中List字段的数据，形成数组
//            jsonDict = responseObject[@"list"];
//            if (arryAndDicIsNotNull(jsonDict)) {
//                NSString *money = jsonDict[@"count"];
//                if (getSucess) {
//                    getSucess(money);
//                }
//            }
//
//        }
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//    }];
//}
//
//#pragma mark - 提取红包收支明细
//+ (void)getMoneyBoxDetailGetSucess:(void(^)(NSArray *dataArray))getSucess getFailure:( void(^)(NSError *error) )getFailure{
//    NSString *uid = [AccountTools sharedAccountTools].account.uid;
//    
//    NSString * _md5Str = [self md5:[NSString stringWithFormat:@"%@pch1208",[AccountTools sharedAccountTools].account.uid]];
//    
//    [[NetWorkClient sharedClient] GET:[NSString stringWithFormat:@"/api.php?c=Red&a=sel_red_log&uid=%@&yz=%@",uid,_md5Str] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//        //获取错误码
//        int errorNumber = [[responseObject valueForKey:@"error"] intValue];
//        
//        //根据错误码进行判断，如是0进行解析，否则弹出alter
//        if (errorNumber != 0) {
//            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:responseObject[@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alertView show];
//            
//        }else{
//            //解析json数据,读取字典中List字段的数据，形成数组
//            NSArray * jsonArry = responseObject[@"list"];
//            if (arryAndDicIsNotNull(jsonArry)) {
//                if (getSucess) {
//                    getSucess(jsonArry);
//                }
//            }
//            
//        }
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//    }];
//}
//
////md5加密
//+ (NSString *)md5:(NSString *)str {
//    
//    const char *cStr = [str UTF8String];
//    unsigned char result[32];
//    CC_MD5( cStr, strlen(cStr), result );
//    
//    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
//            result[0],result[1],result[2],result[3],
//            result[4],result[5],result[6],result[7],
//            result[8],result[9],result[10],result[11],
//            result[12],result[13],result[14],result[15]
//            ];
//}
//

#pragma mark -  获取省份地区
+(void)getProvinceWith:(void (^)(NSArray *provinceModelArry, int totalCount) ) getModelSuccess  getModelFailure:( void(^)(NSError *error) )getModelFailure{
    
    [[NetWorkClient sharedClient] GET:@"home/index/district?pid=0" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        MyLog(@"getProvincresponseObject %@",responseObject);
        
        //获取错误码
//        int errorNumber = [[responseObject valueForKey:@"error"] intValue];
        
        //获取总条数
//        int totalcount = [[responseObject valueForKey:@"count"]intValue];
        
//        错误信息
//        NSString *message = responseObject[@"message"];
        
        //根据错误码进行判断，如是0进行解析，否则弹出alter
//        if (errorNumber != 0) {
//            FCAlert(message);
            
//        }else{
        
            //初始一个临时数组,用于存放model数据
            NSMutableArray *tempArry = [NSMutableArray array];
            
            //初始一个临时数组，用于接收list对应的字段内容
            NSArray *JsonArry = [NSArray array];
        
            //解析json数据,读取字典中List字段的数据，形成数组
//            JsonArry = responseObject[@"list"];
        JsonArry = responseObject;
        
            //根据取出List对应的数据进行判断，有值再进行解析
//            if (arryAndDicIsNotNull(JsonArry)) {
        
                //遍历数组，并将字典转换为模型，存放到临时数组中。
                for (NSDictionary *dict in JsonArry) {
        
//                    if (arryAndDicIsNotNull(dict)) {
                        ProvinceModel *model = [[ProvinceModel alloc]initWithDict:dict];
                        [tempArry addObject:model];
//                    }
        
                }
        
                //初始化一个存放模型数据的不可变数组
                NSArray *modelarry = [NSArray arrayWithArray:tempArry];
                
                if (getModelSuccess) {
                    getModelSuccess(modelarry,99);
                }
//            }
//        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        MyLog(@"adasgag %@",error.description);
        if (getModelFailure) {
            getModelFailure(error);
        }
    }];
    
}

#pragma mark -  获取地区城市
+(void)getCityWithProvince:(NSString *)ProvinceID getModelSuccess:( void (^)(NSArray *cityModelArry, int totalCount) ) getModelSuccess  getModelFailure:( void(^)(NSError *error) )getModelFailure{
    
    [[NetWorkClient sharedClient] GET:[NSString stringWithFormat:@"home/index/district?pid=%@",ProvinceID] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        MyLog(@"getCityresponseObject %@",responseObject);
        
//        //获取错误码
//        int errorNumber = [[responseObject valueForKey:@"error"] intValue];
//        
//        //获取总条数
//        int totalcount = [[responseObject valueForKey:@"count"]intValue];
//        
//        //错误信息
//        NSString *message = responseObject[@"message"];
//        
//        //根据错误码进行判断，如是0进行解析，否则弹出alter
//        if (errorNumber != 0) {
//             FCAlert(message);
//            
//        }else{
        
            //初始一个临时数组,用于存放model数据
            NSMutableArray *tempArry = [NSMutableArray array];
            
            //初始一个临时数组，用于接收list对应的字段内容
            NSArray *JsonArry = [NSArray array];
            
            //解析json数据,读取字典中List字段的数据，形成数组
//            JsonArry = responseObject[@"list"];
         JsonArry = responseObject;
            
            //根据取出List对应的数据进行判断，有值再进行解析
//            if (arryAndDicIsNotNull(JsonArry)) {
        
                //遍历数组，并将字典转换为模型，存放到临时数组中。
                for (NSDictionary *dict in JsonArry) {
                    
//                    if (arryAndDicIsNotNull(dict)) {
                        CityModel *model = [[CityModel alloc]initWithDict:dict];
                        [tempArry addObject:model];
//                    }
                    
                }
                
                //初始化一个存放模型数据的不可变数组
                NSArray *modelarry = [NSArray arrayWithArray:tempArry];
                
                if (getModelSuccess) {
                    getModelSuccess(modelarry,99);
                }
//            }
//        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (getModelFailure) {
            getModelFailure(error);
        }
    }];
    
}

@end
