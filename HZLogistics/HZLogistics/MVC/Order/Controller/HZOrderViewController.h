//
//  HZOrderViewController.h
//  HZLogistics
//
//  Created by 宋学谦 on 2016/12/29.
//  Copyright © 2016年 SongXueqian. All rights reserved.
//

#import "BaseViewController.h"

@interface HZOrderViewController : BaseViewController<UISearchControllerDelegate, UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSMutableArray *order_noArray;
@property (nonatomic, strong)UIImageView *picImage;
@property (nonatomic, strong)UIButton *rightButton;//nav右按钮
@property (nonatomic, strong)UISearchController *searchController;
@property (nonatomic, strong)NSMutableArray *searchArray;
@property (nonatomic, strong)UIVisualEffectView *effectView;
@property (nonatomic, assign)NSInteger effectNum;
@property (nonatomic, strong)NSString *searchString;
@property (nonatomic, strong)NSString *addressString;
@property (nonatomic, strong)NSString *statuString;

@end
