//
//  JSONHelper.h
//  Houses
//
//  Created by Liang Zhang on 14/12/15.
//  Copyright (c) 2014年 bangbangtianxia. All rights reserved.


#import <Foundation/Foundation.h>

//Model Header File
//用户
#import "RegistUserModel.h"
#import "LoginModel.h"
#import "GetUserInfoModel.h"
#import "UploadAvatarModel.h"
//消息
#import "GetSysMsgInfoModel.h"
#import "GetSysMsgListModel.h"
#import "DeleteMsgModel.h"
//公司
#import "UploadListenPhotoModel.h"
#import "CreateNewCompanyModel.h"
#import "GetCompanyInfoModel.h"
//选择
#import "GetPortsListModel.h"
#import "GetPayTypeListModel.h"
#import "OrderSelectsModel.h"

//订单
#import "SubOrderModel.h"
#import "GetOrdersListModel.h"
#import "GetOrderInfoModel.h"
#import "orderCompleteModel.h"
#import "OrderStatusListModel.h"


//Api Name
typedef enum : NSUInteger {
    
    //用户
    ApiEnumRegistUser,//注册
    ApiEnumGetBackPwd,//找回
    ApiEnumLogin,//登陆(含自动登陆)
    ApiEnumGetUserInfo,//个人信息
    ApiEnumUploadAvatar,//上传头像
    
    //消息
    ApiEnumGetSysMsgInfo,//获取系统消息
    ApiEnumSysMsgList,//获取系统消息列表
    ApiEnumDeleteMsg,//删除消息

    //公司
    ApiEnumUploadListenPhoto,//上传营业执照照片
    ApiEnumCreateNewCompany,//提交公司审核信息
    ApiEnumGetCompanyInfo,//获取公司信息
    
    //选择
    ApiEnumPortsList,//获取港口列表
    ApiEnumPayTypeList,//获取支付列表
    ApiEnumOrderSelects,//获取审核状态列表
    
    //订单
    ApiEnumSubOrder,//下单
    ApiEnumGetOrdersList,//委托单列表
    ApiEnumGetOrderInfo,//委托单详情
    ApiEnumorderComplete,//确认收货
    ApiEnumOrderStatusList,//货物状态列表
    
    //推送
    ApiEnumSaveChannelId,//保存推送号

    ApiEnumNone,
} ApiEnum;


@interface JSONHelper : NSObject

+(id)jsonToModel:(id)modelObj Api:(ApiEnum)apienum Idx:(NSInteger)idx ImageURL:(NSString *)url;

@end
