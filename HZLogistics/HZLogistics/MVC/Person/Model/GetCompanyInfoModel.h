//
//  GetCompanyInfoModel.h
//  HZLogistics
//
//  Created by 宋学谦 on 2017/1/10.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

#import "BaseModel.h"

@interface GetCompanyInfoModel : BaseModel
@property (nonatomic, strong)NSString *company_name;
@property (nonatomic, strong)NSString *address;
@property (nonatomic, strong)NSString *create_city;
@property (nonatomic, strong)NSString *employees;
@property (nonatomic, strong)NSString *businesses;
@property (nonatomic, strong)NSString *corporation;
@property (nonatomic, strong)NSString *create_time;
@property (nonatomic, strong)NSString *contact;
@property (nonatomic, strong)NSString *position;
@property (nonatomic, strong)NSString *telphone;
@property (nonatomic, strong)NSString *corporation_id_no;
@property (nonatomic, strong)NSString *company_business_listen;
@property (nonatomic, strong)NSString *company_status;

@end
