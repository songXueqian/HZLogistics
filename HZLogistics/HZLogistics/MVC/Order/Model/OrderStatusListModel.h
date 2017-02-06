//
//  OrderStatusListModel.h
//  HZLogistics
//
//  Created by 宋学谦 on 2017/1/10.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

#import "BaseModel.h"

@interface OrderStatusListModel : BaseModel
@property (nonatomic, strong)NSString *current_port;
@property (nonatomic, strong)NSString *current_status;
@property (nonatomic, strong)NSString *add_time;

@end
