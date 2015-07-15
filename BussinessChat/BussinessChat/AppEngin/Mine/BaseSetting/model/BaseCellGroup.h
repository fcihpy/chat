//
//  BaseCellGroup.h
//  BussinessChat
//
//  Created by 郑南 on 15-7-8.
//  Copyright (c) 2015年 firstChedai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseCellGroup : NSObject

@property (nonatomic,strong) NSString *groupHeadTitle;
@property (nonatomic,strong) NSString *groupFootTitle;
@property (nonatomic,strong) NSMutableArray *groupMemberArray;

- (instancetype)initWithGroupArrar:(NSArray *)groupArr;
@end
