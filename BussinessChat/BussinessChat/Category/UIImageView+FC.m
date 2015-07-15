//
//  UIImageView+FC.m
//  bussinessChat
//
//  Created by zhisheshe on 15-3-25.
//  Copyright (c) 2015年 chepinzhidao. All rights reserved.
//

#import "UIImageView+FC.h"
#import <objc/runtime.h>

@implementation UIImageView (FC)

static const NSInteger kViewImageKey = 100;
static const NSInteger kViewUrlKey = 101;
- (void)setSrcImage:(UIImage *)aInfo {
    objc_setAssociatedObject(self, &kViewImageKey, aInfo, OBJC_ASSOCIATION_COPY);
}

- (UIImage *)srcImage {
    return (UIImage *)objc_getAssociatedObject(self, &kViewImageKey);
}
- (void)setUrl:(NSString *)aUrl {
    objc_setAssociatedObject(self, &kViewUrlKey, aUrl, OBJC_ASSOCIATION_COPY);
}

- (NSString *)url {
    return (NSString *)objc_getAssociatedObject(self, &kViewUrlKey);
}


@end
