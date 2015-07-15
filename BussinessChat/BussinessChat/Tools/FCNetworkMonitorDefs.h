//
//  FCNetworkMonitorDefs.h
//  BussinessChat
//
//  Created by zhisheshe on 15-5-12.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#ifndef BussinessChat_FCNetworkMonitorDefs_h
#define BussinessChat_FCNetworkMonitorDefs_h

#pragma mark --连接状态
typedef NS_ENUM (NSUInteger,FCConnectionState){
    
    FCConnectionConnected,              //连接成功
    FCConnectionDisconnected,           //未连接
    
};

/*!
 @enum
 @brief 网络状态
 @constant FCConnectionType_None 没有网络连接
 @constant FCConnectionType_WWAN 使用蜂窝网络
 @constant FCConnectionType_WIFI 使用WIFI网络
 */

typedef NS_ENUM(NSInteger, FCConnectionType){
    
    FCConnectionType_None   = 0,
    FCConnectionType_WWAN   = 1,
    FCConnectionType_WIFI   = 2,
};


/*!
 @enum
 @brief 网络类型
 @constant FCConnectionName_Internet 网络连接
 @constant FCConnectionName_LocalWIFI 本地wifi
 @constant FCConnectionName_Default 网络连接
 */

typedef NS_ENUM(NSInteger, FCConnectionName) {
    FCConnectionName_Internet = 0,
    FCConnectionName_LocalWIFI,
    FCConnectionName_Default = eConnectionName_Internet
};



#endif
