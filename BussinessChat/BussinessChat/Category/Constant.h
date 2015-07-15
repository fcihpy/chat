//
//  Constant.h
//  cheduoduo
//
//  Created by wjl on 13-6-13.
//  Copyright (c) 2013年 ukantou. All rights reserved.
//

#ifndef cheduoduo_Constant_h
#define cheduoduo_Constant_h

//环信
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define KNOTIFICATION_LOGINCHANGE @"loginStateChange"
#define CHATVIEWBACKGROUNDCOLOR [UIColor colorWithRed:0.936 green:0.932 blue:0.907 alpha:1]
//

#define IMAX(a, b) ( ((a) > (b)) ? (a) : (b) )
#define IMIN(a, b) ( ((a) < (b)) ? (a) : (b) )
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define SYS_FONT(size) [UIFont systemFontOfSize:size]
#define SYS_BOLD_FONT(size) [UIFont boldSystemFontOfSize:size]

#define COLOR_BG UIColorFromRGB(0xf0f0f0)
#define COLOR_BG_GRAY UIColorFromRGB(0xf4f4f4)
#define COLOR_BG_TIPS UIColorFromRGB(0xf0f0f0)
#define COLOR_BLOCK_BG UIColorFromRGB(0xffffff)
#define COLOR_LINE UIColorFromRGB(0xd9d9d9)
#define COLOR_TEXT UIColorFromRGB(0x404040)
#define COLOR_TEXT_WHITE UIColorFromRGB(0xffffff)
#define COLOR_TOOLBAR_TEXT UIColorFromRGB(0xffffff)
#define COLOR_TIPS_TEXT UIColorFromRGB(0xbfbfbf)
#define COLOR_TIPS_TEXT_DEEP UIColorFromRGB(0x808080)
#define COLOR_DEEP_TEXT UIColorFromRGB(0x000000)
#define COLOR_HIGHLIGHT_TEXT UIColorFromRGB(0x2ba5d9)
#define COLOR_HIGHLIGHT_TEXT_ORANGE UIColorFromRGB(0xff7733)
#define COLOR_BTN_BG UIColorFromRGB(0xff7733)
#define COLOR_BTN UIColorFromRGB(0xffffff)
#define COLOR_zhu UIColorFromRGB(0x20a4dd)
#define COLOR_zi UIColorFromRGB(0x666666)

#define SCREEN_SIZE [[UIScreen mainScreen] bounds].size
#define NAV_BAR_HEIGHT 64
#define TAB_BAR_HEIGHT 44


#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define IMAGE_BACK_BUTTON [UIImage imageNamed:@"nav_btn_back"]

#define USER_UUID @"user_uuid"
#define CELL_ID_CITY @"cell_id_city"
#define CELL_ID_CAR @"cell_id_car"
#define CELL_ID_CAR_QUICK @"cell_id_car_quick"
#define CELL_ID_CAR_SERIES @"cell_id_car_series"
#define CELL_ID_CAR_MODEL @"cell_id_car_model"
#define CELL_ID_INDEX @"cell_id_index"
#define CELL_ID_CAR_MANAGER @"cell_id_car_manager"
#define CELL_ID_FRIEND @"cell_id_friend"
#define CELL_ID_NEW_FRIEND @"cell_id_new_friend"
#define CELL_ID_CITY_QUICK @"cell_id_city_quick"

#define EVENT_MASK_WINDOW @"event_mask_window"
#define EVENT_MASK_WINDOW_CLICK @"event_mask_window_click"

