//
//  GetUserInfoModel.h
//  HZLogistics
//
//  Created by 宋学谦 on 2017/1/10.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

#import "BaseModel.h"

@interface GetUserInfoModel : BaseModel


@property (nonatomic, strong)NSString *ceilphone;
@property (nonatomic, strong)NSString *company_id;
@property (nonatomic, strong)NSString *company_name;
@property (nonatomic, strong)NSString *company_status;
@property (nonatomic, strong)NSString *email;
@property (nonatomic, strong)NSString *gender;
@property (nonatomic, strong)NSString *last_login_ip;
@property (nonatomic, strong)NSString *last_login_time;
@property (nonatomic, strong)NSString *register_ip;
@property (nonatomic, strong)NSString *register_time;
@property (nonatomic, strong)NSString *user_avatar;
@property (nonatomic, strong)NSString *user_id;
@property (nonatomic, strong)NSString *user_name;
@property (nonatomic, strong)NSString *user_pwd;
@property (nonatomic, strong)NSString *user_status;
@end
