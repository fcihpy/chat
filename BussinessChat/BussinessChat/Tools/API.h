//
//  API.h
//  pinchehui
//
//  Created by zhisheshe on 14-12-12.
//  Copyright (c) 2014年 zhisheshe. All rights reserved.
//

#ifndef pinchehui_API_h
#define pinchehui_API_h

//BASEURL
#define kBASEURL @"http://openfire.25ren.com/"
//-----------------------------------------------------登录注册----------------------------------------------------
//50、登录接口
#define kLOGIN   @"m=api&c=member&a=login"

//51、注册接口
#define kREGISTER   @"c=member&a=register"

//52、修改密码接口
#define kFOR   @"c=member&a=chgpass"

//53、忘记密码接口
#define kFORGET   @"c=member&a=getpass"

//54、手机验证码获得接口
#define kGETSMSCODE   @"c=sms&a=getpwdgetsmscode"

////55、手机验证码判断接口
//#define kPhone   @"c=sms&a=reggetsmscode"
//
////56、判断手机是否已注册接口
//#define kPhoneReg   @"c=common&a=getdata_bymobile"
//
////---------------------------------------------------车源------------------------------------------------------
////10、车源基本接口
//#define kCARRESOURCE    @"c=auto&a=getautolistbystatus"
//
////11、修改车輌接口
//#define kMODIFYCAR    @"c=auto&a=modifyauto"
//
////12、车輌筛选接口
//#define kCARRESOURCEFilter    @" "
//
////19、添加车辆
//#define kADDCAR    @"c=auto&a=addauto"
//
////50、登录接口
//#define kCARRESOURCE    @""
//
////50、登录接口
//#define kCARRESOURCE    @""
//
//#define kFAVORITECAR    @"m=api&c=Favorite&a=index"
////--------------------------------------------------------个人信息-------------------------------------------------
//
////11、获取个人信息接口
//#define KGETPERSON  @"c=member&a=getdata_byid"
//
////12、修改个人信息接口
//#define KMODIFYPERSON  @"c=member&a=modifymember"
//
////50、商户认证接口
//#define KGETPERSON  @"c=member&a=getdata_byid"
//
////50、上传头像接口
//#define kUPLOADHEARDPIC @"c=common&a=upload"
//
////根据多个ID查找用户信息
//
////50、登录接口
//#define kCARRESOURCE    @""
//
////50、反馈信息接口
//#define kFEEDBACK   @"c=guestbook&a=add"
////---------------------------------------------------------好友接口------------------------------------------------
//
//
//
//
////---------------------------------------------------------其它------------------------------------------------
////50、车辆图片上传接口
//#define kUPLOADCARPIC @"c=common&a=upload_autopic"
//
////50、获取省份城市接口
//#define kGETCITY @"c=district&a=getdata_byarg"
//
////50、获取车辆图片接口
//#define kUPLOADCARPIC @""
//
////50、获取车辆品牌接口
//#define kUPLOADCARPIC @"c=auto&a=getautobrand"
//
////50、查收是否收藏车辆接口
//#define kUPLOADCARPIC @""
//
////50、收藏车辆接口
//#define kUPLOADCARPIC @""

//50、我的收藏车辆接口
#define kUPLOADCARPIC @""

#define kHomeSlide  @"/api.php?m=api&c=Sysclassdata&a=getdate&codename=app_slide_flash_pic"


#endif
