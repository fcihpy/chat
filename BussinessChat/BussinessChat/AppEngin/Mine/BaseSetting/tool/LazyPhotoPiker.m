//
//  LazyPhotoPiker.m
//  cutomPhtotoPiker
//
//  Created by LHC on 15/6/11.
//  Copyright (c) 2015年 LHC. All rights reserved.
//

#import "LazyPhotoPiker.h"
#define PhotoString @"使用摄像头拍摄"
#define CarmeraString @"从手机相册选择"
#define CancleString @"取消"
@implementation LazyPhotoPiker

-(void)presentPikerInController:(UIViewController<LazyPhotoPikerDelegate> *)viewController
{
    UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:CancleString destructiveButtonTitle:nil otherButtonTitles:PhotoString,CarmeraString , nil];
    action.delegate=self;
    [action showInView:viewController.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc]init];
    imgPicker.delegate = self;
    //编辑模式
    imgPicker.allowsEditing = YES;
    
    switch (buttonIndex) {
        case 0:
            //使用摄像头拍摄
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                 [self.delegateController presentViewController:imgPicker animated:YES completion:nil];
                break;
            }
            else
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"手机不支持拍照" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
                [alert show];
            }
             break;
            
            
        case 1:              //从手机相册选择
            imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
             [self.delegateController presentViewController:imgPicker animated:YES completion:nil];
            break;
        default:
            return;
    }
    
   
    
}

- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated{
    
    [viewController.navigationItem setTitle:@"照片"];
    
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc ] initWithTitle:@"返回"
                                                                                        style:UIBarButtonItemStylePlain
                                                                                       target:self action:@selector(imageBack)];
    viewController.navigationItem.rightBarButtonItem=nil;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage * receiveImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    CGSize imageSize=receiveImage.size;
    
    receiveImage=[self imageWithImage:receiveImage scaledToSize:imageSize];
    NSData *imageData=UIImageJPEGRepresentation(receiveImage, 0.00001);
    UIImage *selectImage=[UIImage imageWithData:imageData];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        [self.delegateController didFinishPostSelectImage:selectImage];
    }];
}
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{

    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)imageBack {
    [self.delegateController dismissViewControllerAnimated:YES completion:^{}];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