#define USER_DEFAULT_KEY_PHONE_LAST @"last_telephone"
#define USER_DEFAULT_KEY_CITY @"current_city"
#define USER_DEFAULT_KEY_CITY_INFO @"current_city_info"
#define USER_DEFAULT_KEY_LOCATION @"current_location"
#define USER_DEFAULT_KEY_PHONE @"telephone"
#define USER_DEFAULT_KEY_PASSWORD @"password"
#define USER_DEFAULT_KEY_AVATAR @"user_avatar"
#define USER_DEFAULT_KEY_USER_ID @"user_id"
#define USER_DEFAULT_KEY_USER_REALNAME @"user_realname"
#define USER_DEFAULT_KEY_CURRENT_TALK_USERNAME @"cur_talk_username"
#define USER_DEFAULT_KEY_CURRENT_TALK_USERID @"cur_talk_userid"
#define USER_DEFAULT_KEY_CURRENT_TALK_USERPHONE @"cur_talk_userphone"
#define USER_DEFAULT_KEY_CURRENT_TALK_USER_AVATAR @"cur_talk_user_avatar"
#define USER_DEFAULT_KEY_CURRENT_TALK_USER_authenticateType @"cur_talk_user_avatar_authenticateType"
#define USER_DEFAULT_KEY_TOKEN @"token"
#define USER_DEFAULT_CAR_ID @"car_id"
#define USER_DEFAULT_KEY_CONDITION @"condition"
#define USER_DEFAULT_KEY_BBS_CITY_NAME @"bbs_city_name"
#define USER_DEFAULT_KEY_BBS_CITY_ID @"bbs_city_id"
#define USER_DEFAULT_KEY_BBS_CITY_INFO @"bbs_city_info"
#define USER_DEFAULT_KEY_PUBLISH_CITY_INFO @"publish_city_info"
#define USER_DEFAULT_KEY_BBS_TYPE @"bbs_type"
#define USER_DEFAULT_KEY_BBS_POST_ID @"bbs_post_id"
// 设置项
#define USER_DEFAULT_KEY_SETTING_SUBSCRIBE_PUSH_NO @"setting_subscribe_push_no"
#define USER_DEFAULT_KEY_SETTING_SOUND_NO @"setting_sound_no"
#define USER_DEFAULT_KEY_SETTING_VIBRATION_NO @"setting_vibration_no"
// 首页是否需要强制刷新
#define USER_DEFAULT_KEY_NEED_REFRESH @"is_need_refresh"
#define USER_DEFAULT_KEY_NEED_REFRESH_CAR_MANAGER @"is_need_refresh_car_manager"
// 历史聊天记录key
#define USER_DEFAULT_HISTORY_MESSAGES @"history_messages"
// 车源上一次总量
#define USER_DEFAULT_CAR_SOURCE_LAST_COUNT @"carsource_last_count"
// 车源最新数量
#define USER_DEFAULT_CAR_SOURCE_NEWEST_COUNT @"carsource_newest_count"
// 好友动态上一次总量
#define USER_DEFAULT_FRIEND_TIMELINE_LAST_COUNT @"friend_timeline_last_count"
// 好友动态最新数量
#define USER_DEFAULT_FRIEND_TIMELINE_NEWEST_COUNT @"friend_timeline_newest_count"
#define USER_DEFAULT_FRIEND_TIMELINE_DELTA_COUNT @"friend_timeline_delta"

#define USER_DEFAULT_DTO_CAR @"dto_car"
#define USER_DEFAULT_DTO_CAR_DETAIL_SLIDE_CURRENT @"dto_car_detail_slide_current"
// 成功发布了车源
#define USER_DEFAULT_PUBLISH_CAR_SUCCESS @"publish_car_success"
#define USER_DEFAULT_PUBLISH_CAR_SUCCESS_ID @"publish_car_success_id"

#define USER_DEFAULT_KEY_PLAY_TUTORIAL_1 @"play_tutorial_1"
#define USER_DEFAULT_KEY_PLAY_TUTORIAL_2 @"play_tutorial_2"
#define USER_DEFAULT_KEY_PLAY_TUTORIAL_3 @"play_tutorial_3"
#define POP_SHOW_ID @"pop_show_id"
#define POP_SHOW_URL @"pop_url"
#define POP_SHOW_PIC_URL @"pop_pic_url"


