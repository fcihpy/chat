//
/*!
 @header FCMobheaders.h
 @abstract 引入SDK的所有需要的头文件
 @author fcihpy
 @version 1.0
 */


#ifndef BussinessChat_FCMobheaders_h



//defs

#pragma mark ------------------- 导入头文件
//第三方框架
#import "MJRefresh.h"
#import "MJExtension.h"
//#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+FC.h"
#import "DDLog.h"
#import "DDTTYLogger.h"



//Category
#import "UIView+FC.h"
#import "UIViewController+FC.h"
#import "UIView+FC.h"
#import "NSString+FC.h"
#import "NSDate+FC.h"
#import "NSString+Helper.h"



//自定义工具类
#import "Account.h"
#import "AccountTools.h"
#import "MetaDataTool.h"
#import "NetWorkClient.h"
#import "Singleton.h"
#import "FCUitility.h"



//自定义控件
#import"API.h"
#import "FCNavigationController.h"
#import "FCUitility.h"


//业务模块
#import "FriendCircleCommon.h"
#import "ChatCommon.h"
#import "Common.h"


#import "BaseViewWithTableViewController.h"
#import "BaseViewController.h"
#import "BaseModel.h"
#import "BaseSettingTableView.h"

//业务模块
#import "XmppHelper.h"
#import "XMPP.h"
#import "XMPPFramework.h"


#import "personManager.h"
#import "PersonModel.h"


//#import "TTGlobalUICommon.h"




// 2.日志输出宏定义
#ifdef DEBUG
// 调试状态
#define MyLog(...) NSLog(@"%s %d \n%@",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
// 发布状态
#define MyLog(...)
#endif


#define KNOTIFICATION_LOGINCHANGE @"loginStateChange"

#define screenH [UIScreen mainScreen].bounds.size.height
#define screenW [UIScreen mainScreen].bounds.size.width



#ifndef isNull
#define objectNull(a)  ( (a==nil) || ((NSNull*)a==[NSNull null]) )
#define stringIsNotNull(a)  ((a!=nil) && (![a isKindOfClass:[NSNull class]]) && (a.length != 0))
#define arryAndDicIsNotNull(a)   ((a != nil) && (![a isKindOfClass:[NSNull class]]) && (a.count !=0))
#endif //isNull

// 1.判断设备型号
#define kIphone4 [UIScreen mainScreen].bounds.size.height == 480


#define kIphone5   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 [UIScreen mainScreen].bounds.size.height == 568


#define kIphone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) : NO)
//#define iPhone6 [UIScreen mainScreen].bounds.size.height == 667

#define kIphone6Plus  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)
#define iPhone6Plus [UIScreen mainScreen].bounds.size.height == 736

//判断系统版本
#define kOSVersion  [[[UIDevice currentDevice] systemVersion ] floatValue]

//判断设备类型，iphone,ipad
#define kDeviceType [UIDevice currentDevice].mode
#define kIsPad  UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad



// 4.全局背景色
#define COLOR(R, G, B, A)  [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#define kClearColor [UIColor clearColor]
// 背景色
//全局的
#define kGlobalBg COLOR(234, 238, 242, 1)

//导航背景
#define kTabrNavBg COLOR(45, 48, 54, 1)

//列表背景
#define kTableViewBg COLOR(45, 48, 54, 1)

//透明白
#define kViewAlpa COLOR(255, 255, 255, 0.9)

//线条颜色
#define kLineColor  COLOR(208, 208, 208, 1)

#define kLineLoginColor  COLOR(106, 156, 175, 1)



//文字相关颜色
//list
#define kKeyColor COLOR(51, 51, 51, 1)
#define kValueColor COLOR(169, 169, 169, 1)
#define kPlaceHolderColor COLOR(197, 197, 197, 1)
#define kNameColor COLOR(69, 111, 181, 1)


//label
#define kLabelColor COLOR(255, 255, 255, 1)


//tabar
#define kTabrNorColor COLOR(131, 138, 145, 1)
#define kTabrPreColor COLOR(16, 249, 183, 1)

//button
#define kButtonNorColor COLOR(255, 255, 255, 1)
#define kButtonPreColor COLOR(7, 184, 136, 1)

//commitButton
#define kCommitBtnNorColor COLOR(255, 255, 255, 0.7)
#define kCommitBtnPreColor COLOR(255, 255, 255, 1)

#define kAlertColor COLOR(255, 235, 235, 1)


#pragma mark - ----------------------font--------------

#define kSys_Font(size) [UIFont systemFontOfSize:size]
#define kSys_Bold_Font(size) [UIFont boldSystemFontOfSize:size]
#define kSys_Itac_Font(size) [UIFont italicSystemFontOfSize:size]

#define kFont11 [UIFont systemFontOfSize:11]
#define kFont12 [UIFont systemFontOfSize:12]
#define kFont13 [UIFont systemFontOfSize:13]
#define kFont14 [UIFont systemFontOfSize:14]
#define kFont15 [UIFont systemFontOfSize:15]
#define kFont17 [UIFont systemFontOfSize:17]

#define kNavFont [UIFont systemFontOfSize:17]
#define kKeyFont [UIFont systemFontOfSize:14]
#define kValueFont [UIFont systemFontOfSize:13]



//判断系统版本
#ifndef __IOS_SYSTEM_VERSION_
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)

#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#endif //__IOS_SYSTEM_VERSION_


//判断手机是否是iPhone5等4英寸手机
#ifndef IS_IPHONE5
#define IS_IPHONE5 ( ( [[UIScreen mainScreen] bounds].size.height-568 ) ? NO : YES )
#endif //IS_IPHONE5


#define kUserDefaults [NSUserDefaults standardUserDefaults]
#define kDocumentPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]
#define kAccountFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]


#define kBaseURL @"http://openfire.25ren.com/"

#define BussinessChat_FCMobheaders_h
#endif

#define TICK NSDate *startTime = [NSDate date]
#define TOCK NSLog(@"exect TIme %f",-[startTime timeIntervalSinceNow])


