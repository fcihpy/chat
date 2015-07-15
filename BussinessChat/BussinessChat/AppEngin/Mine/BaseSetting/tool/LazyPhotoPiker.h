//
//  LazyPhotoPiker.h
//  cutomPhtotoPiker
//
//  Created by LHC on 15/6/11.
//  Copyright (c) 2015年 LHC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol LazyPhotoPikerDelegate <NSObject>

-(void)didFinishPostSelectImage:(UIImage*)selectImage;

@end

@interface LazyPhotoPiker : NSObject<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong)UIViewController<LazyPhotoPikerDelegate>*delegateController;

-(void)presentPikerInController:(UIViewController<LazyPhotoPikerDelegate>*)viewController;

@end