#define POP_SHOW [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/popShow/getPopShow"]
//#define URL_SERVER @"http://127.0.0.1"
// 获取验证码
#define URL_USER_SMS [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/user/sendSmsCheckCode?telephone={telephone}"]
// 短信验证码验证
#define URL_USER_VERIFY [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/user/verifySmsCheckCode?telephone={telephone}&smsCheckCode={smsCode}"]
// 注册
#define URL_USER_REG [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/user/register"]
// 编辑
#define URL_USER_UPDATE [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/user/save"]
// 登录
#define URL_USER_LOGIN [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/user/login"]

//找回密码
#define URL_USER_BACK_PASSWORD [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/user/resetPassword"]
//找回密码验证码
#define URL_USER_SMS_REGIST_PASSWORD [NSString stringWithFormat:@"%@/%@",URL_SERVER,@"api/user/sendSmsCodeForRegistered"]




// 个人信息
#define URL_USER_PROFILE [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/user/getHomePageData"]
// 别人主页
#define URL_USER_OTHER_PROFILE [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/user/getOtherHomePageData"]
// 申请认证
#define URL_USER_APPLY_VIP [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/user/applyAuthenticate"]
// 获取官方帐号
#define URL_USER_GET_OFFICE_USER [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/user/getOfficialUser"]
// 根据id号批量获取用户信息，id号用逗号隔开
#define URL_USER_GET_BY_IDS [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/user/getUserInfoByUserIds"]
//添加渠道
#define URL_USER_ADDINFO  [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"/api/user/Addinfo"]
// 图片上传
#define URL_UPLOAD_IMAGE [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"upload/uploadImg"]
// 添加车源
#define URL_CREATE_CAR [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/carSource/saveCarSource"]
// 获取车源列表
#define URL_GET_CARS [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/carSource/getList"]
// 获取车源详情
#define URL_GET_CAR [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/carSource/getDetail"]
// 获取车源数量
#define URL_GET_CAR_COUNT [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/carSource/getCarSourceCountByStatus"]
// 刷新车源
#define URL_CAR_REFRESH [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/carSource/refresh"]
// 改变车源状态
#define URL_CAR_CHANGE_STATUS [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/carSource/changeStatus"]
// 添加订阅
#define URL_CREATE_SUBSCRIBE [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/subscription/addSubscription"]
// 取消订阅
#define URL_DELETE_SUBSCRIBE [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/subscription/cancelSubscription"]
// 获取订阅列表
#define URL_SUBSCRIBES [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/subscription/getList"]
// 判断订阅条件是否存在
#define URL_SUBSCRIBES_IS_EXISTS [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/subscription/IsExisted"]
// 查询订阅内容
#define URL_CARS_BY_SUBSCRIBE [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/subscription/getSearchList"]
// 订阅条件的所有的车源数量
#define URL_SUBSCRIBE_COUNT [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/subscription/getCarSourceCount"]
// 获取好友车源
#define URL_CARS_BY_FRIEND [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/friendShip/getFriendCarSourceList"]
// 添加收藏
#define URL_ADD_FAV_CAR [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/carSourceFav/addFav"]
// 取消收藏
#define URL_CANCEL_FAV_CAR [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/carSourceFav/removeFav"]
// 获取收藏列表
#define URL_FAV_CARS [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/carSourceFav/getFavCarSources"]
// 是否是我的好友
#define URL_FRIEND_ISFRIEND [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/friendShip/isMyFriend"]
// 添加好友
#define URL_FRIEND_ADD [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/friendShip/addFriend"]
// 好友列表
#define URL_FRIEND_List [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/friendShip/getFriendList"]
// 新好友列表
#define URL_FRIEND_NEW_List [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/friendShip/getNewFriendList"]
// 删除好友
#define URL_FRIEND_DELETE [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/friendShip/removeFriend"]
// 朋友的新车源数量
#define URL_FRIEND_CAR_SOURCE_COUNT [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/friendShip/getCarSourceCount"]
// BBS帖子列表
#define URL_BBS_POST_LIST [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/post/getPostList"]
// 当前用户BBS发帖子列表
#define URL_BBS_POST_LIST_CURRENT_USER [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/post/getMyPostList"]
// 当前用户BBS回复帖子列表
#define URL_BBS_POST_REPLY_LIST_CURRENT_USER [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/post/getMyReplyPostList"]
// BBS发帖
#define URL_BBS_POST_SAVE [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/post/savePost"]
// BBS帖子详情
#define URL_BBS_POST_DETAIL [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/post/getPost"]
// BBS帖子评论回复列表
#define URL_BBS_POST_REPLY [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/post/getPostReplyByPostId"]
// BBS帖子发布评论回复
#define URL_BBS_POST_REPLY_SAVE [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/post/savePostReply"]
// BBS获取当天的帖子数量以及全部的车商数量
#define URL_BBS_POST_SUMMARY [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/post/getTodayPostCount"]
// 删除帖子
#define URL_BBS_POST_DELETE [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/post/deletePost"]
//运营活动
// 删除帖子
#define URL_SEVER_OPERATE [NSString stringWithFormat:@"%@/%@",URL_SERVER, @"api/popShow/getPopShow"]


