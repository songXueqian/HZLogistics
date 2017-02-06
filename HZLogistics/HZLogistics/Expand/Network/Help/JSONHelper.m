//
//  JSONHelper.m
//  Houses
//
//  Created by Liang Zhang on 14/12/15.
//  Copyright (c) 2014年 bangbangtianxia. All rights reserved.
//

#import "JSONHelper.h"
#import "NetworkHelper.h"

@implementation JSONHelper

+(id)jsonToModel:(id)modelObj Api:(ApiEnum)apienum Idx:(NSInteger)idx ImageURL:(NSString *)url {
    
    switch (apienum) {
            
        case ApiEnumRegistUser://注册
        {
            NSDictionary *dic = (NSDictionary *)modelObj;
            RegistUserModel *model = [[RegistUserModel alloc] init];
            model.user_pwd = [NetworkHelper makeModelValueWithKey:@"user_pwd" Model:dic Null:@""];
            model.user_id = [NetworkHelper makeModelValueWithKey:@"user_id" Model:dic Null:@""];
            return model;

        }
            break;
            
            
        case ApiEnumLogin://登陆(含自动登陆)
        {
            NSDictionary *dic = (NSDictionary *)modelObj;
            LoginModel *model = [[LoginModel alloc] init];
            model.user_name = [NetworkHelper makeModelValueWithKey:@"user_name" Model:dic Null:@""];
            model.ceilphone = [NetworkHelper makeModelValueWithKey:@"ceilphone" Model:dic Null:@""];
            model.company_name = [NetworkHelper makeModelValueWithKey:@"company_name" Model:dic Null:@""];
            model.user_pwd = [NetworkHelper makeModelValueWithKey:@"user_pwd" Model:dic Null:@""];
            model.user_id = [NetworkHelper makeModelValueWithKey:@"user_id" Model:dic Null:@""];
            model.avatar = [NSString stringWithFormat:@"%@%@", url,[NetworkHelper makeModelValueWithKey:@"avatar" Model:dic Null:@""]];
            model.company_id = [NetworkHelper makeModelValueWithKey:@"company_id" Model:dic Null:@""];
            model.company_status = [NetworkHelper makeModelValueWithKey:@"company_status" Model:dic Null:@""];

            
            return model;
        }
            break;
            
        case ApiEnumGetUserInfo://个人信息
        {
            NSDictionary *dic = (NSDictionary *)modelObj;
            GetUserInfoModel *model = [[GetUserInfoModel alloc] init];
            model.user_name = [NetworkHelper makeModelValueWithKey:@"user_name" Model:dic Null:@""];
            model.ceilphone = [NetworkHelper makeModelValueWithKey:@"ceilphone" Model:dic Null:@""];
            model.company_name = [NetworkHelper makeModelValueWithKey:@"company_name" Model:dic Null:@""];
            model.user_avatar = [NSString stringWithFormat:@"%@%@", url,[NetworkHelper makeModelValueWithKey:@"user_avatar" Model:dic Null:@""]];
            model.company_id = [NetworkHelper makeModelValueWithKey:@"company_id" Model:dic Null:@""];
            model.company_status = [NetworkHelper makeModelValueWithKey:@"company_status" Model:dic Null:@""];
            model.email = [NetworkHelper makeModelValueWithKey:@"email" Model:dic Null:@""];
            model.gender = [NetworkHelper makeModelValueWithKey:@"gender" Model:dic Null:@""];
            model.last_login_ip = [NetworkHelper makeModelValueWithKey:@"last_login_ip" Model:dic Null:@""];
            model.last_login_time = [NetworkHelper makeModelValueWithKey:@"last_login_time" Model:dic Null:@""];
            model.register_ip = [NetworkHelper makeModelValueWithKey:@"register_ip" Model:dic Null:@""];
            model.register_time = [NetworkHelper makeModelValueWithKey:@"register_time" Model:dic Null:@""];
            model.user_id = [NetworkHelper makeModelValueWithKey:@"user_id" Model:dic Null:@""];
            model.user_pwd = [NetworkHelper makeModelValueWithKey:@"user_pwd" Model:dic Null:@""];
            model.user_status = [NetworkHelper makeModelValueWithKey:@"user_status" Model:dic Null:@""];
                       
            return model;
        }
            break;
            
            
        case ApiEnumUploadAvatar://上传头像
        {
            NSDictionary *dic = (NSDictionary *)modelObj;
            UploadAvatarModel *model = [[UploadAvatarModel alloc] init];
            model.avatar = [NSString stringWithFormat:@"%@%@", url,[NetworkHelper makeModelValueWithKey:@"avatar" Model:dic Null:@""]];
            
            
            return model;
        }
            break;
            
        case ApiEnumGetBackPwd://找回
        {
            NSDictionary *dic = (NSDictionary *)modelObj;
            return dic;
        }
            break;
            
        case ApiEnumGetSysMsgInfo://获取系统消息
        {
            NSDictionary *dic = (NSDictionary *)modelObj;
            GetSysMsgInfoModel *model = [[GetSysMsgInfoModel alloc] init];
            model.msg_id = [NetworkHelper makeModelValueWithKey:@"msg_id" Model:dic Null:@""];
            model.msg_content = [NetworkHelper makeModelValueWithKey:@"msg_content" Model:dic Null:@""];
            model.msg_title = [NetworkHelper makeModelValueWithKey:@"msg_title" Model:dic Null:@""];
            model.from_user = [NetworkHelper makeModelValueWithKey:@"from_user" Model:dic Null:@""];
            model.from_user_name = [NetworkHelper makeModelValueWithKey:@"from_user_name" Model:dic Null:@""];
            model.add_time = [NetworkHelper makeModelValueWithKey:@"add_time" Model:dic Null:@""];
            
            
            return model;
        }
            break;

            
        case ApiEnumSysMsgList://获取系统消息列表
        {
            NSDictionary *dic = (NSDictionary *)modelObj;
            GetSysMsgListModel *model = [[GetSysMsgListModel alloc] init];
            model.msg_id = [NetworkHelper makeModelValueWithKey:@"msg_id" Model:dic Null:@""];
            model.msg_status = [NetworkHelper makeModelValueWithKey:@"msg_status" Model:dic Null:@""];
            model.msg_title = [NetworkHelper makeModelValueWithKey:@"msg_title" Model:dic Null:@""];
            model.from_user = [NetworkHelper makeModelValueWithKey:@"from_user" Model:dic Null:@""];
            model.from_user_name = [NetworkHelper makeModelValueWithKey:@"from_user_name" Model:dic Null:@""];
            model.add_time = [NetworkHelper makeModelValueWithKey:@"add_time" Model:dic Null:@""];
            
            
            return model;
        }
            break;
  
        case ApiEnumDeleteMsg://删除消息
        {
            NSDictionary *dic = (NSDictionary *)modelObj;
            return dic;
        }
            break;
            
        case ApiEnumUploadListenPhoto://上传营业执照照片
        {
            NSDictionary *dic = (NSDictionary *)modelObj;
            UploadListenPhotoModel *model = [[UploadListenPhotoModel alloc] init];
            model.company_business_listen = [NSString stringWithFormat:@"%@%@", url,[NetworkHelper makeModelValueWithKey:@"company_business_listen" Model:dic Null:@""]];
            
            
            
            return model;
        }
            break;
            
        case ApiEnumCreateNewCompany://提交公司审核信息
        {
            NSDictionary *dic = (NSDictionary *)modelObj;
            CreateNewCompanyModel *model = [[CreateNewCompanyModel alloc] init];
            model.company_id = [NetworkHelper makeModelValueWithKey:@"company_id" Model:dic Null:@""];
            
            
            return model;
        }
            break;

        case ApiEnumGetCompanyInfo://获取公司信息
        {
            NSDictionary *dic = (NSDictionary *)modelObj;
            GetCompanyInfoModel *model = [[GetCompanyInfoModel alloc] init];
            model.company_name = [NetworkHelper makeModelValueWithKey:@"company_name" Model:dic Null:@""];
            model.address = [NetworkHelper makeModelValueWithKey:@"address" Model:dic Null:@""];
            model.create_city = [NetworkHelper makeModelValueWithKey:@"create_city" Model:dic Null:@""];
            model.employees = [NetworkHelper makeModelValueWithKey:@"employees" Model:dic Null:@""];
            model.businesses = [NetworkHelper makeModelValueWithKey:@"businesses" Model:dic Null:@""];
            model.corporation = [NetworkHelper makeModelValueWithKey:@"corporation" Model:dic Null:@""];
            
            model.create_time = [NetworkHelper makeModelValueWithKey:@"create_time" Model:dic Null:@""];
            model.contact = [NetworkHelper makeModelValueWithKey:@"contact" Model:dic Null:@""];
            model.position = [NetworkHelper makeModelValueWithKey:@"position" Model:dic Null:@""];
            model.telphone = [NetworkHelper makeModelValueWithKey:@"telphone" Model:dic Null:@""];
            
            model.corporation_id_no = [NetworkHelper makeModelValueWithKey:@"corporation_id_no" Model:dic Null:@""];
            model.company_business_listen = [NetworkHelper makeModelValueWithKey:@"company_business_listen" Model:dic Null:@""];
            model.company_status = [NetworkHelper makeModelValueWithKey:@"company_status" Model:dic Null:@""];
            
            
            return model;
        }
            break;

        case ApiEnumPortsList://获取港口列表
        {
            NSDictionary *dic = (NSDictionary *)modelObj;
            GetPortsListModel *model = [[GetPortsListModel alloc] init];
            model.port_id = [NetworkHelper makeModelValueWithKey:@"port_id" Model:dic Null:@""];
            model.port_name = [NetworkHelper makeModelValueWithKey:@"port_name" Model:dic Null:@""];
            
            return model;
        }
            break;

        case ApiEnumPayTypeList://获取支付列表
        {
            NSDictionary *dic = (NSDictionary *)modelObj;
            GetPayTypeListModel *model = [[GetPayTypeListModel alloc] init];
            model.key = [NetworkHelper makeModelValueWithKey:@"key" Model:dic Null:@""];
            model.value = [NetworkHelper makeModelValueWithKey:@"value" Model:dic Null:@""];
            
            return model;
        }
            break;

        case ApiEnumOrderSelects://获取审核状态列表
        {
            NSDictionary *dic = (NSDictionary *)modelObj;
            OrderSelectsModel *model = [[OrderSelectsModel alloc] init];
            model.state_id = [NetworkHelper makeModelValueWithKey:@"state_id" Model:dic Null:@""];
            model.status_name = [NetworkHelper makeModelValueWithKey:@"status_name" Model:dic Null:@""];
            
            return model;
        }
            break;

            
        case ApiEnumSubOrder://下单
        {
            NSDictionary *dic = (NSDictionary *)modelObj;
            return dic;
        }
            break;
           
        case ApiEnumGetOrdersList://委托单列表
        {
            NSDictionary *dic = (NSDictionary *)modelObj;
            GetOrdersListModel *model = [[GetOrdersListModel alloc] init];
            model.order_id = [NetworkHelper makeModelValueWithKey:@"order_id" Model:dic Null:@""];
            model.order_no = [NetworkHelper makeModelValueWithKey:@"order_no" Model:dic Null:@""];
            model.company_name = [NetworkHelper makeModelValueWithKey:@"company_name" Model:dic Null:@""];
            model.shipper = [NetworkHelper makeModelValueWithKey:@"shipper" Model:dic Null:@""];
            model.consignee = [NetworkHelper makeModelValueWithKey:@"consignee" Model:dic Null:@""];
            model.notifier = [NetworkHelper makeModelValueWithKey:@"notifier" Model:dic Null:@""];
            model.cargo = [NetworkHelper makeModelValueWithKey:@"cargo" Model:dic Null:@""];
            model.amount = [NetworkHelper makeModelValueWithKey:@"amount" Model:dic Null:@""];
            model.weight = [NetworkHelper makeModelValueWithKey:@"weight" Model:dic Null:@""];
            model.volume = [NetworkHelper makeModelValueWithKey:@"volume" Model:dic Null:@""];
            model.export_time = [NetworkHelper makeModelValueWithKey:@"export_time" Model:dic Null:@""];
            model.delivery_time = [NetworkHelper makeModelValueWithKey:@"delivery_time" Model:dic Null:@""];
            model.loading_time = [NetworkHelper makeModelValueWithKey:@"loading_time" Model:dic Null:@""];
            model.arrive_time = [NetworkHelper makeModelValueWithKey:@"arrive_time" Model:dic Null:@""];
            model.loading_port = [NetworkHelper makeModelValueWithKey:@"loading_port" Model:dic Null:@""];
            model.unloading_port = [NetworkHelper makeModelValueWithKey:@"unloading_port" Model:dic Null:@""];
            model.destination_port = [NetworkHelper makeModelValueWithKey:@"destination_port" Model:dic Null:@""];
            model.special_requirements = [NetworkHelper makeModelValueWithKey:@"special_requirements" Model:dic Null:@""];
            model.cargoboat_name = [NetworkHelper makeModelValueWithKey:@"cargoboat_name" Model:dic Null:@""];
            model.cargoboat_voyage_no = [NetworkHelper makeModelValueWithKey:@"cargoboat_voyage_no" Model:dic Null:@""];
            model.payment_type = [NetworkHelper makeModelValueWithKey:@"payment_type" Model:dic Null:@""];
            model.add_time = [NetworkHelper makeModelValueWithKey:@"add_time" Model:dic Null:@""];
            model.add_user = [NetworkHelper makeModelValueWithKey:@"add_user" Model:dic Null:@""];
            model.status_name = [NetworkHelper makeModelValueWithKey:@"status_name" Model:dic Null:@""];
            
            return model;
        }
            break;

        case ApiEnumGetOrderInfo://委托单详情
        {
            NSDictionary *dic = (NSDictionary *)modelObj;
            GetOrderInfoModel *model = [[GetOrderInfoModel alloc] init];
            model.order_id = [NetworkHelper makeModelValueWithKey:@"order_id" Model:dic Null:@""];
            model.order_no = [NetworkHelper makeModelValueWithKey:@"order_no" Model:dic Null:@""];
            model.company_name = [NetworkHelper makeModelValueWithKey:@"company_name" Model:dic Null:@""];
            model.shipper = [NetworkHelper makeModelValueWithKey:@"shipper" Model:dic Null:@""];
            model.consignee = [NetworkHelper makeModelValueWithKey:@"consignee" Model:dic Null:@""];
            model.notifier = [NetworkHelper makeModelValueWithKey:@"notifier" Model:dic Null:@""];
            model.cargo = [NetworkHelper makeModelValueWithKey:@"cargo" Model:dic Null:@""];
            model.amount = [NetworkHelper makeModelValueWithKey:@"amount" Model:dic Null:@""];
            model.weight = [NetworkHelper makeModelValueWithKey:@"weight" Model:dic Null:@""];
            model.volume = [NetworkHelper makeModelValueWithKey:@"volume" Model:dic Null:@""];
            model.export_time = [NetworkHelper makeModelValueWithKey:@"export_time" Model:dic Null:@""];
            model.delivery_time = [NetworkHelper makeModelValueWithKey:@"delivery_time" Model:dic Null:@""];
            model.loading_time = [NetworkHelper makeModelValueWithKey:@"loading_time" Model:dic Null:@""];
            model.arrive_time = [NetworkHelper makeModelValueWithKey:@"arrive_time" Model:dic Null:@""];
            model.loading_port = [NetworkHelper makeModelValueWithKey:@"loading_port" Model:dic Null:@""];
            model.unloading_port = [NetworkHelper makeModelValueWithKey:@"unloading_port" Model:dic Null:@""];
            model.destination_port = [NetworkHelper makeModelValueWithKey:@"destination_port" Model:dic Null:@""];
            model.special_requirements = [NetworkHelper makeModelValueWithKey:@"special_requirements" Model:dic Null:@""];
            model.cargoboat_name = [NetworkHelper makeModelValueWithKey:@"cargoboat_name" Model:dic Null:@""];
            model.cargoboat_voyage_no = [NetworkHelper makeModelValueWithKey:@"cargoboat_voyage_no" Model:dic Null:@""];
            model.payment_type = [NetworkHelper makeModelValueWithKey:@"payment_type" Model:dic Null:@""];
            model.add_time = [NetworkHelper makeModelValueWithKey:@"add_time" Model:dic Null:@""];
            model.add_user = [NetworkHelper makeModelValueWithKey:@"add_user" Model:dic Null:@""];
            model.status_name = [NetworkHelper makeModelValueWithKey:@"status_name" Model:dic Null:@""];
            
            return model;
        }
            break;

        case ApiEnumorderComplete://确认收货
        {
            NSDictionary *dic = (NSDictionary *)modelObj;
            return dic;
        }
            break;
         
        case ApiEnumOrderStatusList://货物状态列表
        {
            NSDictionary *dic = (NSDictionary *)modelObj;
            OrderStatusListModel *model = [[OrderStatusListModel alloc] init];
            model.current_port = [NetworkHelper makeModelValueWithKey:@"current_port" Model:dic Null:@""];
            model.current_status = [NetworkHelper makeModelValueWithKey:@"current_status" Model:dic Null:@""];
             model.add_time = [NetworkHelper makeModelValueWithKey:@"add_time" Model:dic Null:@""];
            return model;
        }
            break;

            
        case ApiEnumSaveChannelId://保存推送号
        {
            NSDictionary *dic = (NSDictionary *)modelObj;
            return dic;
        }
            break;

        default:{
            return nil;
            
        }
            break;
    }
}

@end

