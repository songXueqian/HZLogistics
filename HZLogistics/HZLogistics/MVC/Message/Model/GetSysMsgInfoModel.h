//
//  GetSysMsgInfoModel.h
//  HZLogistics
//
//  Created by 宋学谦 on 2017/1/10.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

#import "BaseModel.h"

@interface GetSysMsgInfoModel : BaseModel
@property (nonatomic, strong)NSString *msg_id;
@property (nonatomic, strong)NSString *msg_content;
@property (nonatomic, strong)NSString *msg_title;
@property (nonatomic, strong)NSString *from_user;
@property (nonatomic, strong)NSString *from_user_name;
@property (nonatomic, strong)NSString *add_time;
@end
