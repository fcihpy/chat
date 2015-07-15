//
//  NSObject+FC.h
//  bussinessChat
//
//  Created by zhisheshe on 15-3-25.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (FC)


// 设置数据
- (void)setValues:(NSDictionary *)values;

- (void)setObjectIfNotNull:(id)anObject forKey:(id <NSCopying>)aKey;

@end
