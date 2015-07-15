//
//  NSDateFormatter+FC.h
//  pinchehui
//
//  Created by zhisheshe on 15-3-16.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (FC)


+ (id)dateFormatter;
+ (id)dateFormatterWithFormat:(NSString *)dateFormat;

+ (id)defaultDateFormatter;         /*yyyy-MM-dd HH:mm:ss*/


@end