#define DATA_ALL_TYPE @{@"不限":@{@"不限":@{@"":@[]}}}

//#define UMENG_KEY @"541c20fafd98c51908007f44"
#define UMENG_KEY @"5421662bfd98c585910083f0"//测试key
#define URL_SERVER @"http://www.chedd.com"
//#define URL_SERVER @"http://test.techcar.com.cn"
#define SHARE_WX_URL_SERVER @"http://m.chedd.com"//微信分享
//#define SHARE_WX_URL_SERVER @"http://test.techcar.com.cn"


#define CHANNEL_NUMBER @"wap"
#define WX_APP_ID @"wxcdfd18b0d8020d78"
#define WX_APP_URL @"http://www.chedd.com"
#define EASEMOB_CER_NAME @"cheduoduo_push"
#define EASEMOB_KEY @"techcar#chedd"
#define ENTER_INTO_WAP @"http://www.baidu.com"


#define CALL_NOTIFICATION @"callToPhoneNumber"
#define INTO_WEB_NOTIFICATION @"intoWebView"

//#define filter_data_map @"{
//\"0_10-20万\":{\"priceMax\":\"20\",\"priceMin\":\"10\"},
//\"1_3-5年\":{\"ageMin\":\"5\",\"ageMax\":\"3\"},
//\"1_5年以上\":{\"ageMin\":\"\",\"ageMax\":\"5\"},
//\"2_里程少到多\":{\"orderBy\":\"mileage asc\"},
//\"2_默认排序\":{\"orderBy\":\"\"},
//\"2_最新发布\":{\"orderBy\":\"createdTime desc\"},
//\"2_年份近到远\":{\"orderBy\":\"registeredYear desc\"},
//\"0_不限\":{\"priceMax\":\"\",\"priceMin\":\"\"},
//\"0_5-10万\":{\"priceMax\":\"10\",\"priceMin\":\"5\"},
//\"0_20-50万\":{\"priceMax\":\"50\",\"priceMin\":\"20\"},
//\"0_50万以上\":{\"priceMax\":\"\",\"priceMin\":\"50\"},
//\"1_不限\":{\"ageMin\":\"\",\"ageMax\":\"\"},
//\"1_1年内\":{\"ageMin\":\"1\",\"ageMax\":\"0\"},
//\"1_1-3年\":{\"ageMin\":\"3\",\"ageMax\":\"1\"},
//\"2_价格低到高\":{\"orderBy\":\"price asc\"},
//\"0_5万以下\":{\"priceMax\":\"5\",\"priceMin\":\"\"},
//\"3_不限\":{\"mileageMin\":\"\",\"mileageMax\":\"\"},
//\"3_1万内\":{\"mileageMin\":\"0\",\"mileageMax\":\"1\"},
//\"3_1-5万\":{\"mileageMin\":\"1\",\"mileageMax\":\"5\"},
//\"3_5-10万\":{\"mileageMin\":\"5\",\"mileageMax\":\"10\"},
//\"3_10万以上\":{\"mileageMin\":\"10\",\"mileageMax\":\"\"}
//\"0_批发价\":{\"priceMax\":\"5\",\"priceMin\":\"\"}}"



