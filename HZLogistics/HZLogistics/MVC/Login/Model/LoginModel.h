//
//  LoginModel.h
//  HZLogistics
//
//  Created by 宋学谦 on 2017/1/10.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

#import "BaseModel.h"

@interface LoginModel : BaseModel
@property (nonatomic, strong)NSString *user_name;
@property (nonatomic, strong)NSString *ceilphone;
@property (nonatomic, strong)NSString *avatar;
@property (nonatomic, strong)NSString *company_name;
@property (nonatomic, strong)NSString *user_pwd;
@property (nonatomic, strong)NSString *user_id;
@property (nonatomic, strong)NSString *company_id;
@property (nonatomic, strong)NSString *company_status;

@end
