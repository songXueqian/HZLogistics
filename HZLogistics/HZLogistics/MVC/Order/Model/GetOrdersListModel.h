//
//  GetOrdersListModel.h
//  HZLogistics
//
//  Created by 宋学谦 on 2017/1/10.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

#import "BaseModel.h"

@interface GetOrdersListModel : BaseModel
@property (nonatomic, strong)NSString *order_id;
@property (nonatomic, strong)NSString *order_no;
@property (nonatomic, strong)NSString *company_name;
@property (nonatomic, strong)NSString *shipper;
@property (nonatomic, strong)NSString *consignee;
@property (nonatomic, strong)NSString *notifier;
@property (nonatomic, strong)NSString *cargo;
@property (nonatomic, strong)NSString *amount;
@property (nonatomic, strong)NSString *weight;
@property (nonatomic, strong)NSString *volume;
@property (nonatomic, strong)NSString *export_time;
@property (nonatomic, strong)NSString *delivery_time;
@property (nonatomic, strong)NSString *loading_time;
@property (nonatomic, strong)NSString *arrive_time;
@property (nonatomic, strong)NSString *loading_port;
@property (nonatomic, strong)NSString *unloading_port;
@property (nonatomic, strong)NSString *destination_port;
@property (nonatomic, strong)NSString *special_requirements;
@property (nonatomic, strong)NSString *cargoboat_name;
@property (nonatomic, strong)NSString *cargoboat_voyage_no;
@property (nonatomic, strong)NSString *payment_type;
@property (nonatomic, strong)NSString *add_time;
@property (nonatomic, strong)NSString *add_user;
@property (nonatomic, strong)NSString *status_name;
@end
