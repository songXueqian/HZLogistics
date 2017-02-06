//
//  HZMessageViewController.h
//  HZLogistics
//
//  Created by 宋学谦 on 2016/12/29.
//  Copyright © 2016年 SongXueqian. All rights reserved.
//

#import "BaseViewController.h"

@interface HZMessageViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSString *typeString;
@property (nonatomic, strong)NSString *msgID;
@property (nonatomic, strong)NSIndexPath *indexPath;
@property (nonatomic, strong)UIImageView *picImage;
@end
