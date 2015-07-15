/*!
 @header FCDeviceManagerNetworkDelegate.h
 @abstract DeviceManager网络相关的事件通知
 @author fcihpy.
 @version 1.00 2014/01/01 Creation (1.00)
 */


#import <Foundation/Foundation.h>
#import "FCNetworkMonitorDefs.h"

@protocol FCDeviceManagerNetworkDelegate <NSObject>

@optional

/*!
 @method
 @brief 网络状况发生变化的通知
 @param connectionType     新的网络状态
 @param fromConnectionType 上一次的网络状态
 @discussion
 @result
 */
- (void)didConnectionChanged:(FCConnectionType)connectionType
          fromConnectionType:(FCConnectionType)fromConnectionType;

@end
