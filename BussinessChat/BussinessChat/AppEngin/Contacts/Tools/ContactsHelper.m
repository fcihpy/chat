//
//  ContactsHelper.m
//  BussinessChat
//
//  Created by zhisheshe on 15-4-30.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "ContactsHelper.h"
#import "XmppHelper.h"
#import "ChineseToPinyin.h"



@implementation ContactsHelper
singleton_implementation(ContactsHelper)



#pragma mark -获取好友列表

+ (void)fetechBuddyList:(void(^)(NSArray *buddylist))buddylist{
    

    if (buddylist) {
        buddylist([[XmppHelper sharedInstance] buddylist]);
        
    }
    
}

#pragma mark -- 根据好友列表的ID获取真实名字

+ (void)getPersoninfo:(void(^)(NSArray *personArry,NSArray *idArry))personArry{
    
    NSMutableArray *temyArry = [NSMutableArray array];
    NSMutableArray *idArry = [NSMutableArray array];
    
    //获取好友列表
    [self fetechBuddyList:^(NSArray *buddylist) {
        
        MyLog(@"buddylistArry %@--",buddylist);
        
        
//        for (int i = 0; i < buddylist.count; i ++) {
//            
//            
//            //根据好友ID获取名字
//            [PersonManager getPersonInfoWithuid:buddylist[i] getPersonModelSuccess:^(personModel *model) {
//                
//                //将好友名字存到数组中
//                [temyArry addObject:model.truename];
//                
//                MyLog(@"rwwrwrwe-- %d %@--%@", i, buddylist[i],model.truename);
//                
//                //如果返回的数组个数和遍历数组
//                if (buddylist.count == temyArry.count) {
//                    
//                    if (personArry) {
//                        personArry(temyArry,buddylist);
//                    }
//                    
//                    MyLog(@"wwwww%@--%@",temyArry,buddylist);
//                }
//                
//            } failure:^(NSError *error) {
//                
//            }];
//
//
//        }

        
        //取出列表中每个好友
        [buddylist enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            
            //根据好友ID获取名字
            [PersonManager getPersonInfoWithuid:obj getPersonModelSuccess:^(personModel *model) {
                
                //将好友名字存到数组中
                [temyArry addObject:model.truename];
                [idArry addObject:buddylist[idx]];
                
//                MyLog(@"rwwrwrwe-- %d %@--%@", idx, idArry[idx],model.truename);
                
                //如果返回的数组个数和遍历数组
                if (buddylist.count == temyArry.count) {
                    
                    if (personArry) {
                        personArry(temyArry,buddylist);
                    }
                    
                    MyLog(@"wwwww%@--%@",temyArry,buddylist);
                }
   
            } failure:^(NSError *error) {
                
            }];
    
        }];
    
      
    }];
    
}





#pragma mark -- 将好友名字进行排序


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

    
    [self getPersoninfo:^(NSArray *personArry,NSArray *idArry) {
    
        
       
        for (int i = 0; i < personArry.count ; i ++) {
            
            MyLog(@"asawgafaweefawerawrfawet %@-- %@",personArry[i],idArry[i]);
            
            //将名字转换成pinyin,然后进行排序
            NSString *firstLetter = [ChineseToPinyin pinyinFromChiniseString:personArry[i]];
            
            NSInteger sectionID = 0;
            
            if (firstLetter) {
                //根据转换后的名字的首字母，得出在section（外层）数组中的索引位置
                sectionID = [indexCollation sectionForObject:[firstLetter substringToIndex:1] collationStringSelector:@selector(uppercaseString)];
                
            }else{
                sectionID  = 27;
            }
            
            
            //根据有索引的位置，取出外层对应索引位置的数据，并将内容存入数组
            NSMutableArray *temArry = sectionArry[sectionID];

            NSDictionary *dict = @{@"name":personArry[i],@"id":idArry[i]};
            
            MyLog(@"aasfawrwtawrawf %@--%@",personArry[i],idArry[i]);

            [temArry addObject:dict];
        }
    
        
        if (completion) {
            completion(sectionArry);
        }
        

        
    }];
    
}






@end

//void test(){
//    
//    if ([@"result" isEqualToString:iq.type]) {
//        NSXMLElement *query = iq.childElement;
//        if ([@"query" isEqualToString:query.name]) {
//            NSArray *items = [query children];
//            for (NSXMLElement *item in items) {
//                NSString *jid = [item attributeStringValueForName:@"jid"];
//                NSLog(@"jid--%@",jid);
//                
//                //                  NSArray *strs=[displayName componentsSeparatedByString:@"@"];
//                XMPPJID *xmppJID = [XMPPJID jidWithString:jid];
//                [rosterArr addObject:xmppJID.user];
//            }
//        }
//    }
//    
//    _buddylistArry = [NSArray arrayWithArray:rosterArr];
//}
