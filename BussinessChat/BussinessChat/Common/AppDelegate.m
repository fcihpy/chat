//
//  AppDelegate.m
//  BaseProject
//
//  Created by zhisheshe on 15-3-25.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginController.h"

#import "FCNavigationController.h"
#import "NewfeatureController.h"

#import "RegisterStep1.h"
#import "RegisterStep2.h"

#import "PushSettingController.h"
#import "MoreInfoContrller.h"
#import "PersonInfoController.h"
#import "SettingController.h"
#import "MineController.h"
#import "FriendCircleContrller.h"
#import "XmppHelper.h"


@interface AppDelegate ()<NSStreamDelegate>

{
    NSDictionary    *_launchOptions;
    NSInputStream   *_inputStream;
    NSOutputStream  *_outputStream;
    
    
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _launchOptions = launchOptions;
    
    
    //添加登录状态监听
//  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStateChange:) name:KNOTIFICATION_LOGINCHANGE object:nil];
    
    [self loginStateChange:nil];
    
    [self.window makeKeyAndVisible];
    // 注册通知
    [self registerRemoteNotification];
    
    return YES;
}


- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    
    MyLog(@"safasfat %@---",notificationSettings);
    if (notificationSettings.types != UIUserNotificationTypeNone) {
        [self addLocalNotification];
        
    }
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    //    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0 ];

    [self addLocalNotification];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

    [self addLocalNotification];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [self loginStateChange:nil];
    [self addLocalNotification];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

//    [self loginStateChange:nil];

    [self addLocalNotification];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



////////////////////////////////////

#pragma mark ------------------------------------private method------------------

#pragma mark - 登录状态
- (void)loginStateChange:(NSNotification *)notification{
    
     [AccountTools sharedAccountTools].isLogin = NO;
     FCNavigationController *nav = nil;

    //版本信息获取
    NSString *versionKey = (NSString *)kCFBundleVersionKey;
    
    // 1.从Info.plist中取出版本号
    NSString *version = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    // 2.从沙盒中取出上次存储的版本号
    NSString *saveVersion = [[NSUserDefaults standardUserDefaults] objectForKey:versionKey];
    

    
    if ([version isEqualToString:saveVersion]) { // 不是第一次使用这个版本
        
        Account *account = [[AccountTools sharedAccountTools]getAccount];
        if(account.loginName.length>0 && account.loginPasswd.length >0)
        {
            [[XmppHelper sharedInstance] connectToServer];
            [UIApplication sharedApplication].keyWindow.rootViewController = [[FCNavigationController alloc]initWithRootViewController:[[MainController alloc]init]];
            [nav setNavigationBarHidden:NO];
            _mainController = [[MainController alloc] init];
            nav = [[FCNavigationController alloc] initWithRootViewController:_mainController];
        
        }
        else
        {
            _mainController = nil;
            
            //设置状态栏的样式
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
            
            LoginController *loginController = [[LoginController alloc] init];
            nav = [[FCNavigationController alloc] initWithRootViewController:loginController];
            
            nav.navigationBarHidden = YES;
        }
        /*
        if ([AccountTools sharedAccountTools].isLogin) {  //已经登录
      
        
            [[XmppHelper sharedInstance] connectToServer];

                [AccountTools sharedAccountTools].isLogin = YES;
              
                FCAlert([NSString stringWithFormat:@"欢迎回来1111111-%@",[AccountTools sharedAccountTools].account.loginName]);
 
                [UIApplication sharedApplication].keyWindow.rootViewController = [[FCNavigationController alloc]initWithRootViewController:[[MainController alloc]init]];
          
             [nav setNavigationBarHidden:NO];
            _mainController = [[MainController alloc] init];
            nav = [[FCNavigationController alloc] initWithRootViewController:_mainController];


        }else{                      //还没登录
            
            _mainController = nil;
            
            //设置状态栏的样式
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
            
            LoginController *loginController = [[LoginController alloc] init];
            nav = [[FCNavigationController alloc] initWithRootViewController:loginController];
            
            nav.navigationBarHidden = YES;

        }
         */
        
         self.window.rootViewController = nav;
        
    } else { // 版本号不一样：第一次使用新版本
        
        // 将新版本号写入沙盒 =
        [[NSUserDefaults standardUserDefaults] setObject:version forKey:versionKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //显示版本新特性界面
        //显示状态栏
        [UIApplication sharedApplication].statusBarHidden = YES;
        
        //设置状态栏的样式
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        NewfeatureController *newVC = [[NewfeatureController alloc]init];
        
        self.window.rootViewController = newVC;
        
    }
    
    
}

- (void)addUMSDK{
    
}



- (void)addLocalNotification{
    
    //创建本地通知对象
    //    UILocalNotification *localNotif = [[UILocalNotification alloc]init];
    //
    //
    //    //设置调度时间
    //    localNotif.fireDate = [NSDate dateWithTimeIntervalSinceNow:10.0];
    //    localNotif.repeatInterval = 10;
    //    localNotif.timeZone = [NSTimeZone defaultTimeZone];
    //    localNotif.repeatCalendar = [NSCalendar currentCalendar];
    //
    //    //设置属性
    //    localNotif.alertBody = @"您有一条消息";
    //    localNotif.applicationIconBadgeNumber = 3;;
    //    localNotif.alertAction = @"打开应用";
    //    localNotif.alertLaunchImage = @"Default";
    //    localNotif.soundName = UILocalNotificationDefaultSoundName;
    //    localNotif.soundName = @"default";
    //
    //    //设置用户附加消息
    //    //        localNotif.userInfo = @{ @"id":@1,@"user":@"fcihpy"};
    //
    //    //启用通知
    //    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    //
    
}

#pragma mark - 添加PUSH注册通知
- (void)registerRemoteNotification{
    
    //#if !TARGET_IPHONE_SIMULATOR
    UIApplication *application = [UIApplication sharedApplication];
    application.applicationIconBadgeNumber = 0;
    
    //iOS8 注册APNS
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [application registerForRemoteNotifications];
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge
            | UIUserNotificationTypeSound
            | UIUserNotificationTypeAlert;
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
        
    }else{
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeSound |
        UIRemoteNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
    }
    
    //#endif
    
}








@end
