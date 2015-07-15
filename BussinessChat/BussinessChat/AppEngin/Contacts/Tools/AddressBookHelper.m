//
//  AddressBookHelper.m
//  BussinessChat
//
//  Created by zhisheshe on 15-4-23.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "AddressBookHelper.h"
#import "ChineseToPinyin.h"



static void readAddressBookContacts(ABAddressBookRef addressBook, void (^completion)(NSArray *contacts)) {
    
    NSArray *contacts = (__bridge NSArray *)(ABAddressBookCopyArrayOfAllPeople(addressBook));

    completion(contacts);

}



@implementation AddressBookHelper


//+ (void)readAddressBookContacts:(ABAddressBookRef addressBook,void (^)(NSArray *contacts)completion{
//    
//    NSArray *contacts = (__bridge NSArray *)(ABAddressBookCopyArrayOfAllPeople(addressBook));
//    
//    completion(contacts);
//
//}


#pragma mark - 读取手机通讯录
+ (void)fetchContacts:(void (^)(NSArray *contacts))getSuccess failure:(void (^) (NSError *error))getfailure{
    
//    if (ABAddressBookRequestAccessWithCompletion) {
//        
        CFErrorRef error;
//
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
//
////        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
//        
//        
//        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                
//                if (!granted) {  //不同意
//                    if (getfailure) {
//                        getfailure((__bridge NSError *) error);
//                    }
//                    
//                }else{
//                    
//                    readAddressBookContacts(addressBook,getSuccess);
//                }
//            });
//            
//        });
////        CFRelease(addressBook);
//    }
    
    BOOL status =  [self checkAddressBookAuthorizationStatus];
    
    if (status == YES) {
        
      
        readAddressBookContacts(addressBook, getSuccess);
       
    }
    
}


#pragma mark - 获取所有联系人，并进行排序
+ (void)getAddressBook:(void(^)(NSArray *contacts))completion{
    
    [self fetchContacts:^(NSArray *contacts) {
     
        NSArray *sortedArry =[contacts sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            
            
            NSString *fullName1 = (NSString *)CFBridgingRelease(ABRecordCopyCompositeName((__bridge ABRecordRef)(obj1)));
            
            NSString *fullName2 = (NSString *)CFBridgingRelease(ABRecordCopyCompositeName((__bridge ABRecordRef)(obj2)));
            
            int lenth = [fullName1 length] > [fullName2 length] ?[fullName2 length]:[fullName1 length];
            
            NSLocale *local = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_hans"];
            
            
            return [fullName1 compare:fullName2 options:NSCaseInsensitiveSearch range:NSMakeRange(0,lenth) locale:local];
        }];
 
        
        if (completion) {
            completion(sortedArry);
        }
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark - 对联系人进行分组排序
+ (void)sortDataArry:(void(^)(NSArray *contacts))completion{
    
    //建立索引的核心，生成a-z，#等索引字段
    UILocalizedIndexedCollation *indexCollation = [UILocalizedIndexedCollation currentCollation];
    
    NSMutableArray *indexCollectionArry = [NSMutableArray arrayWithArray:[indexCollation sectionIndexTitles]];
    
     MyLog(@"indexCollectionArry  %@",indexCollectionArry);

    //返回section的个数,a-z#共27个
    NSUInteger  sectionCount = indexCollectionArry.count;
    
    
    //创建一个数量为sectionCount的SectionArry;
    NSMutableArray *sectionArry = [NSMutableArray arrayWithCapacity:sectionCount];
    
     MyLog(@"sectionArry  %@",sectionArry);
    
    
    //在每个section数组中，创建一个内容为1的数组
    for (int i = 0; i < sectionCount; i ++) {
        NSMutableArray *rowArry = [NSMutableArray arrayWithCapacity:1];
       
        [sectionArry addObject:rowArry];
      
    }

     MyLog(@"afawfaewSeconArry  %d---%@",sectionArry.count, sectionArry);
    
    [self getAddressBook:^(NSArray *contacts) {
        
        
        for (int i = 0; i < contacts.count ; i ++) {
            
            //从联系数组中取出每一个联系人
            id person = contacts[i];
            
            //名字
            NSString *fullName = (NSString *)CFBridgingRelease(ABRecordCopyCompositeName((__bridge ABRecordRef)(person)));
            
            //手机号
            ABMultiValueRef tempphone = ABRecordCopyValue((__bridge ABRecordRef)(person), kABPersonPhoneProperty);
            
            NSString * phone = nil;
            
            if ((tempphone != nil) && ABMultiValueGetCount(tempphone)> 0) {
                
                for (int m = 0; m < ABMultiValueGetCount(tempphone); m++) {
                    phone = (__bridge NSString *)ABMultiValueCopyValueAtIndex(tempphone, m) ;
             
                }
            }
            
            
            //将名字转换成pinyin,然后进行排序
            NSString *firstLetter = [ChineseToPinyin pinyinFromChiniseString:fullName];
            
            NSInteger sectionID = 0;
            
            if (firstLetter) {
                //根据转换后的名字的首字母，得出在section（外层）数组中的索引位置
                sectionID = [indexCollation sectionForObject:[firstLetter substringToIndex:1] collationStringSelector:@selector(uppercaseString)];

            }else{
                sectionID  = 27;
            }
            
            
            //根据有索引的位置，取出外层对应索引位置的数据，并将内容存入数组
            NSMutableArray *temArry = sectionArry[sectionID];
            AddressModel *model = [[AddressModel alloc]init];
            model.name = fullName;
            model.mobile = phone;
            
            [temArry addObject:model];
        }

        
        if (completion) {
            completion(sectionArry);
        }

        
    }];
    
    
}


#pragma mark - 通讯录更新回调
+ (void)callBack{
    
    
}


+ (BOOL)checkAddressBookAuthorizationStatus{
    
    ABAuthorizationStatus authStaus = ABAddressBookGetAuthorizationStatus();
    
    
    CFErrorRef error;
    
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);

    
    
    if (authStaus != kABAuthorizationStatusAuthorized) {
        
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (error) {
                    if (!granted) {
                         FCAlert(@"authorization Deny");
                    }
                   
                }else{
                    
                    
                }
  
            });
            
        });

    }
    
    return authStaus == kABAuthorizationStatusAuthorized;
    
   
//    NSArray *contacts = (__bridge NSArray *)(ABAddressBookCopyArrayOfAllPeople(addressBook));
//    
//    if (ABAddressBookRequestAccessWithCompletion) {
//        
//        
//        //        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
//        
//        
//        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                
//                if (!granted) {  //不同意
//                    if (getfailure) {
//                        getfailure((__bridge NSError *) error);
//                    }
//                    
//                }else{
//                    
//                    readAddressBookContacts(addressBook,getSuccess);
//                }
//            });
//            
//        });
//        //        CFRelease(addressBook);
//    }

}


@end