#define filter_data_map @"{\"0_10-20万\":{\"priceMax\":\"20\",\"priceMin\":\"10\"},\"1_3-5年\":{\"ageMin\":\"5\",\"ageMax\":\"3\"},\"1_5年以上\":{\"ageMin\":\"\",\"ageMax\":\"5\"},\"2_里程少到多\":{\"orderBy\":\"mileage asc\"},\"2_默认排序\":{\"orderBy\":\"\"},\"2_最新发布\":{\"orderBy\":\"createdTime desc\"},\"2_年份近到远\":{\"orderBy\":\"registeredYear desc\"},\"0_不限\":{\"priceMax\":\"\",\"priceMin\":\"\"},\"0_5-10万\":{\"priceMax\":\"10\",\"priceMin\":\"5\"},\"0_20-50万\":{\"priceMax\":\"50\",\"priceMin\":\"20\"},\"0_50万以上\":{\"priceMax\":\"\",\"priceMin\":\"50\"},\"1_不限\":{\"ageMin\":\"\",\"ageMax\":\"\"},\"1_1年内\":{\"ageMin\":\"1\",\"ageMax\":\"0\"},\"1_1-3年\":{\"ageMin\":\"3\",\"ageMax\":\"1\"},\"2_价格低到高\":{\"orderBy\":\"price asc\"},\"0_5万以下\":{\"priceMax\":\"5\",\"priceMin\":\"\"},\"3_不限\":{\"mileageMin\":\"\",\"mileageMax\":\"\"},\"3_1万内\":{\"mileageMin\":\"0\",\"mileageMax\":\"1\"},\"3_1-5万\":{\"mileageMin\":\"1\",\"mileageMax\":\"5\"},\"3_5-10万\":{\"mileageMin\":\"5\",\"mileageMax\":\"10\"},\"3_10万以上\":{\"mileageMin\":\"10\",\"mileageMax\":\"\"}}"


//@{
//        @"0_不限": @{@"priceMin":@"", @"priceMax":@""},
//        @"0_5万以下": @{@"priceMin":@"", @"priceMax":@"5"},
//        @"0_5-10万": @{@"priceMin":@"5", @"priceMax":@"10"},
//        @"0_10-20万": @{@"priceMin":@"10", @"priceMax":@"20"},
//        @"0_20-50万": @{@"priceMin":@"20", @"priceMax":@"50"},
//        @"0_50万以上": @{@"priceMin":@"50", @"priceMax":@""},
//        @"1_不限": @{@"ageMin":@"", @"ageMax":@""},
//        @"1_1年内": @{@"ageMin":@"1", @"ageMax":@"0"},
//        @"1_1-3年": @{@"ageMin":@"3", @"ageMax":@"1"},
//        @"1_3-5年": @{@"ageMin":@"5", @"ageMax":@"3"},
//        @"1_5年以上": @{@"ageMin":@"", @"ageMax":@"5"},
//        @"2_默认排序": @{@"orderBy":@""},
//        @"2_最新发布": @{@"orderBy":@"createdTime desc"},
//        @"2_价格低到高": @{@"orderBy":@"price asc"},
//        @"2_里程少到多": @{@"orderBy":@"mileage asc"},
//        @"2_年份近到远": @{@"orderBy":@"registeredYear desc"}
//};
#endif
